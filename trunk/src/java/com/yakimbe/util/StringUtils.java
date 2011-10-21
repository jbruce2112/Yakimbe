package com.yakimbe.util;

import java.net.URL;
import java.sql.Timestamp;
import java.util.Calendar;
import java.util.Date;
import java.util.regex.Pattern;

public final class StringUtils {

    // we won't instantiate this class
    private StringUtils() {}
    
    // URL without spaces
    private static final Pattern URL_REGEX = Pattern.compile("\\b(([\\w-]+://?|www[.])[^\\s()<>]+(?:\\([\\w\\d]+\\)|([^[:punct:]\\s]|/?)))");

    public static String ToString(final Object op1) {
        if (op1 == null) {
            return "";
        }
        else {
            return op1.toString();
        }
    }

    //TODO: Set up a unit test for this function

    /* Returns time elapsed between time of invocation and time argument.
       Is returned in format of "# minutes/hours/days/weeks/months/years ago */
    public static String GetFriendlyTime(final Timestamp itemTime) {
        String friendlyTime = null;

        final long minute = (1000*60);
        final long hour = (minute*60);
        final long day = (hour*24);
        final long week = (day*7);
        final long month = (week*4);
        final long timeDiff = (System.currentTimeMillis() - itemTime.getTime());

       if (timeDiff <= (minute)) {
            friendlyTime = "just a moment";
        }
       else if (timeDiff <= (minute*50)) {
            friendlyTime = ((byte) Math.ceil((timeDiff) / (double) minute)) + " minutes";
        }
       else if (timeDiff <= (hour*1.5)) {
            friendlyTime = "an hour";
       }
       else if (timeDiff <= (hour*21)) {
            friendlyTime = ((byte) (Math.ceil(timeDiff / (double) hour))) + " hours";
       }
       else if (timeDiff <= (day*1.5)) {
           friendlyTime = "a day";
       }
       else if (timeDiff <= (day * 6)) {
           friendlyTime = (byte) Math.ceil(timeDiff / (double) day) + " days";
       }
       //weeks
       else if ((timeDiff <= (week * 1.5))) {
           friendlyTime = "about a week";
       }
       else if (((timeDiff / (double) week)) <= 7.0) {
           friendlyTime = "about " + (byte) Math.round(timeDiff / (double) week) + " weeks";
       }
       //months
       else if ((timeDiff / (double) month) <= 2.5) {
           friendlyTime = "about 2 months";
       }
       else if ((timeDiff / (double) month) <= 11.5) {
           friendlyTime = "about " + (byte) Math.round(timeDiff / (double) month) + " months";
       }
       //years
       else {
           final Calendar currTime = Calendar.getInstance();
           currTime.setTimeInMillis(new Date().getTime());

           final Calendar submissionTime = Calendar.getInstance();
           submissionTime.setTimeInMillis(itemTime.getTime());

           //years
           final byte calYearDiff = (byte) (currTime.get(Calendar.YEAR) - submissionTime.get(Calendar.YEAR));
           if (calYearDiff == 1) {
               friendlyTime = "about " + calYearDiff + " year";
           }
           else {
               friendlyTime = "about " + calYearDiff + " years";
           }
       }
        return (friendlyTime + " ago");
    }

    //strips out protocol (http://, ftp://). Useful for display URLs on-screen.
    public static String StripOutProtocol(final String url) {
        String shortUrl = url;
        String longUrl = url;

        //atempt to strip out protocol
        if (longUrl.contains("://")) {
            shortUrl = longUrl.substring(longUrl.indexOf('/')+2, longUrl.length());
        }
        return shortUrl;
    }

    //convenience method for EL functions.
    public static String GetPrettyDomain(final String url) {
        return StripOutProtocol(GetDomainName(url));
    }

    /* returns only the root domain name of input address.
        EX: Input: http://www.google.com/someotherstuff/?junk
            Outputs: http://www.google.com  */
    public static String GetDomainName(final String url) {

        String shortUrl = url;

        try {
            String domain = new URL(url).getAuthority();
            String protocol = new URL(url).getProtocol() + "://";
            shortUrl = protocol + domain;
        }
        catch (Exception ex) {}

        return shortUrl;
    }

    public static String EscapeSmartQuotes(final String s) {
        String htmlSafe = s;

        if(s == null) return null;

        // left single quote
        if (s.contains("\u2018")) {
            htmlSafe = htmlSafe.replace("\u2018", "&#8216;");
        }
        // right single quote
        if (s.contains("\u2019")) {
            htmlSafe = htmlSafe.replace("\u2019", "&#8217;");
        }
        // left double quote
        if (s.contains("\u201C")) {
            htmlSafe = htmlSafe.replace("\u201C", "&#8220;");
        }
        // right double quote
        if (s.contains("\u201D")) {
            htmlSafe = htmlSafe.replace("\u201D", "&#8221;");
        }
        return htmlSafe;
    }

    public static String HeadlineFormatting(final String in) {
        String result = in.replaceAll(">", "&gt;");
        result = result.replaceAll("<", "&lt;");
        result = EscapeSmartQuotes(result);
        return result;
    }
    

    /*  Escaping the '<' & '>' ourselves feels dangerous. We can't depend
        on <c:out/> here because we need to add the br & a tags to render.   */
    public static String HTMLFormatting(final String s) {
        
        String result = s.replaceAll("<", "&lt;");
        result = result.replaceAll(">", "&gt;");

        // replace each match of a URL with an anchor tag surrounding it
        result = URL_REGEX.matcher(result).replaceAll("<a href='$0' class='commentURL'>$0</a>");

        result = result.replaceAll("\r", "<br>");
        
        return result;
    }
    
    // if the input came from a POST request, the line breaks are composed of
    // a carriage return followed by a newline for each of them. If they came from a
    // javascript-triggered GET request, they are only newlines. This method handles both.
    public static String RemoveTrailingReturns(final String s) {

        StringBuilder input = new StringBuilder(s);

        while (input.toString().endsWith("\n") || input.toString().endsWith("\r")) {
            input.delete(input.length()-1, input.length());
            if (input.toString().endsWith("\n")) {
                System.out.println("removed a newline from comment");
            }
            if (input.toString().endsWith("\r")) {
                System.out.println("removed a cr from comment");
            }
        }
        return input.toString();
    }
}
