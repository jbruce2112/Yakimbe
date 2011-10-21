package com.yakimbe.model;

import com.yakimbe.util.StringUtils;
import java.sql.Timestamp;


public class Notification {

    private long itemId;
    private Timestamp time;
    private String itemHeadline;
    private long itemCommentingOnId;
    private String itemCommentingOnHeadline;
    private int numReplies;
    private Type type;

    public enum Type {
        COMMENT, ITEM
    }

    public Type getType() {
        return this.type;
    }

    public void setType(Type type) {
        this.type = type;
    }

    public int getNumReplies() {
        return this.numReplies;
    }

    public void setNumReplies(int numReplies) {
        this.numReplies = numReplies;
    }

    public String getFriendlyTime() {
        return StringUtils.GetFriendlyTime(time);
    }

    public String getItemCommentingOnHeadline() {
        return itemCommentingOnHeadline;
    }

    public void setItemCommentingOnHeadline(String itemCommentingOnHeadline) {
        this.itemCommentingOnHeadline = itemCommentingOnHeadline;
    }

    public Notification (long itemId, Timestamp time) {
        this.itemId = itemId;
        this.time = time;
    }

    @Override
    public boolean equals(Object obj) {
        if (obj == null) {
            return false;
        }
        if (getClass() != obj.getClass()) {
            return false;
        }
        final Notification other = (Notification) obj;
        if (this.itemId != other.itemId) {
            return false;
        }
        System.out.println("equals called for itemId " + other.itemId);
        return true;
    }
    
    @Override
    public int hashCode() {
        int hash = 3;
        hash = 23 * hash + (int) (this.itemId ^ (this.itemId >>> 32));
        return hash;
    }

    public long getItemCommentingOnId() {
        return itemCommentingOnId;
    }

    public void setItemCommentingOnId(long itemCommentingOnId) {
        this.itemCommentingOnId = itemCommentingOnId;
    }

    public String getItemHeadline() {
        return itemHeadline;
    }

    public void setItemHeadline(String itemHeadline) {
        this.itemHeadline = itemHeadline;
    }

    public long getItemId() {
        return itemId;
    }

    public void setItemId(long itemId) {
        this.itemId = itemId;
    }

    public Timestamp getTime() {
        return time;
    }

    public void setTime(Timestamp time) {
        this.time = time;
    }
}
