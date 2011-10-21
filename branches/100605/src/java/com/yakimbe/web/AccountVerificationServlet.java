package com.yakimbe.web;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.mail.*;
import javax.mail.internet.*;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.sql.DataSource;

public class AccountVerificationServlet extends HttpServlet {

    private ServletContext ctx;
    private DataSource dsn;

    @Override
    public void init() throws ServletException {
        ctx = this.getServletContext();
        dsn = (DataSource)ctx.getAttribute("dsn");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
                                                 throws ServletException, IOException {
        String userName = request.getParameter("user");
        Connection connection = null;
        PreparedStatement psVerify = null;
        ResultSet result = null;
        
         try {
                connection = dsn.getConnection();

                psVerify = connection.prepareStatement("SELECT u.email, u.is_account_verified FROM user u WHERE u.user_name = ?");

                psVerify.setString(1, userName);

                result = psVerify.executeQuery();

                result.beforeFirst();
                result.next();

                String returnedEmail = result.getString("email");
                long returnedIsAccountVerified = result.getLong("is_account_verified");

                if (returnedIsAccountVerified != 1) {
                    ctx.log("Ok, let's send that verification e-mail again.");
                    
                    final Session session = (Session) ctx.getAttribute("mailSession");

                    final String subject = "Yakimbe Account Verification";
                    
                    SendEmail(session, userName, returnedEmail,
                            subject, GetAccountVerificationEmailBody(userName,returnedIsAccountVerified).toString());
                    
                    ctx.log("sending message");

                    request.setAttribute("userStatus", "verificationMailResent");
                    request.getRequestDispatcher("/login.jsp").forward(request, response);
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
                    result.close();
                    psVerify.close();
                    connection.close();
                }
                catch (Exception e){}
            }
    }

    protected static StringBuilder GetAccountVerificationEmailBody(String userName, long randy) {

        final String verificationURL = "http://www.yakimbe.com/user/" + userName + "?verif=" + randy;

        final StringBuilder body = new StringBuilder();
        body.append("Hi ");
        body.append(userName + ",");
        body.append("\n\nFollow this link to complete your registration for Yakimbe: ");
        body.append(verificationURL);
        body.append("\n\nSee you there!\n\n - The Yakimbe Team ");

        return body;
    }

    //TODO: This feels like it should be static, but there are a few ugly work-arounds we had to take. Re-evaluate.
    protected static void SendEmail(Session mailSession, String userName, String email, String subject, String body) {

        final Session session = mailSession;

        try {
            final Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress("no-reply@yakimbe.com"));

            final InternetAddress to = new InternetAddress(email);
            final InternetAddress bc = new InternetAddress("webguy@yakimbe.com");

            message.setRecipient(Message.RecipientType.TO, to);
            message.setRecipient(Message.RecipientType.BCC, bc);
            message.setSubject(subject);
            message.setContent(body, "text/plain");

            Transport.send(message);
        }
        catch (Exception ex) {
            ex.printStackTrace();
        }
    }
}
