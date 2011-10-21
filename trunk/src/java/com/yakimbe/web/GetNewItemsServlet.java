package com.yakimbe.web;

import com.yakimbe.model.Link;
import com.yakimbe.model.Submission;
import com.yakimbe.model.User;
import java.io.IOException;
import java.sql.PreparedStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.*;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.sql.DataSource;

public class GetNewItemsServlet extends HttpServlet {

    private ServletContext ctx;
    private DataSource dsn;

    @Override
    public void init() {
        ctx = this.getServletContext();
        dsn = (DataSource)ctx.getAttribute("dsn");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
                                                throws ServletException, IOException {
        // defaults
        int intNumItemsToReturn = 20;
        int intStartPosition = 0;
        long queryTime = 0;

        User currentUser = (User)request.getSession().getAttribute("user");
        
        if (currentUser != null) {
            intNumItemsToReturn = currentUser.getNumItemsPage();
        }

        String reqStartPosition = request.getParameter("pos");

        if (reqStartPosition != null && reqStartPosition.length() > 0) {
            try {
                intStartPosition = Integer.parseInt(reqStartPosition);
            }
            catch (Exception ex) {}
        }

        Connection connection = null;
        List<Submission> listNewItems = null;
        
        try {
            connection = dsn.getConnection();

            listNewItems = this.getNewItems(connection, intNumItemsToReturn, intStartPosition, -1);
            
            ctx.setAttribute("newItems", listNewItems);

            request.setAttribute("newItems", listNewItems);
            request.setAttribute("newItemsLength",listNewItems.size());
        }
        catch (SQLException ex) {
            ctx.log("Error executing getNewLinks SP\n" + ex.getMessage());
        }
        finally {
                try {
                    connection.close();
                } catch (SQLException ex) {}
        }

        request.setAttribute("queryTimeNew", queryTime);
        request.getRequestDispatcher("/NewItems.jsp").forward(request, response);
    }

    protected static List<Submission> getNewItems(Connection conn, int numToReturn, int startPos, int userId) throws SQLException {

        ResultSet rsNewItems = null;
        PreparedStatement psNewLinks = null;
        List<Submission> listNewItems = new ArrayList<Submission>();

        final StringBuilder query = new StringBuilder();
        query.append("SELECT i.item_id, u.user_id, u.user_name, i.submission_time, ");
        query.append("i.rating, i.item_type, l.link_id, l.url, l.headline, l.subhead, ");
        query.append("(SELECT count(c.item_id) from comment c where c.item_commenting_on_id = i.item_id) num_comments ");
        query.append("FROM item i INNER JOIN link l ON l.item_id = i.item_id INNER JOIN user u ON u.user_id = i.user_id ");
        
        // a -1 for userId means we don't care about it. We have it here so we can call this method and get the most recent
        // submission by a user and add it to our scoped collection when they submit an item.
        if (userId == -1 ) {
            query.append("WHERE i.is_dead = false ORDER BY submission_time DESC LIMIT ?, ?");
        }
        else {
            query.append("WHERE i.is_dead = false AND i.user_id = ? ORDER BY submission_time DESC LIMIT ?, ?");
        }

        psNewLinks = conn.prepareStatement(query.toString());

        if (userId != -1) {
            psNewLinks.setInt(1, userId);
            psNewLinks.setInt(2, startPos);
            psNewLinks.setInt(3, numToReturn);
        }
        else {
            psNewLinks.setInt(1, startPos);
            psNewLinks.setInt(2, numToReturn);
        }

        rsNewItems = psNewLinks.executeQuery();

        rsNewItems.beforeFirst();

        while (rsNewItems.next()) {
            final long itemId = rsNewItems.getLong("item_id");
            final int user_Id = rsNewItems.getInt("user_id");
            final String userName = rsNewItems.getString("user_name");
            final java.sql.Timestamp submissionTime = rsNewItems.getTimestamp("submission_time");
            final short rating = rsNewItems.getShort("rating");
            final String itemType = rsNewItems.getString("item_type");
            final long linkId = rsNewItems.getLong("link_id");
            final String url = rsNewItems.getString("url");
            final int numComments = rsNewItems.getInt("num_comments");
            final String headline = com.yakimbe.util.StringUtils.EscapeSmartQuotes(rsNewItems.getString("headline"));
            final String subhead = com.yakimbe.util.StringUtils.EscapeSmartQuotes(rsNewItems.getString("subhead"));

            if (itemType.equalsIgnoreCase("Link")) {
                Link link = new Link(itemId, linkId, user_Id, userName, submissionTime, rating, headline, subhead, url,"New",numComments);
                listNewItems.add(link);
            }
        }

        psNewLinks.close();
        rsNewItems.close();

        return listNewItems;
    }
}