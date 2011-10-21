
package com.yakimbe.web;

import com.yakimbe.util.BCrypt;
import com.yakimbe.model.Notification;
import com.yakimbe.model.User;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.HashMap;
import javax.mail.*;
import javax.mail.internet.*;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.sql.DataSource;
import java.util.Calendar;

public class LoginServlet extends HttpServlet {

    ServletContext ctx;
    DataSource dsn;

    @Override
    public void init() throws ServletException{
        ctx = this.getServletContext();
        dsn = (DataSource)ctx.getAttribute("dsn");
    }

    // LOGOUT - <a>logout</a> triggers the GET method
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        if ((request.getSession().getAttribute("user") != null) && ((String) request.getParameter("logout")).equals("true")) {
            request.getSession().invalidate();
        }
        response.sendRedirect(response.encodeRedirectURL("/"));
    }

    // LOGIN
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
                                                throws ServletException, IOException {
        boolean isUserVerified = false;

        Connection connection = null;
        PreparedStatement psUserLogin = null;
        PreparedStatement psUserActions = null;
        ResultSet rsUserLogin = null;
        User returnedUser = null;

        List<String> listLoginErrors = new ArrayList<String>();

        String strUserName = request.getParameter("loginUserName");
        String strPassword = request.getParameter("loginPassword");

        //TODO: move this 'validation' to ValidateInput & make it awesomer.
        if (!strUserName.isEmpty() && !strPassword.isEmpty()) {
            try {
                connection = dsn.getConnection();
                connection.setAutoCommit(false);

                psUserLogin = connection.prepareCall("SELECT * FROM user u WHERE u.user_name = ?");

                psUserLogin.setString(1, strUserName);

                rsUserLogin = psUserLogin.executeQuery();

                synchronized (request.getSession()) {
                    connection.commit();
                }

                rsUserLogin.beforeFirst();

                boolean userExists = rsUserLogin.next();
                boolean passwordsMatch = false;

                if (userExists) {
                    int uID = rsUserLogin.getInt("user_id");
                    String uName = rsUserLogin.getString("user_name");
                    String pw = rsUserLogin.getString("pw");
                    String fName = rsUserLogin.getString("first_name");
                    String lName = rsUserLogin.getString("last_name");
                    String email = rsUserLogin.getString("email");
                    String desc = rsUserLogin.getString("description");
                    String loc = rsUserLogin.getString("location");
                    String sex = rsUserLogin.getString("sex");
                    java.sql.Date regDate = rsUserLogin.getDate("registration_date");
                    String website = rsUserLogin.getString("web_site");
                    int itemsPerPage = rsUserLogin.getInt("items_per_page");
                    int birthYear = rsUserLogin.getInt("birth_year");
                    boolean isAdmin = rsUserLogin.getBoolean("is_admin");
                    long isAccountVerified = rsUserLogin.getLong("is_account_verified");
                    boolean isEmailOptedIn = rsUserLogin.getBoolean("email_opt_in");

                    psUserActions = connection.prepareStatement("SELECT a.item_id, a.action_type FROM action a WHERE a.user_id = ?");
                    psUserActions.setInt(1,uID);

                    ResultSet rsUserActions = psUserActions.executeQuery();

                    //EL doesn't allow us to use integers for keys in maps, and it would be dumb to
                    // have arrays dozens of times larger than what they would contain, so we'll coerce
                    // the item_id integer to a String.
                    Map<String, String> mapUserActions = new HashMap<String, String>();

                    rsUserActions.beforeFirst();

                    while(rsUserActions.next()) {

                        int itemId = rsUserActions.getInt("item_id");
                        String type = rsUserActions.getString("action_type");
                        mapUserActions.put(String.valueOf(itemId), type);
                    }
                    //verify PW
                    // TODO: is this correct? Should we even be in the situtation where this could
                    // throw this? (illegal salt version when password cleartext password is wrong....sometimes)
                    try {
                        passwordsMatch = BCrypt.checkpw(strPassword, pw);
                    }
                    catch (IllegalArgumentException ex) {
                        ctx.log(ex.getMessage());
                    }

                    if (passwordsMatch) {
                        if (isAccountVerified == 1) {

                            isUserVerified = true;

                            returnedUser = new User(uID, uName, fName, lName, desc,
                                               website, email, regDate, loc, itemsPerPage, isAdmin, sex, birthYear, isEmailOptedIn, mapUserActions);
                                               

                            //user notifications
                            returnedUser.setNotifications(this.getNotifications(request, connection, uID));

                            ctx.log("User login: " + uName);
                            request.getSession().setAttribute("user", returnedUser);
                        }
                        else {
                            isUserVerified = false;
                            request.setAttribute("userName", uName);
                            request.setAttribute("userStatus", "accountUnverified");
                        }
                    }
                }

                //resultset empty (user doesn't exist) or password match failed
                if (!userExists || !passwordsMatch) {
                    listLoginErrors.add("Invalid user name and/or password");
                    request.setAttribute("loginErrors",listLoginErrors);
                }

            } catch (SQLException ex) {
                ex.printStackTrace();
                ctx.log("login exception :" + ex.getMessage());
            }
            finally {
                    try {
                        connection.close();
                        rsUserLogin.close();
                        psUserLogin.close();
                    }
                    catch (Exception e) {}
            }
        }

        if (listLoginErrors.isEmpty() && isUserVerified) {
/*
            //store cookie if they wanted to
            String thingy = com.yakimbe.util.BCrypt.hashpw(strUserName, com.yakimbe.util.BCrypt.gensalt());
            Calendar cal = Calendar.getInstance();
            cal.setTime(new java.util.Date());
            cal.add(Calendar.YEAR, 1);
            ctx.log("Hello " + thingy);
            String cookieValue = strUserName+"||"+thingy;
            ctx.log("Setting cookie value " + cookieValue);
            javax.servlet.http.Cookie c = new javax.servlet.http.Cookie("test", "cookie");
            response.setHeader("Set-Cookie", "user="+ cookieValue+"; expires="+cal.getTime().toGMTString()+"; HttpOnly");
*/
            //Stored if the user was trying to do something they needed to be logged in for.
            String originallyRequestedURL = (String) request.getSession().getAttribute("originallyRequestedURL");

            String redirectToVerificationPage = request.getParameter("showVerificationPage");

            final List<User> currentUsers = (ArrayList) ctx.getAttribute("currentUsers");
            currentUsers.add(returnedUser);

            if (originallyRequestedURL != null) {
                response.sendRedirect(response.encodeRedirectURL(originallyRequestedURL));
            }
            else if (redirectToVerificationPage != null && redirectToVerificationPage.equals("true")) {
                response.sendRedirect(response.encodeRedirectURL(response.encodeRedirectURL("/firstlogin")));
            }
            else {
                response.sendRedirect(response.encodeRedirectURL("/"));
            }
        }
        else {
            request.getRequestDispatcher("/userlogin").forward(request, response);
        }
    }

    static protected Map<String,List> getNotifications(HttpServletRequest req, Connection conn, int userId) {

        Map<String,List> notifications = new HashMap<String,List>();

        List<Notification> itemNotifications = new ArrayList<Notification>();
        List<Notification> commentNotifications = new ArrayList<Notification>();
        
        PreparedStatement psItemNotifications = null;
        PreparedStatement psCommentNotifications = null;
        ResultSet rsItemNotifications = null;
        ResultSet rsCommentNotifications = null;

        try {
            final String query = "SET @submissionid = 0";
            conn.prepareStatement(query).executeQuery();

            final String query2 = "SET @commentId = 0";
            conn.prepareStatement(query2).executeQuery();

            final String query3 = "SET @parentCId = 0";
            conn.prepareStatement(query3).executeQuery();

            final StringBuilder commentNotificationsQuery = new StringBuilder();
            commentNotificationsQuery.append("SELECT @commentId := c.comment_id, i.item_id, @submissionid := c.item_commenting_on_id item_commenting_on_id, i.submission_time, @parentCId := c.parent_comment_id, ");
            commentNotificationsQuery.append("(SELECT l.headline FROM link l WHERE l.item_id = @submissionid) headline, ");
            commentNotificationsQuery.append("(SELECT COUNT(*) FROM comment c INNER JOIN item i ON c.item_id = i.item_id WHERE c.parent_comment_id = @parentCId and i.is_user_notified = 0) num_replies ");
            commentNotificationsQuery.append("FROM item i INNER JOIN comment c ON i.item_id = c.item_id ");
            commentNotificationsQuery.append("WHERE c.parent_comment_id IN (SELECT comment_id FROM comment c INNER JOIN item i ON c.item_id = i.item_id WHERE i.user_id = ?) AND ");
            commentNotificationsQuery.append("i.is_user_notified = 0 GROUP BY c.parent_comment_id ORDER BY headline, i.submission_time DESC");

            psCommentNotifications = conn.prepareStatement(commentNotificationsQuery.toString());
            psCommentNotifications.setInt(1, userId);

            final StringBuilder itemNotificationsQuery = new StringBuilder();
            itemNotificationsQuery.append("SELECT @submissionId := i.item_id item_id, i.submission_time, l.headline, ");
            itemNotificationsQuery.append("(SELECT COUNT(*) FROM comment c INNER JOIN item i ON i.item_id = c.item_id ");
            itemNotificationsQuery.append("WHERE c.item_commenting_on_id = @submissionId AND c.parent_comment_id IS NULL AND i.is_user_notified = 0) num_replies ");
            itemNotificationsQuery.append("FROM item i INNER JOIN link l ON i.item_id = l.item_id WHERE i.user_id = ?");
            
            psItemNotifications = conn.prepareStatement(itemNotificationsQuery.toString());
            psItemNotifications.setInt(1, userId);

            synchronized (req.getSession()) {
                rsCommentNotifications = psCommentNotifications.executeQuery();
                rsItemNotifications = psItemNotifications.executeQuery();
            }

            rsCommentNotifications.beforeFirst();

            // TODO: why the fuck can't this be a condition in the query?
            while (rsCommentNotifications.next()) {
                if (rsCommentNotifications.getInt("num_replies") > 0) {
                    final long itemId = rsCommentNotifications.getLong("item_id");
                    final java.sql.Timestamp time = rsCommentNotifications.getTimestamp("submission_time");

                    Notification notification = new Notification(itemId, time);

                    notification.setItemCommentingOnId(rsCommentNotifications.getLong("item_commenting_on_id"));
                    notification.setItemCommentingOnHeadline(rsCommentNotifications.getString("headline"));
                    notification.setNumReplies(rsCommentNotifications.getInt("num_replies"));
                    commentNotifications.add(notification);
                }
            }

            notifications.put("comment", commentNotifications);

            rsItemNotifications.beforeFirst();

            while (rsItemNotifications.next()) {
                if (rsItemNotifications.getInt("num_replies") > 0) {
                    final long itemId = rsItemNotifications.getLong("item_id");
                    final java.sql.Timestamp time = rsItemNotifications.getTimestamp("submission_time");

                    Notification notification = new Notification(itemId, time);
                    notification.setItemHeadline(rsItemNotifications.getString("headline"));
                    notification.setNumReplies(rsItemNotifications.getInt("num_replies"));

                    itemNotifications.add(notification);
                }
            }
            notifications.put("item", itemNotifications);
        }
        catch (SQLException ex) {
        }
        finally {
            try {
                rsItemNotifications.close();
                rsCommentNotifications.close();
                psItemNotifications.close();
                psCommentNotifications.close();
            }
            catch(Exception e) {}
        }

        return notifications;
    }
}