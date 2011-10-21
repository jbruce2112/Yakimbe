package com.yakimbe.filter;

import java.io.IOException;
import javax.servlet.Filter;
import javax.servlet.FilterConfig;
import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletResponse;
import java.util.Enumeration;


public class SetResponseHeaderFilter implements Filter {

   private FilterConfig filterConfig = null;

   public void init(FilterConfig filterConfig) throws ServletException {
      this.filterConfig = filterConfig;
   }

   public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
                                                        throws IOException, ServletException {

       HttpServletResponse res = (HttpServletResponse) response;
       
       for (Enumeration e=filterConfig.getInitParameterNames(); e.hasMoreElements();) {
             String headerName = (String) e.nextElement();
             res.addHeader(headerName, filterConfig.getInitParameter(headerName));
       }
       
       chain.doFilter(request, response);
   }

   public void destroy() {
      this.filterConfig = null;
   }
}