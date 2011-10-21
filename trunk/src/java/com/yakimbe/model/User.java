package com.yakimbe.model;

import java.util.Calendar;
import java.util.Date;
import java.io.IOException;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.io.Serializable;
import java.util.Map;
import java.util.List;

public class User implements Serializable {

    private String strUserName;
    private String strFirstName;
    private String strLastName;
    private String strDescription;
    private String strWebsite;
    private String strEmail;
    private Date dateRegistrationDate;
    private String strLocation;
    private int intUserId;
    private int intNumItemsPage = 20;
    private boolean isAdmin;
    private int rating;
    private String facebook;
    private String myspace;
    private String linkedin;
    private String flickr;
    private boolean isEmailOptedIn;
    private String sex;
    private int birthYear;
    private Map userActions;
    private long timeSinceLastSubmission;
    private Map notifications;
    private String facebookID;

    // 30 seconds
    public static final int MIN_MILLIS_ALLOWED_BETWEEN_SUBMISSIONS = 30000;

    private static final long serialVersionUID = 27297559345l;

    public User() {
        
    }

    public User(int userId, String userName, String firstName,
                String lastName, String description, String website,
                String email, Date registrationDate, String location, int numItemsPage, boolean isAdmin, String sex, int birthYear, boolean emailOptIn, Map userActions) {

        this.strUserName = userName;
        this.strFirstName = firstName;
        this.strLastName = lastName;
        this.strDescription = description;
        this.strWebsite = website;
        this.strEmail = email;
        this.dateRegistrationDate = registrationDate;
        this.strLocation = location;
        this.intUserId = userId;
        this.intNumItemsPage = numItemsPage;
        this.isAdmin = isAdmin;
        this.sex = sex;
        this.birthYear = birthYear;
        this.isEmailOptedIn = emailOptIn;
        this.userActions = userActions;
    }

    public String getFacebookID() {
        return facebookID;
    }

    public void setFacebookID(String facebookID) {
        this.facebookID = facebookID;
    }



    @Override
    public boolean equals(Object obj) {
        if (obj == null) {
            return false;
        }
        if (getClass() != obj.getClass()) {
            return false;
        }
        final User other = (User) obj;
        if (this.intUserId != other.intUserId) {
            return false;
        }
        return true;
    }

    @Override
    public int hashCode() {
        int hash = 7;
        hash = 47 * hash + this.intUserId;
        return hash;
    }

    public void setRegistrationDate(Date dateRegistrationDate) {
        this.dateRegistrationDate = dateRegistrationDate;
    }

    public void setUserId(int intUserId) {
        this.intUserId = intUserId;
    }


    public Map<String,List> getNotifications() {
        return notifications;
    }

    public void setNotifications(Map<String,List> notifications) {
        this.notifications = notifications;
    }

    public boolean isSubmissionAllowed() {
        if (System.currentTimeMillis() - this.getTimeSinceLastSubmission() >= MIN_MILLIS_ALLOWED_BETWEEN_SUBMISSIONS) {
            System.out.print("Submission allowed");
            return true;
        }
        else {
            System.out.print("Submission note allowed");
            return false;
        }
    }

    public long getTimeSinceLastSubmission() {
        return timeSinceLastSubmission;
    }

    public void setTimeSinceLastSubmission(long timeSinceLastSubmission) {
        this.timeSinceLastSubmission = timeSinceLastSubmission;
    }

    public Map getUserActions() {
        return userActions;
    }

    public void setUserActions(Map userActions) {
        this.userActions = userActions;
    }

    public void setAdmin(boolean isAdmin) {
        this.isAdmin = isAdmin;
    }

    public void setUserName(String un) {
        this.strUserName = un;
    }

    public String getFriendlyDisplayName() {
        if (this.getFirstName() != null && this.getFirstName().trim().length() > 0) {
            return this.getFirstName();
        }
        else {
            return this.getUserName();
        }
    }

    public boolean isEmailOptedIn() {
        return this.isEmailOptedIn;
    }

    public void setSex(String sex) {
        this.sex = sex;
    }

    public void setBirthYear(int birthyear) {
        this.birthYear = birthyear;
    }

    public String getSex() {
        return this.sex;
    }

    public int getBirthYear() {
        return this.birthYear;
    }

    public boolean isAuthenticated() {
        boolean authenticated = false;

        if (getFirstName().trim().length() > 0 &&
            getLastName().trim().length() > 0 &&
            getLocation().length() > 0 &&
            getSex().length() > 0 &&
            getDescription().trim().length() > 0) {

            authenticated = true;
        }
        return authenticated;
    }

    public String getFacebook() {
        return facebook;
    }

