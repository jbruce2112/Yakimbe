<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="yak" tagdir="/WEB-INF/tags/" %>

<%@page contentType="application/rss+xml" pageEncoding="UTF-8"%>

<?xml version="1.0"?>
<rss version="2.0">
	<channel>

            <%
                if (request.getRequestURI().contains("new")) {
            %>
                    <title>Yakimbe | New Items</title>
                    <link>http://www.yakimbe.com/new</link>
                    <description>Local news for informed people, rated by readers</description>
                    <c:forEach items="${applicationScope.rssNewItems}" var="item">
                        <yak:submission_rss item="${item}"/>
                    </c:forEach>
            <%
                } else if (request.getRequestURI().contains("active")) {
            %>

                    <title>Yakimbe | Active Items</title>
                    <link>http://www.yakimbe.com/active</link>
                    <description>Local news for informed people, rated by readers</description>
                    <c:forEach items="${applicationScope.rssActiveItems}" var="item">
                        <yak:submission_rss item="${item}"/>
                    </c:forEach>
            <%
                }
            %>

        </channel>
</rss>