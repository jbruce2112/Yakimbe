package com.yakimbe.util;

import com.yakimbe.model.User;
import java.net.URL;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.regex.Pattern;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import net.tanesha.recaptcha.ReCaptchaImpl;
import net.tanesha.recaptcha.ReCaptchaResponse;


public final class ValidateInput {

    //New User constants
    private static final int FIRSTNAME_MAX_LENGTH = 50;
    private static final int FIRSTNAME_MIN_LENGTH = 2;

    private static final int LASTNAME_MAX_LENGTH = 50;
    private static final int LASTNAME_MIN_LENGTH = 2;

    private static final int USERNAME_MAX_LENGTH = 30;
    private static final int USERNAME_MIN_LENGTH = 2;

    private static final int PASSWORD_MAX_LENGTH = 30;
    private static final int PASSWORD_MIN_LENGTH = 2;

    private static final int EMAIL_MAX_LENGTH = 255;
    private static final int EMAIL_MIN_LENGTH = 6;

    private static final int MAX_DESC_LENGTH = 1000;

    //Link Submission constants
    private static final int HEADLINE_MAX_LENGTH = 70;
    private static final int HEADLINE_MIN_LENGTH = 10;

    private static final int SUBHEAD_MAX_LENGTH = 90;
    private static final int SUBHEAD_MIN_LENGTH = 10;

    private static final int URL_MAX_LENGTH = 2000;
    private static final int URL_MIN_LENGTH = 10;

    private static final int COMMENT_MAX_LENGTH = 2000;
    private static final int COMMENT_MIN_LENGTH = 1;

    private static final int EDIT_NOTE_MAX_LENGTH = 140;
    
    //REGEX

    //only letters allowed. hyphen optional but nested between letters.
    private static final Pattern regexName = Pattern.compile("(?i)[A-Z]+[-]?(?i)[A-Z]+");
    //letters, numbers, underscores and hyphens allowed. hyphen must be nested between letters/numbers if included
    private static final Pattern regexUserName = Pattern.compile("((?i)[A-Z\\d_0-9]+[-]?(?i)[A-Z_0-9]+)*?");
    // from regular-expressions.info/email
    private static final Pattern regexEmail = Pattern.compile("(?i)^[A-Z0-9._%+-]+@[A-Z0-9.-]+\\.[A-Z]{2,4}$");

    public static boolean isCaptchaValid(HttpServletRequest request) {
       final String remoteAddr = request.getRemoteAddr();
       final ReCaptchaImpl reCaptcha = new ReCaptchaImpl();
       reCaptcha.setPrivateKey("6LcQpQsAAAAAAL402t_CDlRx3FLqOjfPZNe5pV-N ");

       final String challenge = request.getParameter("recaptcha_challenge_field");
       final String uresponse = request.getParameter("recaptcha_response_field");

       if (uresponse != null && uresponse.length() > 0) {
        final ReCaptchaResponse reCaptchaResponse = reCaptcha.checkAnswer(remoteAddr, challenge, uresponse);

        return reCaptchaResponse.isValid();
       }
       else {
           return false;
       }
    }

    public static List<String> getCommentEditValidationErrors(String body, String editNote, String commentId) {
        final List<String> errors = new ArrayList<String>();


        if (body == null || body.trim().length() < 1) {
            errors.add("Comment body is required");
        }
        else if (!isValidLength(body, COMMENT_MIN_LENGTH, COMMENT_MAX_LENGTH)) {
            errors.add("Comment must be between " + COMMENT_MIN_LENGTH + " & " + COMMENT_MAX_LENGTH + " characters");
        }

        if (editNote != null && editNote.trim().length() > EDIT_NOTE_MAX_LENGTH) {
            errors.add("Edit note must be less than " + EDIT_NOTE_MAX_LENGTH + " characters");
        }

        try {
            Integer.parseInt(commentId);
        }
        catch (Exception e) {
            errors.add("Invalid comment id format");
        }

        return errors;

    }

    public static List<String> getChangePasswordValidationErrors(String oldPw, String newPw1, String newPw2) {
        final List<String> errors = new ArrayList<String>();

        // New PW
        if (newPw1.length() == 0 && newPw2.length() == 0) {
            errors.add("Please enter your new password");
        }
        else if (!newPw1.equals(newPw2)) {
            errors.add("Your new password entries do not match.");
        }
        else if (newPw1.equals(oldPw)) {
            errors.add("Your new password is the same as your current password.");
        }
        else if (!isValidLength(newPw1,PASSWORD_MIN_LENGTH,PASSWORD_MAX_LENGTH)) {
            errors.add("New password must be between " + PASSWORD_MIN_LENGTH + " & " + PASSWORD_MAX_LENGTH + " characters.");
        }

        return errors;
    }

