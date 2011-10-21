package com.yakimbe.web;

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
import java.util.List;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.sql.DataSource;
import java.util.regex.*;

public class DoEditSubmissionServlet extends HttpServlet {

    private ServletContext ctx;
    private DataSource dsn;
    private String encoding;

    @Override
    public void init() throws ServletException {

        ctx = this.getServletContext();
        dsn = (DataSource)ctx.getAttribute("dsn");
        encoding = ctx.getInitParameter("paramEncoding");
    }

    /* Determines the validation util method to call based on the submission type
       Even if there are no errors, this should ALWAYS return a list unless the submission type
       was invalid to begin with. */
    protected List getErrorList(HttpServletRequest req) {

        if (req.getParameter("type").equalsIgnoreCase("link")) {

        return ValidateInput.getLinkEditValidationErrors(req.getParameter("headline"), req.getParameter("subhead"),
                                                                        req.getParameter("url"), req.getParameter("comments"));
            
        }
        // type not supported
        else {
           return null;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
                                                     throws ServletException, IOException {
       //specify utf-8 encoding for proper decoding
       request.setCharacterEncoding(encoding);

       User currentUser = (User)request.getSession().getAttribute("user");

       // return 417. User must be logged in.
       if (currentUser == null) { response.sendError(response.SC_PRECONDITION_FAILED); }


       List<String> listValidationErrors = this.getErrorList(request);

        String strCleanHeadline = null;
        String strCleanSubhead = null;
        String strCleanURL = null;
        String editNote = "";
        long itemId;

        itemId = ((Submission) request.getSession().getAttribute("item")).getItemId();
        long itemUserId = ((Submission) request.getSession().getAttribute("item")).getUserId();
        editNote = request.getParameter("editnote").trim();

        boolean isEditNoteIncluded = (editNote.length() > 1);

       // if null, the submission type is not supported
       if (listValidationErrors == null) {
           listValidationErrors.add("Invalid submission type");
       }
       else if (currentUser.getId() != itemUserId){
           listValidationErrors.add("You don't have permission to edit this submission");
       }
       else if (listValidationErrors.isEmpty()) {

           Connection connection = null;
           PreparedStatement psEditNoteInsert = null;
           PreparedStatement psLinkUpdate = null;

            strCleanHeadline = request.getParameter("headline").trim();
            strCleanSubhead = request.getParameter("subhead").trim();
            strCleanURL = ValidateInput.ensureProtocolExists(request.getParameter("url").trim());

           try {
               connection = dsn.getConnection();
               connection.setAutoCommit(false);

               psLinkUpdate = connection.prepareStatement("UPDATE link SET headline = ?, subhead = ?, url = ? WHERE item_id = ? ");

               if (isEditNoteIncluded) {
                   psEditNoteInsert = connection.prepareStatement("INSERT INTO edit_comments (edit_comment_id, item_id, comment, time_created) VALUES (NULL,?,?, NOW())");

                   psEditNoteInsert.setLong(1, itemId);
                   psEditNoteInsert.setString(2, editNote);
               }
               psLinkUpdate.setString(1, strCleanHeadline);
               psLinkUpdate.setString(2, strCleanSubhead);
               psLinkUpdate.setString(3, strCleanURL);
               psLinkUpdate.setLong(4, itemId);

               psLinkUpdate.executeUpdate();

               if (isEditNoteIncluded) {
                   ctx.log("running note update");
                    psEditNoteInsert.executeUpdate();
               }

               synchronized (request.getSession()) {
                   connection.commit();
               }

               Link currentLink = (Link) request.getSession().getAttribute("item");
               currentLink.setHeadline(strCleanHeadline);
               currentLink.setSubhead(strCleanSubhead);
               currentLink.setUrl(strCleanURL);

               if (isEditNoteIncluded) {
                   java.sql.Timestamp ts  = new java.sql.Timestamp(System.currentTimeMillis());
                   currentLink.getEditNotes().add(new EditComment(editNote, ts));
               }

           } catch (SQLException ex) {
               try {
                   ctx.log("error doing submit insert \n" + ex.getMessage());
                   connection.rollback();
               } catch (Exception e) {
                   ctx.log("error doing rollback()" + e.getMessage());
               }
           }
           finally {
               try {
                connection.close();
                psLinkUpdate.close();
                if (isEditNoteIncluded) {
                    psEditNoteInsert.close();
                }
               }
               catch(Exception ex) {}
           }

           List<String> messages = new ArrayList<String>();
           messages.add("Submission successfully updated");

           request.setAttribute("messages",messages);

            request.getRequestDispatcher("/Item.jsp").forward(request, response);

       }
       //we had validation errors
       else {
           request.setAttribute("errors",listValidationErrors);
           request.getRequestDispatcher("/editsubmission.jsp").forward(request, response);
       }
    }
}