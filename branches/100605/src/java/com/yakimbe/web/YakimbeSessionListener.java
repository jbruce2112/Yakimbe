
package com.yakimbe.web;

import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;
import com.yakimbe.model.Submission;
import com.yakimbe.model.User;
import java.util.List;
import java.util.ArrayList;
import java.util.LinkedList;

public class YakimbeSessionListener implements HttpSessionListener {

    @Override
    public void sessionCreated(HttpSessionEvent e) {
        List<Submission> recentlyViewed = new LinkedList<Submission>();
        e.getSession().setAttribute("recentlyViewed", recentlyViewed);
    }

    @Override
    public void sessionDestroyed(HttpSessionEvent e) {
        final HttpSession session = e.getSession();
        final List<User> currentUsers = (ArrayList) session.getServletContext().getAttribute("currentUsers");
        currentUsers.remove((User) session.getAttribute("user"));
    }
}