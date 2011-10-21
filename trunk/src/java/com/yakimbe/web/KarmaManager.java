package com.yakimbe.web;

import javax.sql.*;
import java.sql.*;
import javax.servlet.ServletContext;
import com.yakimbe.model.User;

/*
 * @author John
 *
 * Date: 06/03/2010
 *
 * KarmaManager class is not meant to be
 * instantiated. All methods are static.
 *
 * Class contains all logic for calculating
 * karma and updating the database for different
 * events that affect a user's karma.
 *
 * The DataSource and ServletContext are set
 * once, on application startup.
 */

public final class KarmaManager {

    private static final int POINTS_PER_COMMENT_VOTE = 2;
    private static final int FIRST_COMMENT_VOTE_MULT = 6;

    // TODO: Perhaps we should change rating in the db to a float-point type,
    // I don't think submission votes should be >= 1 point. We could round
    // to nearest int on the display but hold the fp value in the backend.
    private static final int POINTS_PER_SUBMISSION_VOTE = 1;
    private static final int FIRST_SUBMISSION_VOTE_MULT = 2;

    private static final int POINTS_PER_SUBMISSION = 2;
    private static final int FIRST_SUBMISSION_MULT = 5;

    private static final int POINTS_PER_COMMENT = 1;
    private static final int FIRST_COMMENT_MULT = 4;

    private static final String UPDATE_Q = "UPDATE user SET rating = rating + ? " +
                                           "WHERE user_id = (SELECT user_id FROM user WHERE user_id = ?)";
    private static DataSource dsn;
    private static ServletContext ctx;

    public KarmaManager() {
        // empty
    }

    public static void setDSN(final DataSource dsn) {
        KarmaManager.dsn = dsn;
    }

    public static void setContext(final ServletContext ctx) {
        KarmaManager.ctx = ctx;
    }

    public static void UserPostComment(Connection conn, final User u) throws SQLException {
        PreparedStatement psUpdate = null;
        PreparedStatement psMultipler = null;
        int multiplier = 1;
        ResultSet rs = null;
        String multiplierQ;

        // first comment?
        multiplierQ = "SELECT count(*) FROM comment c INNER JOIN item i ON c.item_id = i.item_id WHERE i.user_id = ?";

        try {
            conn = dsn.getConnection();
            psUpdate = conn.prepareCall(UPDATE_Q);

            psMultipler = conn.prepareCall(psMultipler.toString());
            psMultipler.setInt(1, u.getId());

            rs = psMultipler.executeQuery();

            if (!rs.next()) {
                multiplier = FIRST_COMMENT_MULT;
            }

            psUpdate.setInt(1, POINTS_PER_COMMENT * multiplier);
            psUpdate.setInt(2, u.getId());

            psUpdate.executeUpdate();
        }
        catch (SQLException sql) {
            throw new SQLException("UserPostComment error - " + sql.getMessage());
        }
        finally {
            try {
                rs.close();
                psMultipler.close();
                psUpdate.close();
            }
            catch (Exception e) {}
        }
    }

    public static void UserPostSubmission(Connection conn, final User u) throws SQLException {
        PreparedStatement psUpdate = null;
        PreparedStatement psMultipler = null;
        int multiplier = 1;
        ResultSet rs = null;
        String multiplerQ;

        // first submission?
        multiplerQ = "SELECT count(*) FROM item WHERE item_type IS NOT 'comment' AND user_id = ?";

        try {
            conn = dsn.getConnection();
            psUpdate = conn.prepareCall(UPDATE_Q);

            psMultipler = conn.prepareCall(psMultipler.toString());
            psMultipler.setInt(1, u.getId());

            rs = psMultipler.executeQuery();

            if (!rs.next()) {
                multiplier = FIRST_SUBMISSION_MULT;
            }

            psUpdate.setInt(1, POINTS_PER_SUBMISSION * multiplier);
            psUpdate.setInt(2, u.getId());

            psUpdate.executeUpdate();
        }
        catch (SQLException sql) {
            throw new SQLException("UserPostSubmission error - " + sql.getMessage());
        }
        finally {
            try {
                rs.close();
                psMultipler.close();
                psUpdate.close();
            }
            catch (Exception e) {}
        }
    }

    public static void UserGetCommentVote(Connection conn, final User u) throws SQLException {
        PreparedStatement psUpdate = null;
        PreparedStatement psMultipler = null;
        int multiplier = 1;
        ResultSet rs = null;
        String multiplerQ;

        // first comment vote?
        //multiplerQ = // TODO: Either need to store new fields in DB to figure this out or forget the multipler here.

        try {
            conn = dsn.getConnection();
            psUpdate = conn.prepareCall(UPDATE_Q);

            psMultipler = conn.prepareCall(psMultipler.toString());
            psMultipler.setInt(1, u.getId());

            rs = psMultipler.executeQuery();

            if (!rs.next()) {
                multiplier = FIRST_COMMENT_VOTE_MULT;
            }

            psUpdate.setInt(1, POINTS_PER_COMMENT_VOTE * multiplier);
            psUpdate.setInt(2, u.getId());

            psUpdate.executeUpdate();
        }
        catch (SQLException sql) {
            throw new SQLException("UserGetCommentVote error - " + sql.getMessage());
        }
        finally {
            try {
                rs.close();
                psMultipler.close();
                psUpdate.close();
            }
            catch (Exception e) {}
        }
    }

    public static void UserGetSubmissionVote(Connection conn, final User u) throws SQLException {
        PreparedStatement psUpdate = null;
        PreparedStatement psMultipler = null;
        int multiplier = 1;
        ResultSet rs = null;
        String multiplerQ;

        // first submission vote?
        //multiplerQ = // TODO: Either need to store new fields in DB to figure this out or forget the multipler here.

        try {
            conn = dsn.getConnection();
            psUpdate = conn.prepareCall(UPDATE_Q);

            psMultipler = conn.prepareCall(psMultipler.toString());
            psMultipler.setInt(1, u.getId());

            rs = psMultipler.executeQuery();

            if (!rs.next()) {
                multiplier = FIRST_SUBMISSION_VOTE_MULT;
            }

            psUpdate.setInt(1, POINTS_PER_SUBMISSION_VOTE * multiplier);
            psUpdate.setInt(2, u.getId());

            psUpdate.executeUpdate();
        }
        catch (SQLException sql) {
            throw new SQLException("UserGetSubmissionVote error - " + sql.getMessage());
        }
        finally {
            try {
                rs.close();
                psMultipler.close();
                psUpdate.close();
            }
            catch (Exception e) {}
        }
    }
}
