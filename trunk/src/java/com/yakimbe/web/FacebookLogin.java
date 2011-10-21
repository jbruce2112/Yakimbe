package com.yakimbe.web;

import com.yakimbe.model.User;
import javax.servlet.http.*;
import javax.servlet.*;
import java.io.IOException;
import javax.servlet.http.Cookie;
import com.restfb.FacebookException;
import java.sql.*;
import javax.sql.*;
import java.util.Map;
import java.util.HashMap;
import java.util.List;
import java.util.ArrayList;

/**
 *
 * @author John
 */
public class FacebookLogin extends HttpServlet {

    private static DataSource dsn = null;
    private static ServletContext ctx = null;
    private static String appID = "";
    private static String appSecretID = "";
    private static final String baseURL = "https://graph.facebook.com/oauth/";

    @Override
    public void init(ServletConfig sc) {
        ctx = sc.getServletContext();
        dsn = (DataSource) ctx.getAttribute("dsn");
        appID = ctx.getInitParameter("appID");
        appSecretID = ctx.getInitParameter("appSecretID");
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /** 
     * Handles the HTTP <code>GET</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
                                                throws ServletException, IOException {

        User user = (User) req.getSession().getAttribute("user");
        Cookie[] cookies = req.getCookies();
        Cookie fbCook = null;
        boolean hasYakimbeAccount = req.getParameter("exist") != null;
        String exist = hasYakimbeAccount ? "?exist=true" : "";

         for (Cookie c : cookies) {
            if (c.getName().startsWith("fbs")) {
                fbCook = c;
                break;
            }
        }

        if (req.getParameter("code") == null) {
            String redir = res.encodeRedirectURL(baseURL+"authorize?client_id=" + appID+"&redirect_uri=http://localhost/fblogin"+exist);
            res.sendRedirect(redir);
        }
        else if(req.getParameter("access_token") == null) {

            final String code = req.getParameter("code");
            final String fetchMe = baseURL+"access_token?client_id="+appID+"&redirect_uri=http://localhost/fblogin"+exist+"&client_secret="+appSecretID+"&code="+code;

            java.net.URL fetchURL = new java.net.URL(fetchMe);
            java.io.BufferedReader in = new java.io.BufferedReader( new java.io.InputStreamReader( fetchURL.openStream()));
            String inputLine;
            StringBuilder result = new StringBuilder();
            String accessToken = null;

            while ((inputLine = in.readLine()) != null) {
                result.append(inputLine);
            }

            String[] resultVals = result.toString().split("&");

            for (int i=0; i < resultVals.length; i++) {
                if (resultVals[i].startsWith("access_token")) {
                    accessToken = resultVals[i].split("=")[1];
                    break;
                }
            }
            in.close();

            if (accessToken != null) {
                req.getSession().setAttribute("OA2AccessToken", accessToken);
                ctx.log("got token! its " + accessToken);
            }

            if (user == null && fbCook != null) {

                String[] fbVals = fbCook.getValue().split("&");
                String fbID = null;
                for (String val : fbVals) {
                    if (val.startsWith("uid=")) {
                        fbID = val.replace("uid=", "");
                        ctx.log("the uid is " + fbID);
                    }
                }

                if (fbID != null && accessToken != null) {

                    User fbUser = null;
                    boolean isExistingUser = false;
                    try {

                        fbUser = com.yakimbe.web.GetUserServlet.getFacebookInfo(fbID, accessToken);

                        // get remaining info from our database
                        Connection conn = null;

                        try {
                            conn =  dsn.getConnection();
                            isExistingUser = getAdditionalInfo(fbUser, conn);

                            // if they've already hooked their facebook ID into their yak account
                            if (isExistingUser) {
                                req.getSession().setAttribute("user",fbUser);
                            }
                            else if (hasYakimbeAccount) {

                                final List<String> messages = new ArrayList<String>();
                                messages.add("Please enter your existing user name and password with us to use your facebook login.");
                                messages.add("You'll only have to do this once.");
                                
                                req.setAttribute("messages", messages);
                                req.getSession().setAttribute("hookWithFBAccount", true);
                                req.getSession().setAttribute("hookWithFBID", fbID);
                                req.getRequestDispatcher("/userlogin").forward(req, res);
                            }
                            else {

                                List<String> messages = new ArrayList<String>();
                                messages.add("Please pick a user name");
                                req.getSession().setAttribute("attemptFbUser",fbUser);
                                req.getSession().setAttribute("attemptFbID",fbID);

                                RequestDispatcher rd = req.getRequestDispatcher("/newuser");
                                rd.forward(req, res);
                                
                            }
                        }
                        catch (SQLException e) {
                            ctx.log("SQL Exception " + e.getMessage());
                        }
                        finally {
                            try {
                                conn.close();
                            }
                            catch (Exception e) {}
                        }

                    }
                    catch (FacebookException e) {
                        ctx.log("Facebook exception for cookie " + e.getMessage());
                    }
                    if (isExistingUser)
                        res.sendRedirect("/");
                }
            }
        }
    }
    
    protected static boolean getAdditionalInfo(final User fbUser, final Connection conn) throws SQLException {

        final String query = "SELECT * FROM user WHERE fb_id = ?";
        PreparedStatement ps = null;
        PreparedStatement psUserActions = null;
        ResultSet rs = null;
        ResultSet rsUserActions = null;
        ps = conn.prepareStatement(query);
        ps.setString(1, fbUser.getFacebookID());
        rs = ps.executeQuery();

        // no yakimbe account.
        if (!rs.next()) {
            return false;
        }
        else {
            final String userName = rs.getString("user_name");
            final int rating = rs.getInt("rating");
            final int uID = rs.getInt("user_id");
            final boolean isAdmin = rs.getBoolean("is_admin");
            final int itemsPerPage = rs.getInt("items_per_page");
            final java.sql.Date regDate = rs.getDate("registration_date");

            psUserActions = conn.prepareStatement("SELECT a.item_id, a.action_type FROM action a WHERE a.user_id = ?");
            psUserActions.setInt(1, uID);

            rsUserActions = psUserActions.executeQuery();

            Map<String, String> mapUserActions = new HashMap<String, String>();

            rsUserActions.beforeFirst();

            while(rsUserActions.next()) {
                long itemId = rsUserActions.getLong("item_id");
                String type = rsUserActions.getString("action_type");
                mapUserActions.put(String.valueOf(itemId), type);
            }

            fbUser.setUserName(userName);
            fbUser.setRating(rating);
            fbUser.setUserActions(mapUserActions);
            fbUser.setAdmin(isAdmin);
            fbUser.setNumItemsPage(itemsPerPage);
            fbUser.setRegistrationDate(regDate);
            fbUser.setUserId(uID);

            return true;
        }
    }
}