    public String getFlickr() {
        return flickr;
    }

    public String getLinkedin() {
        return linkedin;
    }

    public String getMyspace() {
        return myspace;
    }

    public String getFriendlyTimeOnSite() {

        String friendlyTime = null;

        final long minute = (1000*60);
        final long hour = (minute*60);
        final long day = (hour*24);
        final long week = (day*7);
        final long month = (week*4);
        final long timeDiff = (new Date().getTime() - getRegistrationDate().getTime());


        if (timeDiff <= (long) (day * 5)) {
            friendlyTime = "less than a week";
        }
        else if ((timeDiff <= (long) (week * 1.5))) {
            friendlyTime = "about 1 week";
        }
        else if (((byte) (timeDiff / week)) <= 7) {
            friendlyTime = "about " + (byte) Math.round((double) timeDiff / (double) week) + " weeks";
        }
       //months
       else if ((timeDiff / (double) month) <= 2.5) {
           friendlyTime = "about 2 months";
       }
       else if ((timeDiff / (double) month) <= 11.5) {
           friendlyTime = "about " + (byte) Math.round((double) timeDiff / (double) month) + " months";
       }
       //years
       else {
           final Calendar currTime = Calendar.getInstance();
           currTime.setTimeInMillis(new Date().getTime());

           final Calendar submissionTime = Calendar.getInstance();
           submissionTime.setTimeInMillis(getRegistrationDate().getTime());

           //years
           byte calYearDiff = (byte) (currTime.get(Calendar.YEAR) - submissionTime.get(Calendar.YEAR));
           if (calYearDiff == 1) {
               friendlyTime = "about " + calYearDiff + " year";
           }
           else {
               friendlyTime = "about " + calYearDiff + " years";
           }
       }
        return friendlyTime;
    }

    public void setRating(int rating) {
        this.rating = rating;
    }

    public int getRating() {
        return rating;
    }

    public boolean isAdmin() {
        return this.isAdmin;
    }

    public int getId() {
        return this.intUserId;
    }

    public Date getRegistrationDate() {
        return dateRegistrationDate;
    }

    public String getDescription() {
        return strDescription;
    }

    public int getNumItemsPage() {
        return intNumItemsPage;
    }

    public String getEmail() {
        return strEmail;
    }

    public String getFirstName() {
        return strFirstName;
    }

    public String getLastName() {
        return strLastName;
    }

    public String getLocation() {
        return strLocation;
    }

    public String getUserName() {
        return strUserName;
    }

    public String getWebsite() {
        return strWebsite;
    }

    public void setFacebook(String facebook) {
        this.facebook = facebook;
    }

    public void setFlickr(String flickr) {
        this.flickr = flickr;
    }

    public void setNumItemsPage(int intNumItemsPage) {
        this.intNumItemsPage = intNumItemsPage;
    }

    public void setEmailOptedIn(boolean isEmailOptedIn) {
        this.isEmailOptedIn = isEmailOptedIn;
    }

    public void setLinkedin(String linkedin) {
        this.linkedin = linkedin;
    }

    public void setMyspace(String myspace) {
        this.myspace = myspace;
    }

    public void setDescription(String strDescription) {
        this.strDescription = strDescription;
    }

    public void setEmail(String strEmail) {
        this.strEmail = strEmail;
    }

    public void setFirstName(String strFirstName) {
        this.strFirstName = strFirstName;
    }

    public void setLastName(String strLastName) {
        this.strLastName = strLastName;
    }

    public void setLocation(String strLocation) {
        this.strLocation = strLocation;
    }

    public void setWebsite(String strWebsite) {
        this.strWebsite = strWebsite;
    }


    public String getFullDisplayName() {
        return this.getFirstName() + " " + this.getLastName();
    }

    private void readObject(ObjectInputStream s) throws IOException, ClassNotFoundException{
        System.out.println("user read object called");
        s.defaultReadObject();
    }

    private void writeObject(ObjectOutputStream s) throws IOException {
        System.out.println("user write object called");
        s.defaultWriteObject();
    }

    @Override
    public String toString() {
        StringBuilder sb = new StringBuilder();
        sb.append("First Name: ");
        sb.append(this.getFirstName());
        sb.append(" Last Name: ");
        sb.append(this.getLastName());
        if (this.getFacebookID() != null) {
            sb.append(" FB ID: ");
            sb.append(this.getFacebookID());
        }
        sb.append(" Desc: ");
        sb.append(this.getDescription());
        sb.append(" E-mail: ");
        sb.append(this.getEmail());
        sb.append(" website: ");
        sb.append(this.getWebsite());
        return sb.toString();
    }


}