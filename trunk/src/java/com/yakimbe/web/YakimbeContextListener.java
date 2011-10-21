package com.yakimbe.web;

import javax.servlet.*;
import java.util.*;
import javax.mail.*;
import javax.naming.*;
import javax.sql.*;
import java.sql.SQLException;
import com.yakimbe.model.Submission;
import com.yakimbe.model.User;
import java.sql.Connection;

/**
* The goal for this listener is basically to set up our application variables and database connection, and wreck them
 * when this is undeployed.
 */
public class YakimbeContextListener implements ServletContextListener{

    private static final int MAX_USER_AGE = 110;
    private static final int MIN_USER_AGE = 14;

    @Override
    public void contextInitialized(ServletContextEvent e) {

        ServletContext ctx = e.getServletContext();

        final String[] submissionTypes = new String[] {"Link"};

        ctx.setAttribute("submissionTypes", submissionTypes);

        //create array of years for user sign-up
        int size = (MAX_USER_AGE-MIN_USER_AGE);
        final int[] birthyearRange = new int[size];

        Calendar c = Calendar.getInstance();
        c.setTime(new Date());
        int currentYear = c.get(Calendar.YEAR);

        for (int i=0; i < birthyearRange.length; i++) {
            int year = (currentYear - (MIN_USER_AGE + i));
            birthyearRange[i] = year;
        }

        ctx.setAttribute("birthyearRange", birthyearRange);

        //create array for valid locations for user sign-up
        final List<String> locations = new ArrayList<String>();

        // all towns with high schools in Ingham, Eaton, Clinton, Shiaasse and Ionia Gratiot counties
        locations.add("Lansing's North Side");
        locations.add("Lansing's East Side");
        locations.add("Lansing's South Side");
        locations.add("Lansing's West Side");
        locations.add("East Lansing");
        locations.add("Alma");
        locations.add("Ashley");
        locations.add("Bath");
        locations.add("Bellevue");
        locations.add("Breckenridge");
        locations.add("Byron");
        locations.add("Charlotte");
        locations.add("Corunna");
        locations.add("Dansville");
        locations.add("Delta Township");
        locations.add("DeWitt");
        locations.add("Dimondale");
        locations.add("Durand");
        locations.add("Eaton Rapids");
        locations.add("Elsie");
        locations.add("Fowler");
        locations.add("Fowlerville");
        locations.add("Fulton");
        locations.add("Grand Ledge");
        locations.add("Haslett");
        locations.add("Holt");
        locations.add("Ionia");
        locations.add("Laingsburg");
        locations.add("Lake Odessa");
        locations.add("Lakewood");
        locations.add("Leslie");
        locations.add("Mason");
        locations.add("Middleton");
        locations.add("Morrice");
        locations.add("New Lothrop");
        locations.add("Okemos");
        locations.add("Olivet");
        locations.add("Ovid");
        locations.add("Owosso");
        locations.add("Perry");
        locations.add("Pewamo");
        locations.add("Portland");
        locations.add("Potterville");
        locations.add("Saranac");
        locations.add("St. Johns");
        locations.add("St. Louis");
        locations.add("Stockbridge");
        locations.add("Vermontville");
        locations.add("Webberville");
        locations.add("Westphalia");
        locations.add("Williamston");

        ctx.setAttribute("locations",locations);

        // to keep track of logged in users
        List <User> currentUsers = new ArrayList<User>();
        ctx.setAttribute("currentUsers", currentUsers);

        Connection conn = null;
       // Set up connection pool for database & get java mail resource
        try {
            //JNDI lookup
            Context initCtx = new InitialContext();
            Context envCtx = (Context) initCtx.lookup("java:comp/env");

            //Grab datasource using name from server.xml & web.xml
            DataSource dsn = (DataSource) envCtx.lookup("jdbc/Yakimbe");

            //Grab mail session using name specified in server.xml & web.xml
            Session mailSession = (Session) envCtx.lookup("mail/Session");

            //store this for everyone to use
            ctx.setAttribute("dsn", dsn);
            ctx.setAttribute("mailSession", mailSession);

            conn = dsn.getConnection();
            
            // do initial rss grab & store in app scope for rss jsp to gen xml
            // -1 means we don't care about the user id for the data grab
            List<Submission> rssNewItems = GetNewItemsServlet.getNewItems(conn, 20, 0, -1);

            // -1 means we use default active items algorithm
            List<Submission> rssActiveItems = GetActiveItemsServlet.getActiveItems(conn, 20, 0, -1);

            ctx.setAttribute("rssActiveItems", rssActiveItems);
            ctx.setAttribute("rssNewItems", rssNewItems);

            KarmaManager.setContext(ctx);
            KarmaManager.setDSN(dsn);
        }
        catch (SQLException sqlEx) {
            ctx.log(sqlEx.getMessage());
        }
        catch (NamingException ex) {
            ctx.log("Error in ContextInitialized Listener\n" + ex.getMessage());
        }
        finally {
            try {
                conn.close();
            }
            catch (Exception exc) {}
        }
}
    @Override
    public void contextDestroyed(ServletContextEvent e) {
    }
}
