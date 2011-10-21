package com.yakimbe.web;

import com.yakimbe.model.Link;
import com.yakimbe.model.Submission;
import com.yakimbe.model.User;
import java.io.IOException;
import java.sql.Connection;
import java.sql.CallableStatement;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import javax.sql.DataSource;
import javax.servlet.*;
import javax.servlet.http.*;

public class GetActiveItemsServlet extends HttpServlet {

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
        //defaults
        int intStartPosition = 0;
        int intNumItemsToReturn  = Integer.parseInt(ctx.getInitParameter("defaultNumItems"));
        boolean isEndOfActiveItems = false;
        long queryTime = 0;

        String reqStartPos = request.getParameter("pos");

        if (reqStartPos != null && reqStartPos.length() >= 1) {
            try {
                intStartPosition = Integer.parseInt(reqStartPos);
            }
            catch (Exception ex) {}
        }

        User currentUser = (User) request.getSession().getAttribute("user");

        if (currentUser != null) {
            intNumItemsToReturn = currentUser.getNumItemsPage();
        }

        Connection connection = null;
        ResultSet rsNewItems = null;
        CallableStatement csGetNewLinks = null;

        List<Submission> listActiveItems = null;

        final List<Submission> listNewItemsSidebar = new ArrayList<Submission>();

        try {
            connection = dsn.getConnection();
            connection.setAutoCommit(true);
            
            int queryToRun = -1;

            if (request.getSession().getAttribute("queryToRun") != null) {
                try {
                    queryToRun = Integer.parseInt((String) request.getSession().getAttribute("queryToRun"));
                }
                catch (NumberFormatException nfe) {
                    ctx.log(nfe.getMessage());
                }
            }

            if (currentUser != null && currentUser.isAdmin() && queryToRun > -1) {
                request.getSession().setAttribute("queryToRun",queryToRun);
            }

            listActiveItems = this.getActiveItems(connection, intNumItemsToReturn, intStartPosition, queryToRun);

            csGetNewLinks = connection.prepareCall("{ CALL getNewLinks(?,?) }");

            // returning 7 items for sidebar
            csGetNewLinks.setInt(1, 7);
            csGetNewLinks.setInt(2, 0);

            rsNewItems = csGetNewLinks.executeQuery();

            // for 'new items' list in sidebar
            rsNewItems.beforeFirst();

            while (rsNewItems.next()) {
                final long itemId = rsNewItems.getLong("item_id");
                final int userId = rsNewItems.getInt("user_id");
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
                    Link link = new Link(itemId, linkId, userId, userName, submissionTime, rating, headline, subhead, url,"New",numComments);
                    listNewItemsSidebar.add(link);
                }
            }

            request.setAttribute("newItems", listNewItemsSidebar);

            request.setAttribute("queryTime", queryTime);
            request.setAttribute("currentItems", listActiveItems);
            request.setAttribute("currentItemsLength", listActiveItems.size());

            request.setAttribute("isEndOfActiveItems", isEndOfActiveItems);

