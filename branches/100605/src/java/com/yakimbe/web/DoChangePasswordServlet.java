
package com.yakimbe.web;

import com.yakimbe.util.BCrypt;
import com.yakimbe.model.User;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import com.yakimbe.util.ValidateInput;
import javax.mail.Session;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.sql.DataSource;

public class DoChangePasswordServlet extends HttpServlet {

    ServletContext ctx;
    DataSource dsn;

    @Override
    public void init() throws ServletException{
        ctx = this.getServletContext();
        dsn = (DataSource)ctx.getAttribute("dsn");
    }

    // LOGOUT - <a>logout</a> triggers the GET method
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
                                                throws ServletException, IOException {

        List<String> messages = new ArrayList<String>();
        List<String> errors = new ArrayList<String>();

        HttpSession session = request.getSession();

        User currentUser = (User) session.getAttribute("user");

        boolean success = false;

        String reqOldPw = request.getParameter("oldpassword");

        String newPlainPassword1 = request.getParameter("newpassword1");
        String newPlainPassword2 = request.getParameter("newpassword2");

        errors.addAll(ValidateInput.
                        getChangePasswordValidationErrors(reqOldPw, newPlainPassword1, newPlainPassword2));

        Connection connection = null;
        PreparedStatement psVerifyUserCredentials = null;
        PreparedStatement psChangeUserPassword = null;
        ResultSet rsVerifyUserCredentials = null;

        if (errors.isEmpty()) {
            try {
                connection = dsn.getConnection();

                //CHECK LOGIN
                psVerifyUserCredentials = connection.prepareStatement("SELECT pw FROM user WHERE user_name = ?");

                psVerifyUserCredentials.setString(1, currentUser.getUserName());

                rsVerifyUserCredentials = psVerifyUserCredentials.executeQuery();

                String existingHashedPw = "";

                rsVerifyUserCredentials.beforeFirst();

                if(rsVerifyUserCredentials.next()) {
                    existingHashedPw = rsVerifyUserCredentials.getString("pw");
                }
                else {
                    ctx.log("Something went terribly wrong and a user who is logged in isn't able to retrive their record from the db. User: " + currentUser.getUserName());
                    errors.add("Something went wrong while trying to change your password. Please let us know about it - " + ctx.getInitParameter("adminEmail"));
                }

                if (errors.isEmpty()) {
                boolean passwordsMatch = BCrypt.checkpw(reqOldPw, existingHashedPw);

                if (passwordsMatch) {

                    String newHashedPw = "";

                    try {
                        newHashedPw = BCrypt.hashpw(newPlainPassword1, BCrypt.gensalt(11));
                    }
                    catch (Exception e) {
                        ctx.log(e.getMessage());
                        success = false;
                    }

                    psChangeUserPassword = connection.prepareStatement("UPDATE user SET pw = ? WHERE user_id = ?");

                    psChangeUserPassword.setString(1, newHashedPw);
                    psChangeUserPassword.setInt(2, currentUser.getId());

                    psChangeUserPassword.executeUpdate();

                    success = true;
                }
                else {
                    errors.add("Invalid password");
                }
                }
            }
            catch (SQLException ex) {
                ctx.log(ex.getMessage());
            }
            finally {
                try {
                    connection.close();
                    psVerifyUserCredentials.close();
                    psChangeUserPassword.close();
                    rsVerifyUserCredentials.close();
                }
                catch (Exception e) {}
            }
        }
        if (errors.isEmpty() && success) {

            // let the user know their password was changed
            Session mailSession = (Session) ctx.getAttribute("mailSession");

            String subject = "Yakimbe Password Change Confirmation";

            final StringBuilder body = new StringBuilder();

            body.append("Hi ");
            body.append(currentUser.getFriendlyDisplayName());
            body.append(",\n\n");
            body.append("We wanted to drop you a quick note and confirm that it was indeed you who changed your password. ");
            body.append("If this wasn't changed by you, please let us know by contacting us at webguy@yakimbe.com and we'll address it as soon as we can. ");
            body.append("\n\n- The Yakimbe Team");

            AccountVerificationServlet.SendEmail(mailSession, currentUser.getUserName(), currentUser.getEmail(), subject, body.toString());

            messages.add("Password successfully changed");
            request.setAttribute("messages", messages);
            request.getRequestDispatcher("/account.jsp").forward(request, response);
        }
        else {
            request.setAttribute("errors", errors);
            request.getRequestDispatcher("/changepassword.jsp").forward(request, response);
        }
    }
}