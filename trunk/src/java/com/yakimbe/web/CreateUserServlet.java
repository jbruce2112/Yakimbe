
package com.yakimbe.web;

import com.yakimbe.model.User;
import com.yakimbe.util.BCrypt;
import com.yakimbe.util.ValidateInput;
import java.io.IOException;
import java.sql.CallableStatement;
import java.sql.PreparedStatement;
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Types;
import java.util.List;
import java.util.ArrayList;
import javax.mail.*;
import javax.sql.DataSource;
import javax.servlet.http.*;
import javax.servlet.*;

public class CreateUserServlet extends HttpServlet {
    
    private static ServletContext ctx;
    private static DataSource dsn;

    @Override
    public void init() throws ServletException{
        ctx = this.getServletContext();
        dsn = (DataSource)ctx.getAttribute("dsn");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
                                                throws ServletException, IOException {

        if (request.getSession().getAttribute("attemptFbID") != null) {
            final String fbId = (String) request.getSession().getAttribute("attemptFbID");
            createFacebookUser(request, response, fbId);
            return;
        }

        boolean isUserCreated = false;

        String strUserName = request.getParameter("userName");
        String strEmail = request.getParameter("email");
        String strPw1 = request.getParameter("password1");
        String strPw2 = request.getParameter("password2");
        boolean emailOptIn = false;

        if (request.getParameter("email-optin") != null && request.getParameter("email-optin").equalsIgnoreCase("on")) {
            emailOptIn = true;
        }

        List<String> listErrorMessages = new ArrayList<String>();

        ValidateInput.validateUserName(strUserName, listErrorMessages);
        ValidateInput.validatePassword(strPw1,strPw2, listErrorMessages);
        ValidateInput.validateEmail(strEmail, listErrorMessages);

        if (!ValidateInput.isCaptchaValid(request)) {
            listErrorMessages.add("Invalid Captcha");
        }
       
        
        if (listErrorMessages.isEmpty()) {

            Connection connection = null;
            CallableStatement csIsEmailUnique = null;
            CallableStatement csIsUserNameUnique = null;
            PreparedStatement psCreateNewUser =  null;

            try {
                connection = dsn.getConnection();
                connection.setAutoCommit(false);

                boolean isEmailUnique = false;
                boolean isUserNameUnique = false;

                csIsEmailUnique = connection.prepareCall("{ ? = CALL isEmailUnique(?) }");
                csIsUserNameUnique = connection.prepareCall("{ ? = CALL isUserNameUnique(?) }");

                csIsEmailUnique.registerOutParameter(1, Types.BOOLEAN);
                csIsEmailUnique.setString(2, strEmail);

                csIsUserNameUnique.registerOutParameter(1, Types.BOOLEAN);
                csIsUserNameUnique.setString(2, strUserName);

                csIsEmailUnique.execute();
                isEmailUnique = csIsEmailUnique.getBoolean(1);

                csIsUserNameUnique.execute();
                isUserNameUnique = csIsUserNameUnique.getBoolean(1);

                if (!isEmailUnique) {
                    listErrorMessages.add("E-mail address is already in use.");
                }

                if (!isUserNameUnique) {
                    listErrorMessages.add("User name is already in use.");
                }

                    if (isUserNameUnique && isEmailUnique) {

                    // hash pw. Using a param of 11 for genSalt() gives us a
                    // checkPw time of about 300 ms for an 8 character password.
                    // Default is 10.
                    String hashedPw = BCrypt.hashpw(strPw1, BCrypt.gensalt(11));

                    long randy = GetRandomNumber(57482057L);

                    String query = "INSERT INTO user (user_id, user_name, email, pw, registration_date,  is_account_verified, email_opt_in)";
                    query += "VALUES (NULL, ?, ?, ?, NOW(), ?, ?)";

                    psCreateNewUser = connection.prepareCall(query);

                    psCreateNewUser.setString(1, strUserName);
                    psCreateNewUser.setString(2, strEmail);
                    psCreateNewUser.setString(3, hashedPw);
                    psCreateNewUser.setLong(4, randy);
                    psCreateNewUser.setBoolean(5, emailOptIn);

                    Session session = (Session) ctx.getAttribute("mailSession");

                    String subject = "Yakimbe Account Verification";

                    long t1 = System.currentTimeMillis();
                    AccountVerificationServlet.SendEmail(session, strUserName, 
                            strEmail, subject, AccountVerificationServlet.GetAccountVerificationEmailBody(strUserName,randy).toString());
                    
                    long t2 = System.currentTimeMillis();
                    ctx.log("sending message - " + (t2-t1) + "ms");

                    psCreateNewUser.executeUpdate();

                    synchronized (request.getSession()) {
                        connection.commit();
                    }

                    isUserCreated = true;
                }
            }
            catch (SQLException ex) {
                try {
                    connection.rollback();
                }
                catch (SQLException e) {
                    ctx.log(e.getMessage());
                }
                ctx.log("Error creating new user " + ex.getMessage());
            }
            finally {

                try {
                    connection.close();
                    csIsEmailUnique.close();
                    csIsUserNameUnique.close();
                    psCreateNewUser.close();
                }
                catch (Exception e) {}
            }
        }

        if (isUserCreated && listErrorMessages.isEmpty()) {
            request.setAttribute("userName",strUserName);
            request.setAttribute("userStatus", "newAccountCreated");
            request.getRequestDispatcher("/login.jsp").forward(request, response);
        }
        else {
            request.setAttribute("errors", listErrorMessages);
            request.getRequestDispatcher("/CreateUser.jsp").forward(request, response);
        }
    }

    protected static long GetRandomNumber(long upperBounds) {

        long returnedRandom = 0;

        do {
            double randy = Math.random();
            returnedRandom = (long) (randy*upperBounds);
        }
        // The field in the database will be 1 once they have verified their
        // account, otherwise it's this random number.
        while (returnedRandom == 1);

        return returnedRandom;
    }

    protected void createFacebookUser(final HttpServletRequest req,  final HttpServletResponse res,
                                                final String fbID) throws ServletException, IOException {
        
        final String userName = req.getParameter("userName");
        boolean emailOptIn = false;
        Connection conn = null;
        PreparedStatement ps = null;
        
        List<String> errors = new ArrayList<String>();
        ValidateInput.validateUserName(userName, errors);

        if (errors.isEmpty()) {
            try {
                conn = dsn.getConnection();
                 if (ValidateInput.isUserNameUnique(userName, conn)) {

                     if (req.getParameter("email-optin") != null &&
                         req.getParameter("email-optin").equalsIgnoreCase("on")) {
                        emailOptIn = true;
                     }
                     final String query = "INSERT INTO user(user_id,user_name,registration_date,fb_id,email_opt_in) "+
                                          "VALUES(NULL, ?, NOW(), ?, ?)";
                     ps = conn.prepareCall(query);
                     ps.setString(1, userName);
                     ps.setString(2, fbID);
                     ps.setBoolean(3, emailOptIn);

                     ps.execute();
                 }
                 else {
                    errors.add("User name is already taken, please select another");
                 }

                if (errors.isEmpty()) {
                    final User fbUser = (User) req.getSession().getAttribute("attemptFbUser");
                    fbUser.setUserName(userName);
                    FacebookLogin.getAdditionalInfo(fbUser, conn);

                    List<String> messages = new ArrayList<String>();
                    messages.add("Thanks for signing up. You may now use your facebook login with Yakimbe.");

                    req.getSession().setAttribute("user",fbUser);
                    req.getSession().removeAttribute("attemptFbUser");
                    req.getSession().removeAttribute("attemptFbID");

                    res.sendRedirect("/");
                }
            }
            catch (SQLException ex) {
                ctx.log(ex.getMessage());
            }
            finally {
                try {
                    ps.close();
                    conn.close();
                }
                catch (Exception e) {}
            }
        }
        else {
            req.setAttribute("errors", errors);
            req.getRequestDispatcher("/CreateUser.jsp").forward(req, res);
        }
    }
}
