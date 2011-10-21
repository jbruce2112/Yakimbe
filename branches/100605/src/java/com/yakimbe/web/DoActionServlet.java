
package com.yakimbe.web;

import com.yakimbe.model.User;
import com.yakimbe.util.ValidateInput;
import java.io.IOException;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.sql.DataSource;
import java.util.*;
import java.sql.PreparedStatement;
import java.util.regex.*;

public class DoActionServlet extends HttpServlet {

    private ServletContext ctx;
    private DataSource dsn;

    @Override
    public void init() throws ServletException {
        ctx = this.getServletContext();
        dsn = (DataSource)ctx.getAttribute("dsn");
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
                                                throws ServletException, IOException {
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
                                                throws ServletException, IOException {
        //Run validation and store any errors
        List<String> errors = ValidateInput.getActionValidationErrors(request,ctx);
        
        if (!errors.isEmpty()) {
            //TODO: fix naming here (errors instead of loginErrors)
            request.setAttribute("loginErrors", errors);
            request.getRequestDispatcher("/login.jsp").forward(request, response);
        }
        else {
            //Validation checks for a user so this is safe.
            User currentUser = (User) request.getSession().getAttribute("user");
            String strUserName = currentUser.getUserName();
            String actionType = "";
            int updatedRating = 0;
            String voteDirection = request.getParameter("vote");
            long longItemId = Long.parseLong(request.getParameter("id"));

            if (voteDirection.equalsIgnoreCase("up")) {
                actionType = "upvote";
                updatedRating = 1;
            } 
            else if (voteDirection.equalsIgnoreCase("down")) {
                actionType = "downvote";
                updatedRating = -1;
            }

            //see if they're performing an action they've done before (undoing)
            String previousAction = (String) currentUser.getUserActions().get(String.valueOf(longItemId));
            String dirToUndo = "";
            
            if (previousAction != null) {
                if (previousAction.equalsIgnoreCase("upvote")) {
                    updatedRating = -1;
                    dirToUndo = "up";
                }
                else if (previousAction.equalsIgnoreCase("downvote")) {
                    updatedRating = 1;
                    dirToUndo = "down";
                }
            }


            Connection connection = null;
            CallableStatement csInsertAction = null;
            CallableStatement csUpdateRating = null;
            PreparedStatement psUndoAction = null;
            PreparedStatement psSwitchAction = null;

            try {
                connection = dsn.getConnection();
                connection.setAutoCommit(false);

                // removing their vote completly
                if (dirToUndo.length() > 0 && dirToUndo.equalsIgnoreCase(voteDirection)) {
                    String actionQuery = "DELETE FROM action WHERE item_id = ? AND action_type = ? AND user_id = ?";
                    psUndoAction = connection.prepareStatement(actionQuery);

                    psUndoAction.setLong(1, longItemId);

                    if (dirToUndo.equals("up")) {
                        psUndoAction.setString(2,"upvote");
                    }
                    else {
                        psUndoAction.setString(2,"downvote");
                    }

                    psUndoAction.setInt(3, currentUser.getId());

                    int result = psUndoAction.executeUpdate();

                    connection.commit();

                    if (result > 0) {
                        Map m = currentUser.getUserActions();
                        m.remove(String.valueOf(longItemId));
                        currentUser.setUserActions(m);

                    }
                }
                //switching their vote
                else if (dirToUndo.length() > 0) {

                    // The rating update will need to be twice of
                    // the normal since we are undoing their current
                    // action
                    updatedRating *= 2;

                    String updateQuery = "UPDATE action SET action_type = ? WHERE item_id = ? AND user_id = ?";
                    psSwitchAction = connection.prepareStatement(updateQuery);

                    psSwitchAction.setString(1, actionType);
                    psSwitchAction.setLong(2, longItemId);
                    psSwitchAction.setInt(3, currentUser.getId());

                    psSwitchAction.executeUpdate();

                    connection.commit();

                    // update user's action collection
                    currentUser.getUserActions().put(String.valueOf(longItemId), actionType);
                }
                else {
                    csInsertAction = connection.prepareCall("{ CALL insertNewAction(?,?,?) }");

                    csInsertAction.setString(1, strUserName);
                    csInsertAction.setString(2, actionType);
                    csInsertAction.setLong(3, longItemId);

                    csInsertAction.executeUpdate();

                    if (actionType.equalsIgnoreCase("upvote")) {
                        currentUser.getUserActions().put(String.valueOf(longItemId), "upvote");
                    } else {
                        currentUser.getUserActions().put(String.valueOf(longItemId), "downvote");
                    }
                }

                // update the rating, regardless of what we did with the actions
                
                csUpdateRating = connection.prepareCall(" { CALL updateRating(?,?) } ");

                csUpdateRating.setInt(1, updatedRating);
                csUpdateRating.setLong(2, longItemId);
                csUpdateRating.executeUpdate();

                synchronized (request.getSession()) {
                    connection.commit();
                }
            }
            catch (SQLException ex) {

                ctx.log("error doing ACTION updates \n" + ex.getMessage());

                try {
                    connection.rollback();
                }
                catch (Exception e) {}
            }
            finally {

                try {
                    connection.close();
                    csInsertAction.close();
                    csUpdateRating.close();
                }
                catch (Exception ex) {}
            }
            String referer = request.getHeader("referer");
            if (referer != null && referer.length() > 1 && referer.contains("/submission")) {
                //send to referring page
                long itemIdPerformingActionOn = (Long) request.getSession().getAttribute("currentItemId");
                response.sendRedirect(response.encodeRedirectURL("/submission/"+itemIdPerformingActionOn));
            }
            else if (referer.contains("/new")) {
                response.sendRedirect(response.encodeRedirectURL("/new"));
            }
            else {
                response.sendRedirect(response.encodeRedirectURL("/"));
            }
        }
    }
}