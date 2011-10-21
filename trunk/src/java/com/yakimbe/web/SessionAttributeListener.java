/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package com.yakimbe.web;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpSessionAttributeListener;
import javax.servlet.http.HttpSessionBindingEvent;

/**
 * Web application lifecycle listener.
 * @author John
 */

public class SessionAttributeListener implements HttpSessionAttributeListener {

    @Override
    public void attributeAdded(HttpSessionBindingEvent hsbe) {
        ServletContext ctx = hsbe.getSession().getServletContext();
        ctx.log("attribute added " + hsbe.getName());
        
        if (hsbe.getValue() instanceof com.yakimbe.model.User) {
            ctx.log("User attribute added " + hsbe.getValue().toString());
        }
    }

    @Override
    public void attributeRemoved(HttpSessionBindingEvent hsbe) {
       // throw new UnsupportedOperationException("Not supported yet.");
    }

    @Override
    public void attributeReplaced(HttpSessionBindingEvent hsbe) {
       // throw new UnsupportedOperationException("Not supported yet.");
    }
}
