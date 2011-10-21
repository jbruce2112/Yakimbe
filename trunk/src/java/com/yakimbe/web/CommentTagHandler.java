package com.yakimbe.web;

import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.SimpleTagSupport;
import java.io.IOException;
import java.util.*;
import com.yakimbe.model.Comment;

public class CommentTagHandler extends SimpleTagSupport {

    List<Comment> comments = new ArrayList<Comment>();
    List<Integer> commentIdsAlreadyPrinted = new ArrayList<Integer>();
    int nestLevel = 1;
    JspWriter out;
    String var;

    @Override
    public void doTag() throws JspException {

        final long startTime = new java.util.Date().getTime();

        out = getJspContext().getOut();

        for (Comment topComment : comments) {

            // only concerned with top-level comments here
            if (topComment.getParentCommentId() == 0) {
                try {
                    //reset the nesting level
                    nestLevel = 1;

                    out.println("<ul class='comment-root'>");

                    //synchronize variables for attributes of comment tag file
                    getJspContext().setAttribute(var, topComment);
                    getJspContext().setAttribute("mylevel", nestLevel);

                    getJspBody().invoke(null);

                    printChildren(topComment.getCommentId());

                    out.println("</ul>");
                }
                catch (IOException ex) {}
            }
        }

        final long endTime = new java.util.Date().getTime();

        System.out.println("Comments tag handler took " + (endTime-startTime) + " millis");
    }

    
    private void printChildren(int parentCommentId) throws IOException, JspException {

        boolean moreCommentsAtThisLevel = false;

        if (getNextCommentAtCurrentLevel(parentCommentId) != -1) {
            out.println("<ul class='comment-reply'>");

            do {
                int commentIndex = getNextCommentAtCurrentLevel(parentCommentId);

                if (commentIndex != -1) {
                    
                    commentIdsAlreadyPrinted.add(commentIndex);

                    nestLevel++;
                    moreCommentsAtThisLevel = true;
                    Comment currentComment = comments.get(commentIndex);

                    //TODO: We could optimize the traversing of the collection if we remove these
                    //comments.remove(commentIndex);

                    //synchronize variables for attributes of comment tag file
                    getJspContext().setAttribute(var, currentComment);
                    getJspContext().setAttribute("mylevel", nestLevel);

                    getJspBody().invoke(null);

                    //recursively call this again to find however many children this comment may have
                    printChildren(currentComment.getCommentId());
                }
                else {
                    moreCommentsAtThisLevel = false;
                    //back up the nesting level because we're done with this current hierarchy
                    nestLevel--;
                }
            } while (moreCommentsAtThisLevel);

            out.println("</ul>");

        }
    }
    
    private int getNextCommentAtCurrentLevel(int parentCommentId) {
        
        int commentIndex = 0;
        boolean commentFound = false;

        for (commentIndex = 0; commentIndex < comments.size(); commentIndex++) {

            if (comments.get(commentIndex).getParentCommentId() == parentCommentId && 
                                        !commentIdsAlreadyPrinted.contains(commentIndex)) {
                commentFound = true;
                break;
            }
        }
        // this tells us there are no comments at this level
        if (!commentFound) {
            commentIndex = -1;
        }
        return commentIndex;
    }
    
    //TODO: This whole level int/string setting is a bit hacked together.
    public void setLevel(String level) {
        this.nestLevel = 1;
    }

    public void setTree(Set<Comment> c) {
        comments.addAll(c);
        //sort by rating (descending)
        Collections.sort(comments, Collections.reverseOrder());
    }

    public void setVar(String v) {
        this.var = v;
    }
}
