package com.yakimbe.model;

import java.io.IOException;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.io.Serializable;
import java.sql.Timestamp;
import java.util.Date;
import java.util.Calendar;
import java.text.DateFormat;
import java.util.List;

public abstract class Submission implements Comparable <Submission>,  Serializable {

    private long itemId;
    private Timestamp submissionTime;
    private short rating;
    private String type;
    private String userName;
    private int userId;
    private String procType;
    private int numComments;
    private List editNotes;
    private String popularity;

    private static final long SERIAL_ID = 37297593475l;


    public Submission() {
        System.out.println("Submissions default no-arg constructor was called");
    }

    public Submission(long itemId, int userId, String userName, Timestamp submissionTime,
                                    short rating, String type, String pType, int numComments) {
        this.itemId = itemId;
        this.submissionTime = submissionTime;
        this.rating = rating;
        this.type = type;
        this.userName = userName;
        this.userId = userId;
        this.procType = pType;
        this.numComments = numComments;
    }

    public String getPopularity() {
        return popularity;
    }

    public void setPopularity(String popularity) {
        this.popularity = popularity;
    }

    public List getEditNotes() {
        return editNotes;
    }

    public void setEditNotes(List<EditComment> editNotes) {
        this.editNotes = editNotes;
    }

    public int getNumComments() {
        return numComments;
    }

    //Uses Short's compareTo() ( natural numerical order)
    @Override
    public int compareTo(Submission o) {
        return ((Short)this.rating).compareTo(o.getRating());
    }

    public void setProcType(String s) {
        this.procType = s;
    }

    public String getProcType() {
        return this.procType;
    }

    public int getUserId() {
        return userId;
    }

    public String getUserName() {
        return userName;
    }

    public long getItemId() {
        return itemId;
    }

    public short getRating() {
        return rating;
    }

    public Timestamp getSubmissionTime() {
        return submissionTime;
    }

    public String getType() {
        return type;
    }

    public String getFriendlyTime() {
        return com.yakimbe.util.StringUtils.GetFriendlyTime(this.getSubmissionTime());
    }

    private void readObject(ObjectInputStream s) throws ClassNotFoundException, IOException {
        System.out.println("submission read object called");
        s.defaultReadObject();
    }

    private void writeObject(ObjectOutputStream s) throws IOException{
        System.out.println("submission write object called");
        s.defaultWriteObject();
    }

    @Override
    public boolean equals(Object o) {
        Submission s;
        
        if (o instanceof Submission) {
            s = (Submission) o;
            return (this.getItemId() == s.getItemId());
        }
        else {
            return false;
        }
    }

    @Override
    public int hashCode() {
        int hash = 5;
        hash = 83 * hash + (int) (this.getItemId() ^ (this.getItemId() >>> 32));
        return hash;
    }

}
