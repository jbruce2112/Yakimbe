package com.yakimbe.web;

import com.yakimbe.model.Link;
import com.yakimbe.model.Submission;
import com.yakimbe.model.User;
import com.yakimbe.util.ValidateInput;
import java.io.IOException;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.SQLException;
import java.text.FieldPosition;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.sql.DataSource;

public class DoSubmissionServlet extends HttpServlet {

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
            return ValidateInput.getLinkValidationErrors(req.getParameter("headline"), req.getParameter("subhead"), req.getParameter("url"));
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

       List<String> listValidationErrors = null;
       List<String> duplicateURLItems = null;
       Submission newItem = null;

       User currentUser = (User)request.getSession().getAttribute("user");

       // return 417. User must be logged in.
       if (currentUser == null) {
           response.sendRedirect(response.encodeRedirectURL("/login.jsp"));
       }
       else if (!currentUser.isSubmissionAllowed()) {
           listValidationErrors = new ArrayList<String>();
           listValidationErrors.add("Please wait at least " + (User.MIN_MILLIS_ALLOWED_BETWEEN_SUBMISSIONS / 1000) + " seconds between submissions");
       }
       else {
           listValidationErrors = this.getErrorList(request);
       }
        String strCleanItemSubmissionType = request.getParameter("type");
        String strCleanHeadline = request.getParameter("headline").trim();
        String strCleanSubhead = request.getParameter("subhead").trim();
        String strCleanURL = ValidateInput.ensureProtocolExists(request.getParameter("url").trim());

       // if null, the submission type is not supported
       if (listValidationErrors == null) {
           listValidationErrors = new ArrayList<String>();
           listValidationErrors.add("Invalid submission type");
       }
       // only check / notify them if they haven't been notified for this URL already
       else if (request.getSession().getAttribute("duplicateURLNotifed") == null ||
                !request.getSession().getAttribute("duplicateURLNotifed").equals(strCleanURL)) {

           duplicateURLItems = getDuplicateURL(strCleanURL);
           request.getSession().setAttribute("duplicateURLNotifed",strCleanURL);
       }
       else if (request.getSession().getAttribute("duplicateURLNotifed").equals(strCleanURL)){
            request.getSession().removeAttribute("duplicateURLNotified");
       }

       if (listValidationErrors.isEmpty() && (duplicateURLItems == null || duplicateURLItems.isEmpty())) {

           Connection connection = null;
           CallableStatement csInsertItem = null;
           CallableStatement csInsertLink = null;

           try {
               connection = dsn.getConnection();
               connection.setAutoCommit(false);

               csInsertItem = connection.prepareCall("{ CALL insertItem(?,?) }");
               csInsertLink = connection.prepareCall("{ CALL insertLink(?,?,?,?) }");

               //set params
               csInsertItem.setInt(1, currentUser.getId());
               csInsertItem.setString(2, strCleanItemSubmissionType);

               csInsertLink.setInt(1, currentUser.getId());
               csInsertLink.setString(2, strCleanURL);
               csInsertLink.setString(3, strCleanHeadline);
               csInsertLink.setString(4, strCleanSubhead);

               csInsertItem.executeUpdate();
               csInsertLink.executeUpdate();
               
               newItem = GetNewItemsServlet.getNewItems(connection, 1, 0, currentUser.getId()).get(0);

               //for rss active items feed
               List<Submission> activeItems = GetActiveItemsServlet.getActiveItems(connection, 20, 0, -1);
               ctx.setAttribute("rssActiveItems", activeItems);

               synchronized (request.getSession()) {
                   connection.commit();
               }
           }
           catch (SQLException ex) {
               try {
                ctx.log("error doing submit insert \n" + ex.getMessage());
                connection.rollback();
               }
               catch (Exception e) {
                    ctx.log("error doing rollback()" + e.getMessage());
               }
           }
           finally {
               try {
                csInsertLink.close();
                csInsertItem.close();
                connection.close();
               }
               catch(Exception ex) {}
           }
           
           //everything went lovely. let's add this to our app-scope for the rss feed
           List<Submission> newItems = (List<Submission>) ctx.getAttribute("rssNewItems");
           newItems.remove(19);
           newItems.add(0,newItem);
           
           /*we need to send to the page of the submission (with comments) here. for now we'll just send them to the 'newest' page*/
           response.sendRedirect(response.encodeRedirectURL("/new"));
           currentUser.setTimeSinceLastSubmission(System.currentTimeMillis());
       }
       //we had validation errors
       else if (!listValidationErrors.isEmpty()) {
           request.setAttribute("errors",listValidationErrors);
           request.getRequestDispatcher("/newsubmission").forward(request, response);
       }
       //we had a duplicate URL
       else {
            List<String> messages = new ArrayList<String>();

            messages.add("There may already be submissions for this link. Please check the following: ");

            for (String item : duplicateURLItems) {
               String[] itemVal = item.split("::");
               String id = itemVal[0];
               String url = response.encodeURL("/submission/"+id);
               String headline = itemVal[1];
               messages.add("<a href='"+ url +"'>"+headline+"</a> <span>on " + itemVal[2] + "</span>");
            }
            request.setAttribute("messages",messages);
            request.getRequestDispatcher("/newsubmission").forward(request, response);
       }
    }

    protected List<String> getDuplicateURL(String url) {

        List <String> duplicateURLItems = new ArrayList<String>();

        Connection connection = null;
        PreparedStatement psDuplicateURL = null;
        ResultSet rsDuplicateURL = null;

        try {
            connection = dsn.getConnection();

            psDuplicateURL = connection.prepareStatement("SELECT i.item_id, l.headline, i.submission_time FROM item i INNER JOIN link l ON i.item_id = l.item_id WHERE l.url = ?");
            psDuplicateURL.setString(1, url);

            rsDuplicateURL = psDuplicateURL.executeQuery();

            rsDuplicateURL.beforeFirst();

            while (rsDuplicateURL.next()) {
                StringBuilder dupItem = new StringBuilder();
                Long itemId = rsDuplicateURL.getLong("item_id");
                dupItem.append(itemId.toString());
                dupItem.append("::");
                dupItem.append(rsDuplicateURL.getString("headline"));
                dupItem.append("::");

                java.util.Date date = rsDuplicateURL.getDate("submission_time");
                java.text.SimpleDateFormat df = new java.text.SimpleDateFormat("MMMM dd, yyyy");
                String formatted = df.format(date);
                dupItem.append(formatted);

                duplicateURLItems.add(dupItem.toString());
            }
        }
        catch (SQLException ex) {
            ctx.log(ex.getMessage());
        }
        finally {
            try {
                if (rsDuplicateURL != null) {
                    rsDuplicateURL.close();
                }
                psDuplicateURL.close();
                connection.close();
            }
            catch (SQLException e) {
                ctx.log(e.getMessage());
            }
        }
        return duplicateURLItems;
    }
}