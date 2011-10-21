package com.yakimbe.web;

import com.yakimbe.model.*;
import com.yakimbe.util.ValidateInput;
import com.yakimbe.model.Notification;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.CallableStatement;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.*;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.sql.DataSource;

public class DoCommentServlet extends HttpServlet {

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
        doPost(request,response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
                                                 throws ServletException, IOException {
        request.setCharacterEncoding(ctx.getInitParameter("paramEncoding"));

         if (request.getSession().getAttribute("user") == null) {
             List<String> errors = new ArrayList<String>();
             errors.add("You must be logged in to comment");
             request.setAttribute("loginErrors",errors);
             request.getSession().setAttribute("attemptedCommentBody", request.getParameter("body"));
             request.getSession().setAttribute("attemptedCommentParentId", request.getParameter("parentid"));
             request.getSession().setAttribute("attemptedCommentBody", request.getParameter("body"));
             request.getSession().setAttribute("attemptedCommentItemCommentingOnId", request.getParameter("itemid"));
             request.getSession().setAttribute("originallyRequestedURL", request.getHeader("referer"));
             request.getRequestDispatcher("/login.jsp").forward(request, response);
         }
         else {
            List<String> errors =
                    ValidateInput.getCommentValidationErrors(request, request.getParameter("body"),
                                            request.getParameter("parentid"), request.getParameter("itemid"));
         if (!errors.isEmpty()) {
            request.setAttribute("errors", errors);
            request.getRequestDispatcher("/Item.jsp").forward(request, response);
        }
        else {
            Connection connection = null;
            CallableStatement csInsertItem = null;
            CallableStatement csInsertComment = null;

            String body = com.yakimbe.util.StringUtils.RemoveTrailingReturns(com.yakimbe.util.StringUtils.EscapeSmartQuotes(request.getParameter("body")));
            long parentId = Long.parseLong(request.getParameter("parentid"));
            long itemCommentingOnId = Long.parseLong(request.getParameter("itemid"));

            //validation verified we have current user
            User currentUser = (User) request.getSession().getAttribute("user");

            try {
               connection = dsn.getConnection();
               connection.setAutoCommit(false);

               csInsertItem = connection.prepareCall("{ CALL insertItem(?,?) }");
               //set params
               csInsertItem.setInt(1, currentUser.getId());
               csInsertItem.setString(2, "comment");

               csInsertComment = connection.prepareCall("{ CALL insertComment(?,?,?,?) }");
               //set params
               csInsertComment.setInt(1, currentUser.getId());
               csInsertComment.setString(2, body);

               if (parentId == 0) {
                csInsertComment.setObject(3,null);
               }
               else {
                csInsertComment.setLong(3, parentId);
               }

               csInsertComment.setLong(4, itemCommentingOnId);

               csInsertItem.executeUpdate();
               csInsertComment.executeUpdate();

               synchronized (request.getSession()) {
                   connection.commit();
               }

               // get user to notify
               PreparedStatement ps = null;
               if (parentId == 0) {
                    ps = connection.prepareCall("SELECT user_id FROM item WHERE item_id =  ?");
                    ps.setLong(1, itemCommentingOnId);
               }
               else {
                    ps = connection.prepareCall("SELECT i.user_id FROM item i INNER JOIN comment c ON c.item_id = i.item_id WHERE c.comment_id =  ?");
                    ps.setLong(1, parentId);
               }
               final ResultSet rs = ps.executeQuery();

               int userIdToNotify = 0;
               if (rs.next()) {
                   userIdToNotify = rs.getInt(1);
               }

               ps.close();
               rs.close();

               // in case the user to be notified is logged in, refresh their notifications list
               final List <User> currentUsers = (ArrayList<User>) ctx.getAttribute("currentUsers");
               for (User u : currentUsers) {
                   if (u.getId() == userIdToNotify) {
                       u.setNotifications(LoginServlet.getNotifications(request, connection, userIdToNotify));
                       break;
                   }
               }
           }
           catch (SQLException ex) {
               try {
                   connection.rollback();
               }
               catch (Exception e) {}
               ctx.log("error doing comment insert \n" + ex.getMessage());
           }
           finally {
               try {
                   connection.close();
                   csInsertItem.close();
                   csInsertComment.close();
               }
               catch (Exception ex) {}
           }
           //todo: ugly. fix
           response.sendRedirect(response.encodeRedirectURL("/submission/"+itemCommentingOnId));
        }
         }
    }
}
