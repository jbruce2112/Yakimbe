<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@taglib prefix="y" uri="YakimbeTags" %>

<%@tag description="Creates a submitted item in the rss feed" pageEncoding="UTF-8" import="com.yakimbe.model.Submission" %>
<%@attribute name="item" required="true" rtexprvalue="true" type="com.yakimbe.model.Submission" %>

 <c:choose>
    <c:when test="${fn:toLowerCase(item.type) == 'link'}">

        <item>
            <title><c:out value='${item.headline}'/></title>
            <link><c:out value='${item.url}' /></link>
            <guid isPermaLink="true">http://www.yakimbe.com/submission/${item.itemId}</guid>
            <description>
                <![CDATA[ <c:out value='${item.subhead}'/> ${not empty item.subhead ? " <br />" : ""} ${item.rating} ${item.rating eq 1 ? " point, ": " points, "}
                <a href="http://www.yakimbe.com/submission/${item.itemId}">${item.numComments} ${item.numComments eq 1 ? " comment" : " comments"}</a>. ]]>
            </description>
            <comments>http://www.yakimbe.com/submission/${item.itemId}</comments>
        </item>

    </c:when>
</c:choose>