    public static List<String> getLinkEditValidationErrors(String strHeadline, String strSubhead, String strUrl, String editNote) {
        final List<String> errors = new ArrayList<String>();

        // get validation errors for everything but the edit comment
        errors.addAll(ValidateInput.getLinkValidationErrors(strHeadline, strSubhead, strUrl));

        if (editNote != null && editNote.trim().length() > EDIT_NOTE_MAX_LENGTH) {
            errors.add("Edit note must be beteween " + EDIT_NOTE_MAX_LENGTH + " characters");
        }

        return errors;

    }

    public static List<String> getCommentValidationErrors(HttpServletRequest req, String body, String parentId, String itemCommentingOnId) {

        final List<String> errors = new ArrayList<String>();

        final User user = (User) req.getSession().getAttribute("user");

        if (user == null) {
            errors.add("You must be logged in to comment");
        }

        //TODO: check for illegal body chars here? What's illegal?
        if (body == null || body.trim().length() < 1) {
            errors.add("Comment body is required");
        }
        else if (!isValidLength(body, COMMENT_MIN_LENGTH, COMMENT_MAX_LENGTH)) {
            errors.add("Comment must be between " + COMMENT_MIN_LENGTH + " & " + COMMENT_MAX_LENGTH + " characters");
        }

        try {
            System.out.println(parentId);
            Long.parseLong(parentId);
        }
        catch (NumberFormatException e) {
            errors.add("Invalid parent ID format");
        }

        try {
            System.out.println(itemCommentingOnId);
            Long.parseLong(itemCommentingOnId);
        }
        catch (NumberFormatException e) {
            errors.add("Invalid item commenting on ID format");
        }

        return errors;
    }

    public static void validateFirstName(String firstname, List errors) {
        if (firstname != null && !firstname.trim().isEmpty()) {
            if (!regexName.matcher(firstname).matches()) {
                errors.add("Illegal characters in first name");
            } else if (!isValidLength(firstname, FIRSTNAME_MIN_LENGTH, FIRSTNAME_MAX_LENGTH)) {
                errors.add("First name must be between " + FIRSTNAME_MIN_LENGTH + " & " + FIRSTNAME_MAX_LENGTH + " characters.");
            }
        }
    }

    public static void validateLastName(String lastname, List errors) {
        if (lastname != null && !lastname.trim().isEmpty()) {
            if (!regexName.matcher(lastname).matches()) {
                errors.add("Illegal characters last name");
            } else if (!isValidLength(lastname, LASTNAME_MIN_LENGTH, LASTNAME_MAX_LENGTH)) {
                errors.add("Last name must be between " + LASTNAME_MIN_LENGTH + " & " + LASTNAME_MAX_LENGTH + " characters.");
            }
        }
    }

    public static void validateUserName(String username, List errors) {
        if (!regexUserName.matcher(username).matches()) {
            errors.add("Illegal character in username");
        }
        else if (!isValidLength(username,USERNAME_MIN_LENGTH,USERNAME_MAX_LENGTH)) {
            errors.add("User name must be between " + USERNAME_MIN_LENGTH + " & " + USERNAME_MAX_LENGTH + " characters.");
        }
    }

    public static void validatePassword(String pw1, String pw2, List errors) {
        if (pw1.length() == 0 && pw2.length() == 0) {
            errors.add("Password is required");
        }
        else if (!pw1.equals(pw2)) {
            errors.add("Passwords do not match.");
        }
        else if (!isValidLength(pw1,PASSWORD_MIN_LENGTH,PASSWORD_MAX_LENGTH)) {
            errors.add("Password must be between " + PASSWORD_MIN_LENGTH + " & " + PASSWORD_MAX_LENGTH + " characters.");
        }
    }

    public static void validateEmail(String email, List errors) {
        if (email.length() == 0) {
            errors.add("E-mail address is required.");
        }
        else if (!regexEmail.matcher(email).matches()) {
            errors.add("Invalid e-mail formatting");
        }
        // should this be in the regex? (length validation)
        else if (!isValidLength(email,EMAIL_MIN_LENGTH,EMAIL_MAX_LENGTH)) {
            errors.add("E-mail must be between 6 & 255 characters.");
        }
    }

    public static void validateBirthYear(String birthYear, List errors, ServletContext ctx) {
        final int[] validBirthyearRange = (int[]) ctx.getAttribute("birthyearRange");

        if (birthYear != null && !birthYear.trim().isEmpty() && !birthYear.equals("0")) {
            try {
                boolean foundYear = false;
                final int year = Integer.parseInt(birthYear);
                for (int i : validBirthyearRange) {
                    if (i == year) {
                        foundYear = true;
                        break;
                    }
                }
                if (!foundYear) {
                    errors.add("Invalid birth year.");
                }
            } catch (Exception ex) {
                errors.add("Invalid birth year formatting.");
            }
        }
    }

