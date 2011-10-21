package com.yakimbe.filter;

import com.yakimbe.model.User;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.ServletException;
import java.io.IOException;
import java.util.StringTokenizer;
import java.sql.*;
import javax.sql.*;
import java.util.Map;
import java.util.HashMap;

/**
 *
 * @author John
 */
public class CookieLoginFilter implements Filter {
    private FilterConfig filterConfig;
    private DataSource dsn;

    public void init(FilterConfig fc) {
        this.filterConfig = fc;
        this.dsn = (DataSource) fc.getServletContext().getAttribute("dsn");
    }

    public void doFilter(ServletRequest request, ServletResponse response, FilterChain filterChain)
                                                        throws IOException, ServletException {
        HttpServletRequest req = (HttpServletRequest) request;
        if (req.getSession().getAttribute("user") == null) {

            Cookie[] cookies = req.getCookies();

            if (cookies != null && cookies.length > 0) {
                 for (Cookie c : cookies) {
                    if (c.getName().equals("user")) {
                        String plainUserName = "";
                        String hashedUserName = "";
                        StringTokenizer tokenizer = new StringTokenizer(c.getValue(),"||");
                        try {
                            plainUserName = tokenizer.nextToken();
                            hashedUserName = tokenizer.nextToken();
                        req.getSession().getServletContext().log("cook value " + c.getValue() + " plan " + plainUserName + " hashed " + hashedUserName);
                        }
                        catch (Exception ex) {
                            req.getSession().getServletContext().log(ex.getMessage());
                        }

                        boolean isValidHashMatch = com.yakimbe.util.BCrypt.checkpw(plainUserName, hashedUserName);
                        if (isValidHashMatch) {
                            req.getSession().getServletContext().log(plainUserName + " cookie user found");
                            User user = this.getUserFromDatabase(plainUserName,req);
                            if (user != null) {
                                req.getSession().getServletContext().log("User logged in from cookie!");
                                req.getSession().setAttribute("user", user);
                            }
                            else {
                                req.getSession().getServletContext().log("Cookie User from database returned null");

                            }
                        }
                        break;
                    }
                }
            }
        }

        filterChain.doFilter(request, response);
    }

    private User getUserFromDatabase(String userName, HttpServletRequest req) {

        Connection connection = null;
        PreparedStatement psUserLogin = null;
        PreparedStatement psUserActions = null;
        ResultSet rsUserLogin = null;
        User returnedUser = null;

         try {
                connection = dsn.getConnection();
                connection.setAutoCommit(false);

                psUserLogin = connection.prepareCall("SELECT * FROM user u WHERE u.user_name = ?");

                psUserLogin.setString(1, userName);

                rsUserLogin = psUserLogin.executeQuery();

                synchronized (req.getSession()) {
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
                    if (isAccountVerified == 1) {

                        returnedUser = new User(uID, uName, fName, lName, desc,
                                           website, email, regDate, loc, itemsPerPage, isAdmin, sex, birthYear, isEmailOptedIn, mapUserActions);

                        this.filterConfig.getServletContext().log("User login by cookie: " + uName);
                    }
                    else {
                        this.filterConfig.getServletContext().log("User request by cookie not verified");
                    }
                }

            } catch (SQLException ex) {
                ex.printStackTrace();
                this.filterConfig.getServletContext().log("login exception :" + ex.getMessage());
            }
            finally {
                try {
                    connection.close();
                    rsUserLogin.close();
                    psUserLogin.close();
                }
                catch (Exception e) {}
            }
            return returnedUser;
    }

    public void destroy() {
        this.filterConfig = null;
    }

}
