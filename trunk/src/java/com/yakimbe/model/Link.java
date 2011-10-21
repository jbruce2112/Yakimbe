package com.yakimbe.model;

import java.sql.Timestamp;
import java.util.List;
import java.util.ArrayList;

public class Link extends Submission {
    
    private long linkId;
    private String headline;
    private String subhead;
    private String url;

    public Link() {
        System.out.println("Submission's no-arg constructor was called");
    }

    public Link(long itemId, long linkId, int userId, String userName, Timestamp submissionTime,
                                        short rating,String headline, String subhead, String url,String pType,int numComments) {

        super(itemId,userId, userName,submissionTime,rating,"link",pType,numComments);

        this.linkId = linkId;
        this.headline = headline;
        this.subhead = subhead;
        this.url = url;
    }

    public void setHeadline(String headline) {
        this.headline = headline;
    }

    public void setSubhead(String subhead) {
        this.subhead = subhead;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    public long getLinkId() {
        return linkId;
    }

    public String getSubhead() {
        return subhead;
    }

    public String getHeadline() {
        return headline;
    }

    public String getUrl() {
        return url;
    }
}