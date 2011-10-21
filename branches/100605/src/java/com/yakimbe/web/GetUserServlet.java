package com.yakimbe.web;

import com.yakimbe.model.User;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import java.util.Map;
import java.util.HashMap;
import java.util.List;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.sql.DataSource;

public class GetUserServlet extends HttpServlet {

    private ServletContext ctx;
    private DataSource dsn;

    @Override
    public void init() {
        ctx = this.getServletContext();
        dsn = (DataSource)ctx.getAttribute("dsn");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
                                                throws ServletException, IOException {

        boolean userJustVerifiedAccount = false;
        boolean isLoggedInUser = false;
        User returnedUser = null;
        String requestURL = request.getRequestURI();
        //TODO: Pull this the reqs for the username regex from 1 loc
        Pattern p = Pattern.compile("(?i)[a-z0-9_-]+(?=[/]?[?0-9]?$)");
        Matcher m = p.matcher(requestURL);

        m.find();
        String requestedUser = m.group();

        User currentUser = (User) request.getSession().getAttribute("user");

        //send the user back home if there wasn't a user specified for the profile
        if (requestedUser.equals("user") || requestedUser.length() < 1) {
            response.sendRedirect(response.encodeRedirectURL("/"));
        }
        else {
            if (currentUser != null && currentUser.getUserName().equalsIgnoreCase(requestedUser)) {
                isLoggedInUser = true;
                returnedUser = currentUser;
            }
            // user is verifying their e-mail address
            else if (request.getParameter("verif") != null) {

                try {
                    Connection connection = null;
                    try {
                         connection = dsn.getConnection();

                        PreparedStatement psVerify = connection.prepareStatement("SELECT u.user_name, u.is_account_verified FROM user u WHERE u.user_name = ?");

                        psVerify.setString(1, requestedUser);

                        ResultSet result = psVerify.executeQuery();

                        result.beforeFirst();
                        result.next();
                        String returnedUserName = result.getString("user_name");
                        long returnedIsAccountVerified = result.getLong("is_account_verified");

                        if (returnedUserName.equalsIgnoreCase(requestedUser) && returnedIsAccountVerified != 1) {
                            ctx.log("CONGRATS, LET'S VERIFY YOU NOW!");
                            PreparedStatement psUpdate = connection.prepareStatement("UPDATE user SET is_account_verified = 1 WHERE user_name = ?");

                            psUpdate.setString(1, requestedUser);

                            int rowsModified = psUpdate.executeUpdate();

                            ctx.log("Ok, updated, rows modified: " + rowsModified);

                            if (rowsModified > 0) {
                                userJustVerifiedAccount = true;
                                request.setAttribute("userStatus", "verificationSuccess");

                                synchronized (ctx) {
                                    PreparedStatement psGetBeta1UserCount = connection.prepareStatement("SELECT beta1_user_count FROM beta");
                                    ResultSet rsBeta1UserCount = psGetBeta1UserCount.executeQuery();
                                    rsBeta1UserCount.next();
                                    int userCount = rsBeta1UserCount.getInt("beta1_user_count");
                                    ctx.log("current beta1 users: " + userCount);
                                    userCount++;
                                    PreparedStatement psUpdateBeta1UserCount = connection.prepareStatement("UPDATE beta SET beta1_user_count = ?");
                                    psUpdateBeta1UserCount.setInt(1, userCount);
                                    psUpdateBeta1UserCount.executeUpdate();
                                }
                            }
                        }
                        else {
                            //TODO: handle the case where the user is already verified
                        }
                    }
                    catch (SQLException ex) {
                        ctx.log(ex.getMessage());
                    }
                    finally {
                        try {
                            connection.close();
                        }
                        catch (Exception e) {}
                    }
                }
                catch (NumberFormatException ex) {
                    response.sendError(response.SC_NOT_ACCEPTABLE);
                }
            }
            else {

                Connection connection = null;
                PreparedStatement psGetUser = null;
                PreparedStatement psUserActions = null;
                ResultSet rsUser = null;

                try {
                    connection = dsn.getConnection();
                    
                    psGetUser = connection.prepareCall("SELECT * FROM user WHERE user_name = ?");

                    psGetUser.setString(1,requestedUser);

                    rsUser = psGetUser.executeQuery();

                    rsUser.beforeFirst();
                    rsUser.next();

                    int uID = rsUser.getInt("user_id");
                    String uName = rsUser.getString("user_name");
                    String fName = rsUser.getString("first_name");
                    String lName = rsUser.getString("last_name");
                    String email = rsUser.getString("email");
                    String desc = rsUser.getString("description");
                    String loc = rsUser.getString("location");
                    String sex = rsUser.getString("sex");
                    java.sql.Date regDate = rsUser.getDate("registration_date");
                    String website = rsUser.getString("web_site");
                    int itemsPerPage = rsUser.getInt("items_per_page");
                    int birthYear = rsUser.getInt("birth_year");
                    boolean isAdmin = rsUser.getBoolean("is_admin");
                    boolean isEmailOptedIn = rsUser.getBoolean("email_opt_in");

                    psUserActions = connection.prepareStatement("SELECT a.item_id, a.action_type FROM action a WHERE a.user_id = ?");
                    psUserActions.setInt(1,uID);

                    ResultSet rsUserActions = psUserActions.executeQuery();

                    Map<String, String> mapUserActions = new HashMap<String, String>();

                    rsUserActions.beforeFirst();

                    while(rsUserActions.next()) {

                        long itemId = rsUserActions.getLong("item_id");
                        String type = rsUserActions.getString("action_type");
                        mapUserActions.put(String.valueOf(itemId), type);
                    }

                    returnedUser = new User(uID, uName, fName, lName, desc,
                                       website, email, regDate, loc, itemsPerPage,
                                       isAdmin,sex,birthYear,isEmailOptedIn, mapUserActions);
                    
                }

                catch (SQLException ex) {
                    ctx.log("Error executing get user\n" + ex.getCause());
                }
                finally {

                    try {
                        rsUser.close();
                        psUserActions.close();
                        psGetUser.close();
                        connection.close();
                    }
                    catch (SQLException ex) {}
                }
            }
            if (userJustVerifiedAccount) {
                request.getRequestDispatcher("/login.jsp").forward(request, response);
            }
            else {
                request.setAttribute("returnedUser", returnedUser);
                request.setAttribute("isLoggedInUser", isLoggedInUser);
                request.getRequestDispatcher("/userprofile.jsp").forward(request, response);
            }
        }
    }
}
