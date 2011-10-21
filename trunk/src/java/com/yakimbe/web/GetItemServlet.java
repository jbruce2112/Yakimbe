package com.yakimbe.web;

import com.yakimbe.model.Notification;
import com.yakimbe.model.User;
import com.yakimbe.model.EditComment;
import com.yakimbe.model.Comment;
import com.yakimbe.model.Link;
import com.yakimbe.model.Submission;
import java.io.IOException;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.List;
import java.util.ArrayList;
import java.util.LinkedList;
import java.util.HashSet;
import java.util.Map;
import java.util.HashMap;
import java.util.Set;
import java.util.regex.Pattern;
import java.util.regex.Matcher;
import javax.sql.DataSource;
import javax.servlet.*;
import javax.servlet.http.*;

public class GetItemServlet extends HttpServlet {

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

        long reqItemId = 0;
        long queryTime = 0;
        int numComments = 0;

        User currentUser = (User) request.getSession().getAttribute("user");
        boolean currentUserCanEditItemOnPage = false;

        String s = request.getRequestURI();
        Pattern p = Pattern.compile("\\d+");
        Matcher m = p.matcher(s);
        m.find();
        try {
            reqItemId = Long.parseLong(m.group());
            ctx.log("Viewing comments for item " + reqItemId);
        }
        catch (Exception ex) {}
        
        Connection connection = null;
        ResultSet rsLink = null;
        ResultSet rsComments = null;
        CallableStatement csGetNewLink = null;
        PreparedStatement psLinkEdits = null;
        PreparedStatement psGetComments = null;
        PreparedStatement psCommentEdits = null;
        CallableStatement csGetNewLinksSidebar = null;
        ResultSet rsNewLinksSidebar = null;
        ResultSet rsLinkEdits = null;
        ResultSet rsCommentEdits = null;

       
        Set<Comment> setComments = new HashSet<Comment>();
        List<Submission> listNewLinksSidebar = new ArrayList<Submission>();
        List<EditComment> editNotes = new ArrayList<EditComment>();
        List<EditComment> commentEditNotes = new ArrayList<EditComment>();

