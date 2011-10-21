package com.yakimbe.web;

import com.yakimbe.model.Comment;
import com.yakimbe.model.EditComment;
import com.yakimbe.model.Submission;
import com.yakimbe.model.Link;
import com.yakimbe.model.User;
import com.yakimbe.util.ValidateInput;
import java.io.IOException;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Set;
import java.util.List;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.sql.DataSource;
import java.util.regex.*;

public class DoEditCommentServlet extends HttpServlet {

    private ServletContext ctx;
    private DataSource dsn;
    private String encoding;

    @Override
    public void init() throws ServletException {

        ctx = this.getServletContext();
        dsn = (DataSource)ctx.getAttribute("dsn");
        encoding = ctx.getInitParameter("paramEncoding");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
                                                     throws ServletException, IOException {
       //specify utf-8 encoding for proper decoding
       request.setCharacterEncoding(encoding);

       List<String> errors = new ArrayList<String>();

       User currentUser = (User) request.getSession().getAttribute("user");
       int commentId = 0;
       String body = "";
       String editNote = "";
       boolean isEditNoteIncluded = false;
       
       // return 417. User must be logged in.
       if (currentUser == null) {
           response.sendRedirect(response.encodeRedirectURL("/"));
       }
       else {
       errors.addAll(ValidateInput.getCommentEditValidationErrors(request.getParameter("comment"), request.getParameter("editnote"), request.getParameter("commentid")));

       commentId = Integer.parseInt(request.getParameter("commentid"));
       long itemId = 0;
       body = com.yakimbe.util.StringUtils.RemoveTrailingReturns(com.yakimbe.util.StringUtils.EscapeSmartQuotes(request.getParameter("comment")));
       editNote = request.getParameter("editnote").trim();

       isEditNoteIncluded = (editNote.length() > 1);

       Set<Comment> comments = (Set) request.getSession().getAttribute("comments");

       // get item id
       for (Comment c : comments) {
           if (c.getCommentId() == commentId) {
               itemId = c.getItemId();
           }
       }

       Connection connection = null;
       PreparedStatement psUpdateComment = null;
       PreparedStatement psEditNoteInsert = null;

       try {
           connection = dsn.getConnection();

           // the query's WHERE condition is basically our validation that the user has permission to edit this
           psUpdateComment = connection.prepareStatement("UPDATE comment SET body = ? WHERE comment_id = ? AND (SELECT user_id FROM item WHERE item_id = ?) = ?");

           if (isEditNoteIncluded) {
               psEditNoteInsert = connection.prepareStatement("INSERT INTO edit_comments (edit_comment_id, item_id, comment, time_created) VALUES (NULL,?,?, NOW())");

               psEditNoteInsert.setLong(1, itemId);
               psEditNoteInsert.setString(2, editNote);
               psEditNoteInsert.executeUpdate();
           }


           psUpdateComment.setString(1, body);
           psUpdateComment.setInt(2, commentId);
           psUpdateComment.setLong(3, itemId);
           psUpdateComment.setInt(4, currentUser.getId());

           int result = psUpdateComment.executeUpdate();

           if (result > 0) {
               ctx.log("success");
           }
           else {
               errors.add("Error updating comment");
           }
       }
       catch (SQLException ex) {
           ctx.log(ex.getMessage());
       }
       finally {
                try {
                    connection.close();
                    psUpdateComment.close();
                } catch (Exception e) {}
            }
        }

       if (!errors.isEmpty()) {
           request.setAttribute("errors", errors);
           request.getRequestDispatcher("editcomment.jsp").forward(request, response);
       }
       else {
           //find comment in session scope and update it
           Set comments = (Set) request.getSession().getAttribute("comments");

           for (Object o : comments) {
               Comment c = (Comment)o;
               if (c.getCommentId() == commentId) {
                   c.setBody(body);
                   
                   if (isEditNoteIncluded) {
                       java.sql.Timestamp ts = new java.sql.Timestamp(System.currentTimeMillis());
                       if (c.getEditNotes() == null) {
                           c.setEditNotes(new ArrayList<EditComment>());
                       }
                       c.getEditNotes().add(new EditComment(editNote, ts));
                   }
               }
           }

           List<String> messages = new ArrayList<String>();
           messages.add("Comment successfully updated");
           request.setAttribute("messages",messages);
           request.getRequestDispatcher("/Item.jsp").forward(request, response);
       }
       
    }

    public static List<Comment> CommentsSetToList(Set<Comment> set) {
        List<Comment> list = new ArrayList<Comment>();
        list.addAll(set);
        return list;
    }
}