package com.yakimbe.web;

import com.yakimbe.model.User;
import com.yakimbe.util.ValidateInput;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.sql.DataSource;
import java.util.*;

public class AccountEditServlet extends HttpServlet {

    private ServletContext ctx;
    private DataSource dsn;

    @Override
    public void init() throws ServletException {
        ctx = this.getServletContext();
        dsn = (DataSource) ctx.getAttribute("dsn");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
                                                throws ServletException, IOException {
        boolean isFirstLogin = false;

        if (request.getHeader("referer").contains("/firstlogin")) {
            isFirstLogin = true;
        }

        String reqFirstName = request.getParameter("firstname");
        String reqLastName = request.getParameter("lastname");
        String reqLocation = request.getParameter("location");
        String reqDesc = request.getParameter("description");
        String reqSex = request.getParameter("sex");
        String reqBirthYear = request.getParameter("birthday-year");
        String reqWebsite = request.getParameter("website");
        boolean reqEmailOptIn = false;

        if (request.getParameter("email-optin") != null && request.getParameter("email-optin").equalsIgnoreCase("on")) {
            reqEmailOptIn = true;
        }
        
        User currentUser = (User) request.getSession().getAttribute("user");

        List<String> errors = new ArrayList<String>();
        List<String> messages = new ArrayList<String>();

        if (reqFirstName.trim().length() < 1) {
            reqFirstName = null;
        }

        if (reqLastName.trim().length() < 1) {
            reqLastName = null;
        }

        if (reqLocation.trim().length() < 1) {
            reqLocation = null;
        }

        if (reqDesc.trim().length() < 1) {
            reqDesc = null;
        }

        if (reqSex.trim().length() < 1) {
            reqSex = null;
        }

        if (reqWebsite.trim().length() < 1) {
            reqWebsite = null;
        }

        ValidateInput.validateFirstName(reqFirstName, errors);
        ValidateInput.validateLastName(reqLastName, errors);
        ValidateInput.validateLocation(reqLocation, errors, ctx);
        ValidateInput.validateSex(reqSex, errors);
        ValidateInput.validateBirthYear(reqBirthYear, errors, ctx);
        ValidateInput.validateDescription(reqDesc, errors);
        ValidateInput.validateUserWebsite(reqWebsite, errors);

        /* TODO
        ValidateInput.validateNumItemsPage(reqNumItemsPage, errors);
         *
         */

        if (errors.isEmpty()) {

        Connection connection = null;
        PreparedStatement psUpdateUser = null;

        try {
            connection = dsn.getConnection();

            StringBuilder updateQuery = new StringBuilder();

            updateQuery.append("UPDATE user ");
            updateQuery.append("SET first_name = ?, last_name = ?, location = ?, ");
            updateQuery.append("description = ?, web_site = ?, email_opt_in = ?, sex = ?, birth_year = ? ");
            updateQuery.append("WHERE user_id = ?");

            psUpdateUser = connection.prepareStatement(updateQuery.toString());

            psUpdateUser.setString(1, reqFirstName);
            psUpdateUser.setString(2, reqLastName);
            psUpdateUser.setString(3, reqLocation);
            psUpdateUser.setString(4, reqDesc);
            psUpdateUser.setString(5, reqWebsite);
            psUpdateUser.setBoolean(6, reqEmailOptIn);
            psUpdateUser.setString(7, reqSex);
            if (reqBirthYear != null && !reqBirthYear.trim().isEmpty()) {
                psUpdateUser.setInt(8, Integer.parseInt(reqBirthYear));
            }
            else {
                psUpdateUser.setNull(8, java.sql.Types.NULL);
            }
            psUpdateUser.setLong(9, currentUser.getId());

            int result = psUpdateUser.executeUpdate();
            
            if (result == 1) {
                if (reqFirstName != null) {
                    currentUser.setFirstName(reqFirstName);
                }
                else {
                    currentUser.setFirstName("");
                }
                if (reqLastName != null) {
                    currentUser.setLastName(reqLastName);
                }
                else {
                    currentUser.setLastName("");
                }
                if (reqLocation != null) {
                    currentUser.setLocation(reqLocation);
                }
                else {
                    currentUser.setLocation("");
                }
                if (reqDesc != null) {
                    currentUser.setDescription(reqDesc);
                }
                else {
                    currentUser.setDescription("");
                }
                if (reqWebsite != null) {
                    currentUser.setWebsite(reqWebsite);
                }
                else {
                    currentUser.setWebsite("");
                }
                if (reqBirthYear != null && !reqBirthYear.trim().isEmpty()) {
                    currentUser.setBirthYear(Integer.parseInt(reqBirthYear));
                }
                else {
                    currentUser.setBirthYear(0);
                }
                if (reqSex != null) {
                    currentUser.setSex(reqSex);
                }
                else {
                    currentUser.setSex("");
                }
                currentUser.setEmailOptedIn(reqEmailOptIn);
            }
            else {
                ctx.log(" User account Update unsuccessful");
            }
        }
        catch (SQLException ex) {
            ctx.log(ex.getMessage());
        }
        finally {
            try {
                connection.close();
                psUpdateUser.close();
            }
            catch (SQLException e) {}
        }
            if (isFirstLogin) {
                response.sendRedirect(response.encodeRedirectURL("/"));
            }
            else {
                messages.add("Account successfully updated");
                request.setAttribute("messages", messages);
                request.getRequestDispatcher("/account").forward(request, response);
            }
        }
        else {
            request.setAttribute("errors", errors);
            request.getRequestDispatcher("/account").forward(request, response);
        }
    }
}