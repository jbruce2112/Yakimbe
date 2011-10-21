package com.yakimbe.model;

import java.sql.Timestamp;

public class Comment extends Submission{

    private int commentId;
    private long itemCommentingOnId;
    private String body;
    private long parentCommentId;

    public Comment() {
        System.out.println("Comment's no-arg contructor was called.");
    }

    public Comment(long itemId,int userId, String userName,Timestamp submissionTime, 
                                short rating, int commentId, long itemCommentingOnId,String body,long parentCommentId) {
        
        super(itemId,userId, userName,submissionTime,rating,"comment", null,0);
        
        this.commentId = commentId;
        this.itemCommentingOnId = itemCommentingOnId;
        this.body = body;
        this.parentCommentId = parentCommentId;
    }

    public void setBody(String body) {
        this.body = body;
    }

    //Uses Submission's compareTo() ( natural numerical order)
    @Override
    public int compareTo(Submission o) {
        int ratingResult = super.compareTo(o);

        // if same rating, sort by date
        if (ratingResult == 0) {
            return this.getSubmissionTime().compareTo(o.getSubmissionTime());
        }
        else {
            return ratingResult;
        }
    }

    public String getBody() {
        return body;
    }

    public int getCommentId() {
        return commentId;
    }

    public long getItemCommentingOnId() {
        return itemCommentingOnId;
    }

    public long getParentCommentId() {
        return parentCommentId;
    }
}