        try {
            connection = dsn.getConnection();

            //if user came here from the notifications panel - we'll set the flags so they aren't notified again
            String delNotif = request.getParameter("delNotif");
            if (delNotif != null && delNotif.length() > 1) {
                
                if (delNotif.equalsIgnoreCase("comment")) {
                    log("remove comment");
                    removeNotificationFlagsForItem(connection, reqItemId, currentUser.getId(), Notification.Type.COMMENT, currentUser);
                }
                else if (delNotif.equalsIgnoreCase("item")) {
                    log("remove item");
                    removeNotificationFlagsForItem(connection, reqItemId, currentUser.getId(), Notification.Type.ITEM, currentUser);
                }
            }
            
            csGetNewLink = connection.prepareCall("{ CALL getLink(?) }");
            csGetNewLink.setLong(1, reqItemId);


            StringBuilder commentsQuery = new StringBuilder();
            commentsQuery.append("SELECT comment_id, c.item_id, item_commenting_on_id, body, parent_comment_id, u.user_id, user_name, submission_time, i.rating ");
            commentsQuery.append("FROM comment c INNER JOIN item i ON i.item_id = c.item_id ");
            commentsQuery.append("INNER JOIN user u ON u.user_id = i.user_id WHERE i.is_dead = false AND c.item_commenting_on_id = ?");

            psGetComments = connection.prepareStatement(commentsQuery.toString());
            psGetComments.setLong(1, reqItemId);
            
            String commentEditQuery = "SELECT * FROM edit_comments ec INNER JOIN comment c ON ec.item_id = c.item_id WHERE c.item_commenting_on_id = ? ORDER BY ec.time_created ASC";
            psCommentEdits = connection.prepareStatement(commentEditQuery);
            psCommentEdits.setLong(1, reqItemId);

            rsCommentEdits = psCommentEdits.executeQuery();

            csGetNewLinksSidebar = connection.prepareCall("{ CALL getNewLinks(?,?) }");

            // returning 7 items for sidebar
            csGetNewLinksSidebar.setInt(1, 7);
            csGetNewLinksSidebar.setInt(2, 0);

            psLinkEdits = connection.prepareStatement("SELECT * FROM edit_comments ec WHERE ec.item_id = ? ORDER BY time_created ASC");

            psLinkEdits.setLong(1,reqItemId);

            final long startTime = new java.util.Date().getTime();

            rsNewLinksSidebar = csGetNewLinksSidebar.executeQuery();
            rsLink = csGetNewLink.executeQuery();
            rsComments = psGetComments.executeQuery();
            rsLinkEdits = psLinkEdits.executeQuery();
            rsCommentEdits = psCommentEdits.executeQuery();

            final long endTime = new java.util.Date().getTime();

            queryTime = endTime - startTime;
            
            rsCommentEdits.beforeFirst();
            while(rsCommentEdits.next()) {
                final long itemId = rsCommentEdits.getLong("item_id");
                final String body = rsCommentEdits.getString("comment");
                final java.sql.Timestamp ts = rsCommentEdits.getTimestamp("time_created");

                final EditComment ec = new EditComment(body, ts);
                ec.setItemId(itemId);
                commentEditNotes.add(ec);
            }

            rsComments.beforeFirst();

            while (rsComments.next()) {
                final int commentId = rsComments.getInt("comment_id");
                final long cItemId = rsComments.getLong("item_id");
                final long itemCommentingOnId = rsComments.getLong("item_commenting_on_id");
                final String body = com.yakimbe.util.StringUtils.EscapeSmartQuotes(rsComments.getString("body"));
                final int parentCommentId = rsComments.getInt("parent_comment_id");
                final int cUserId = rsComments.getInt("user_id");
                final String cUserName = rsComments.getString("user_name");
                final java.sql.Timestamp cSubmissionTime = rsComments.getTimestamp("submission_time");
                final short cRating = rsComments.getShort("rating");

                final Comment comment = new Comment(cItemId,cUserId,cUserName,cSubmissionTime,cRating,commentId,itemCommentingOnId,body,parentCommentId);

                final List<EditComment> myEditNotes = new ArrayList<EditComment>();
                
                for (int i = 0; i < commentEditNotes.size(); i++) {
                    EditComment ec = commentEditNotes.get(i);
                    if (ec.getItemId() == comment.getItemId()) {
                        myEditNotes.add(ec);
                    }
                }

                comment.setEditNotes(myEditNotes);
                
                setComments.add(comment);
                numComments++;
                if (currentUser != null && comment.getUserId() == currentUser.getId()) {
                    currentUserCanEditItemOnPage = true;
                }
            }

            rsLink.first();
            final long itemId = rsLink.getLong("item_id");
            final int userId = rsLink.getInt("user_id");
            final String userName = rsLink.getString("user_name");
            final java.sql.Timestamp submissionTime = rsLink.getTimestamp("submission_time");
            final short rating = rsLink.getShort("rating");
            final String itemType = rsLink.getString("item_type");
            final long linkId = rsLink.getLong("link_id");
            final String url = rsLink.getString("url");
            final String headline = com.yakimbe.util.StringUtils.EscapeSmartQuotes(rsLink.getString("headline"));
            final String subhead = com.yakimbe.util.StringUtils.EscapeSmartQuotes(rsLink.getString("subhead"));

            rsLinkEdits.beforeFirst();
            while (rsLinkEdits.next()) {
                final String comment = rsLinkEdits.getString("comment");
                final java.sql.Timestamp timestamp = rsLinkEdits.getTimestamp("time_created");

                EditComment ec = new EditComment(comment,timestamp);

                editNotes.add(ec);
            }


            Submission link = null;
            if (itemType.equalsIgnoreCase("link")) {
                link = new Link(itemId, linkId, userId, userName, submissionTime, rating, headline, subhead, url,null,numComments);
                ((Link)link).setEditNotes(editNotes);

                if (currentUser != null && link.getUserId() == currentUser.getId()) {
                    currentUserCanEditItemOnPage = true;
                }
            }

            rsNewLinksSidebar.beforeFirst();

            while (rsNewLinksSidebar.next()) {
                final long s_itemId = rsNewLinksSidebar.getLong("item_id");
                final int s_userId = rsNewLinksSidebar.getInt("user_id");
                final String s_userName = rsNewLinksSidebar.getString("user_name");
                final java.sql.Timestamp s_submissionTime = rsNewLinksSidebar.getTimestamp("submission_time");
                final short s_rating = rsNewLinksSidebar.getShort("rating");
                final String s_itemType = rsNewLinksSidebar.getString("item_type");
                final long s_linkId = rsNewLinksSidebar.getLong("link_id");
                final String s_url = rsNewLinksSidebar.getString("url");
                final int s_numComments = rsNewLinksSidebar.getInt("num_comments");
                final String s_headline = com.yakimbe.util.StringUtils.EscapeSmartQuotes(rsNewLinksSidebar.getString("headline"));
                final String s_subhead = com.yakimbe.util.StringUtils.EscapeSmartQuotes(rsNewLinksSidebar.getString("subhead"));

                if (s_itemType.equalsIgnoreCase("Link")) {
                    Link sidebarLink = new Link(s_itemId, s_linkId, s_userId, s_userName, s_submissionTime, 
                                                            s_rating, s_headline, s_subhead, s_url,"New", s_numComments);
                    listNewLinksSidebar.add(sidebarLink);
                }
            }

            //block adds link to the session-scoped recently viewed collection
            LinkedList<Submission> recentlyViewed = (LinkedList) request.getSession().getAttribute("recentlyViewed");

            // we'll push it to the front
            if (recentlyViewed.contains(link)) {
                recentlyViewed.remove(link);
            }
            // check our max size
            else if (recentlyViewed.size() == 4) {
                recentlyViewed.removeLast();
            }

            recentlyViewed.addFirst(link);

            //If this item belongs to the current user, they may wish to edit
            // it - in which case it needs to be in the session scope. Otherwise
            // there is no need for it to live longer than this request.
            if (currentUserCanEditItemOnPage) {
                request.getSession().setAttribute("item", link);
                request.getSession().setAttribute("comments", setComments);
                request.getSession().setAttribute("queryTime", queryTime);
                request.getSession().setAttribute("newItems", listNewLinksSidebar);
            }
            else {
                request.setAttribute("item", link);
                request.setAttribute("comments", setComments);
                request.setAttribute("queryTime", queryTime);
                request.setAttribute("newItems", listNewLinksSidebar);
            }
            request.getSession().setAttribute("currentItemId", link.getItemId());
            request.getRequestDispatcher("/Item.jsp").forward(request, response);
        }

