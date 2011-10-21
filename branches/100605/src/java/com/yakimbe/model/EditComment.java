package com.yakimbe.model;

import java.sql.Timestamp;
import java.text.DateFormat;
import java.io.Serializable;
import java.io.IOException;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;

public class EditComment implements Serializable {
    private Timestamp timeCreated;
    private String comment;
    private long itemId;
    
    private static final long serialVersionUID = 2725452973l;

    public EditComment(String comment, Timestamp timeCreated) {
        this.comment = comment;
        this.timeCreated = timeCreated;
    }

    public long getItemId() {
        return itemId;
    }

    public void setItemId(long itemId) {
        this.itemId = itemId;
    }

    public String getComment() {
        return comment;
    }

    public void setComment(String comment) {
        this.comment = comment;
    }

    public Timestamp getTimeCreated() {
        return timeCreated;
    }

    public void setTimeCreated(Timestamp timeCreated) {
        this.timeCreated = timeCreated;
    }

    public String getFriendlyTimeCreated() {

        DateFormat df = DateFormat.getDateTimeInstance(DateFormat.SHORT, DateFormat.SHORT);

        String friendlyTime = df.format(this.getTimeCreated());

        return friendlyTime;

    }

    private void readObject(ObjectInputStream s) throws ClassNotFoundException, IOException {
        System.out.println("editcomment read object called");
        s.defaultReadObject();
    }

    private void writeObject(ObjectOutputStream s) throws IOException{
        System.out.println("editcomment write object called");
        s.defaultWriteObject();
    }

}