    public static void validateSex(String sex, List errors) {
        if (sex != null && sex.length() != 0 && !sex.equalsIgnoreCase("male") && !sex.equalsIgnoreCase("female")) {
            errors.add("Your gender is invalid.");
        }
    }

    public static void validateLocation(String loc, List errors, ServletContext ctx) {
        final List<String> validLocations = (ArrayList<String>) ctx.getAttribute("locations");

        if (loc != null && loc.length() != 0 && !validLocations.contains(loc)) {
            errors.add("Invalid location.");
        }
    }

    public static List<String> getLinkValidationErrors(final String strHeadline, final String strSubhead, final String strUrl) {

        final List<String> listErrors = new ArrayList<String>();

        if (strHeadline.trim().length() < 1) {
            listErrors.add("Headline is required");
        }
        else if (!isValidLength(strHeadline,HEADLINE_MIN_LENGTH,HEADLINE_MAX_LENGTH)) {

            listErrors.add("Headline must be between " +
                                    HEADLINE_MIN_LENGTH + " & " + HEADLINE_MAX_LENGTH + " characters." );
        }

        if ((!strSubhead.trim().isEmpty()) && (!(isValidLength(strSubhead,SUBHEAD_MIN_LENGTH,SUBHEAD_MAX_LENGTH)))) {
            listErrors.add("Subhead must be between " + SUBHEAD_MIN_LENGTH + " & " + SUBHEAD_MAX_LENGTH + " characters.");
        }

        validateURL(strUrl,listErrors);

        return listErrors;
    }

    public static void validateDescription(final String desc, final List errors) {
        if (desc != null && !desc.trim().isEmpty() && desc.trim().length() > MAX_DESC_LENGTH) {
            errors.add("Description length must be less than " + MAX_DESC_LENGTH + " characters");
        }
    }

    public static void validateUserWebsite(final String url, final List errors) {
        if (url != null && !url.trim().isEmpty()) {

            if (url.trim().length() > URL_MAX_LENGTH) {
                errors.add("Website URL must be less than" + URL_MAX_LENGTH + " characters.");
            } else {
                String myUrl = ensureProtocolExists(url);

                try {
                    //validate url by trying to connect to it
                    //todo: possibly regex this instead?
                    new URL(myUrl).openConnection().connect();
                } catch (Exception ex) {
                    errors.add("Invalid website URL");
                    System.out.println("Invalid Website url for " + url + "\n" + ex.getMessage());
                }
            }
        }
    }

    public static void validateURL(final String url, final List errors) {
        if (url.trim().length() < 1) {
            errors.add("Url is required");
        }
        else if (!(isValidLength(url,URL_MIN_LENGTH,URL_MAX_LENGTH))) {
            errors.add("Url must be between " + URL_MIN_LENGTH + " & " + URL_MAX_LENGTH + " characters.");
        }
        else {
            String myUrl = ensureProtocolExists(url);

            try {
                //validate url by trying to connect to it
                //todo: possibly regex this instead?
                new URL(myUrl).openConnection().connect();
            }
            catch (Exception ex) {
                errors.add("Invalid website URL");
                System.out.println("Invalid Website url for " + url + "\n" + ex.getMessage());
            }
        }
    }

    //assumes if none of the supported protocols were entered, the user implied http://
    public static String ensureProtocolExists(final String s) {
        if (!((s.contains("http://") ||
               s.contains("https://") ||
               s.contains("ftp://")))) {
            return "http://".concat(s);
        }
        //already exists
        else {
            return s;
        }
    }

    public static boolean isValidLength(final String str, final int minLength, final int maxLength) {
        final int inputLength = str.trim().length();
        return (inputLength >= minLength && inputLength <= maxLength);
    }

    //ACTION VALIDATION (upvotes & downvotes)
    // Checks for user logged in, vote param eq up or down and proper formating for item id.
    public static List getActionValidationErrors(final HttpServletRequest req, final ServletContext ctx) {
        final List<String> listErrors = new ArrayList<String>();

        if (req.getSession().getAttribute("user") == null) {
            listErrors.add("You must be logged in to perform this action.");
        }

        final Map<String,String[]> requestParams = req.getParameterMap();
        if (!requestParams.get("vote")[0].equalsIgnoreCase("up") &&
            !requestParams.get("vote")[0].equalsIgnoreCase("down")) {
            listErrors.add("Invalid vote type: " + requestParams.get("vote")[0]);
        }
        try {
            Long.parseLong(requestParams.get("id")[0]);
        }
        catch (NumberFormatException ex) {
            listErrors.add("Invalid submission id: " + requestParams.get("id")[0]);
        }
        return listErrors;
    }
}