        catch (SQLException ex) {
            ctx.log("Error executing get new link\n" + ex.getMessage());
        }
        finally {
            try {
                csGetNewLink.close();
                psGetComments.close();
                rsComments.close();
                rsLink.close();
                rsCommentEdits.close();
                connection.close();
            } catch (SQLException ex) {}
        }
    }

    //TODO: Verify user submitted the item we're removing notificiations for
    protected void removeNotificationFlagsForItem(Connection conn, long itemId, int userId, Notification.Type type, User usr) throws SQLException {
        PreparedStatement ps = null;
        StringBuilder query = new StringBuilder();

        /* MySQL has a goofy limitation that disallows an inner query from the table you're updating. A
           work-around for this is to nest that query inside another query, creating a temp table in the process.
           This is explained here http://www.xaprb.com/blog/2006/06/23/how-to-select-from-an-update-target-in-mysql/ */

        
        if (type == Notification.Type.ITEM) {
            query.append("UPDATE item SET is_user_notified = 1 WHERE item_id IN ");
            query.append("(SELECT item_id FROM (SELECT c.item_commenting_on_id FROM ");
            query.append("comment c INNER JOIN item i ON i.item_id = c.item_id ");
            query.append("WHERE c.parent_comment_id IS NULL AND c.item_commenting_on_id = ?) as x)");

            ps = conn.prepareCall(query.toString());
            ps.setLong(1, itemId);
            final int result = ps.executeUpdate();
            ctx.log("num items set to is_notified: " + result);

            // remove from memory
            final List <Notification> notifs = usr.getNotifications().get("item");

            for (int i=0; i<notifs.size(); i++) {
                if (notifs.get(i).getItemId() == itemId) {
                    notifs.remove(notifs.get(i));
                }
            }
        }
        else if (type == Notification.Type.COMMENT) {
            query.append("UPDATE item SET is_user_notified = 1 WHERE item_id IN ");
            query.append("(SELECT item_id FROM (SELECT i.item_id FROM comment c INNER JOIN item i ON c.item_id = i.item_id ");
            query.append("WHERE c.parent_comment_id IN (SELECT comment_id FROM comment c INNER JOIN item it on c.item_id = it.item_id ");
            query.append("WHERE it.user_id = ? AND c.item_commenting_on_id = ?)) as x)");

            ps = conn.prepareCall(query.toString());
            ps.setInt(1, userId);
            ps.setLong(2, itemId);
            
            final int result = ps.executeUpdate();
            ctx.log("num items set to is_notified: " + result);

            // remove from memory
            final List <Notification> notifs = usr.getNotifications().get("comment");

            for (int i=0; i<notifs.size(); i++) {
                if (notifs.get(i).getItemCommentingOnId() == itemId) {
                    notifs.remove(notifs.get(i));
                }
            }
        }
        ps.close();
    }
}