            // view
            request.getRequestDispatcher("/ActiveItems.jsp").forward(request, response);
        }

        catch(SQLException ex) {
            ctx.log("get current items exception : "+ex.getMessage());
        }

        finally {
            try {
                csGetNewLinks.close();
                rsNewItems.close();
                connection.close();
            }
            catch (SQLException ex) {}
        }
    }

    protected static List<Submission> getActiveItems(Connection conn, int numToReturn, int startPos, int queryToRun) throws SQLException {
        List<Submission> activeItems = new ArrayList<Submission>();

        PreparedStatement ps = null;
        ResultSet rs = null;

        StringBuilder query = new StringBuilder();

                if (queryToRun == 1) {
                    //original hn algorithm
                    String setVar = "SET @t = 0";
                    conn.prepareStatement(setVar).execute();
                    setVar = "SET @p = 0";
                    conn.prepareStatement(setVar).execute();

                    query.append("SELECT i.item_id itemId, i.submission_time submissionTime, @p := i.rating itemRating, ");
                    query.append("l.link_id linkId, l.url linkUrl, l.headline linkHeadline, l.subhead linkSubhead, u.user_id userId, u.user_name userName, ");
                    query.append("(SELECT count(c.item_id) from comment c WHERE c.item_commenting_on_id = i.item_id) num_comments, ");
                    query.append("@t:=timestampdiff(hour,submission_time,now()) t, (@p / POW(@t+2, 1.5)) popularity ");
                    query.append("FROM item i INNER JOIN link l ON l.item_id = i.item_id INNER JOIN user u ON u.user_id = i.user_id ");
                    query.append("WHERE i.is_dead = false AND i.rating >= 0 ORDER BY popularity DESC, num_comments DESC, i.rating DESC LIMIT ?, ?");
                }
                else if (queryToRun == 2) {
                    //reddit
                }
                else if (queryToRun == 3) {
                    String setVar = "SET @dateCompare = NOW()";
                    conn.prepareStatement(setVar).execute();

                    query.append("SELECT @dateCompare lol, itemId,submissionTime, itemRating, ");
                    query.append("linkId, linkUrl, linkHeadline, linkSubhead, userId, userName, ");
                    query.append("(SELECT count(c.item_id) FROM comment c WHERE c.item_commenting_on_id = itemId) num_comments, ");

                    query.append("(SELECT IF(DATE_SUB(@dateCompare, INTERVAL 3 DAY) <= submissionTime, ");
                    query.append("@dateCompare,@dateCompare:=DATE_SUB(@dateCompare, INTERVAL 3 DAY))) three_day_interval " );

                    query.append("FROM (SELECT  i.item_id itemId, i.submission_time submissionTime, i.rating itemRating, l.link_id linkId, l.url linkUrl, l.headline linkHeadline, l.subhead linkSubhead, u.user_id userId, u.user_name userName FROM item i INNER JOIN link l ON l.item_id = i.item_id INNER JOIN user u ON u.user_id = i.user_id ");
                    query.append("WHERE i.is_dead = false AND i.rating >= 0 ORDER BY i.submission_time DESC) t ORDER BY three_day_interval DESC, num_comments DESC, itemRating DESC LIMIT ?, ?");
                }

            if (query.length() < 1) {
                //modified hn algorithm
                    String setVar = "SET @comments = 0";
                    conn.prepareStatement(setVar).execute();
                    setVar = "SET @time = 0";
                    conn.prepareStatement(setVar).execute();
                    setVar = "SET @pop = 0";
                    conn.prepareStatement(setVar).execute();

                    query.append("SELECT i.item_id itemId, i.submission_time submissionTime, i.rating itemRating, ");
                    query.append("l.link_id linkId, l.url linkUrl, l.headline linkHeadline, l.subhead linkSubhead, u.user_id userId, u.user_name userName, ");

                    //get number of comments (if we store this is a user variable we can't perform floating-point arithmetic?)
                    query.append("(SELECT count(c.item_id) from comment c WHERE c.item_commenting_on_id = i.item_id) num_comments, ");
                    //calc popularity (half of rating plus number of comments)
                    query.append("@pop := ((i.rating * .5) + (SELECT count(c.item_id) from comment c WHERE c.item_commenting_on_id = i.item_id)) p, ");

                    query.append("@time:=timestampdiff(hour,submission_time,now()) t, (@pop / POW(@time+2, 3)) popularity ");
                    query.append("FROM item i INNER JOIN link l ON l.item_id = i.item_id INNER JOIN user u ON u.user_id = i.user_id ");
                    query.append("WHERE i.is_dead = false AND i.rating >= 0 ORDER BY popularity DESC, num_comments DESC, i.rating DESC LIMIT ?, ?");
            }
            
            ps = conn.prepareStatement(query.toString());
            ps.setInt(1, startPos);
            ps.setInt(2, numToReturn);
            rs = ps.executeQuery();

            // convert all items from result set into link objects and add them to our collection
            while(rs.next()) {

                // for display sort logic to admins
                String pop = "";
                try {
                    if (queryToRun == 1) {
                        pop = rs.getDouble("p") + " / " + Math.pow(rs.getDouble("t")+2, 3) + " = " + (rs.getDouble("popularity")*1000);
                    }
                    else {
                        pop = rs.getDouble("itemRating") + " / " + Math.pow(rs.getDouble("t")+2,1.5) + " = " + rs.getDouble("popularity");
                    }
                }
                catch(Exception e) {}

                final long itemId = rs.getLong("itemId");
                final String userName = rs.getString("userName");
                final int userId = rs.getInt("userId");
                final java.sql.Timestamp submissionTime = rs.getTimestamp("submissionTime");
                final short rating = rs.getShort("itemRating");
                final long linkId = rs.getLong("linkId");
                final String url = rs.getString("linkUrl");
                final int numComments = rs.getInt("num_comments");
                final String headline = com.yakimbe.util.StringUtils.EscapeSmartQuotes(rs.getString("linkHeadline"));
                final String subhead = com.yakimbe.util.StringUtils.EscapeSmartQuotes(rs.getString("linkSubhead"));

                Link link = new Link(itemId, linkId, userId, userName, submissionTime,
                                            rating, headline, subhead, url,"Active",numComments);
                link.setPopularity(pop);
                activeItems.add(link);
         }
            rs.close();
            ps.close();
            return activeItems;
    }
}
