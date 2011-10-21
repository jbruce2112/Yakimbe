package com.yakimbe.filter;

import com.yakimbe.model.User;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.ServletException;
import java.io.IOException;

/**
 *
 * @author John
 */
public class LocalAdminFilter implements Filter {

    private FilterConfig filterConfig;

    @Override
    public void init(FilterConfig fc) {
        this.filterConfig = fc;
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain filterChain)
                                                        throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) request;
        User user = (User) req.getSession().getAttribute("user");

        if (req.getServerName().equalsIgnoreCase("localhost") && user == null) {
            filterConfig.getServletContext().log("HELLO");
            user = new User();
            
            user.setUserName("localadmin");
            user.setFirstName("localadmin");
            user.setAdmin(true);
            req.getSession().setAttribute("user", user);
        }
        
        filterChain.doFilter(request, response);
    }

    @Override
    public void destroy() {
        this.filterConfig = null;
    }

}
