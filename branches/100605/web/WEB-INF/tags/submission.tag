<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@taglib prefix="y" uri="YakimbeTags" %>

<%@tag description="Displays a news item on the page" pageEncoding="UTF-8" import="com.yakimbe.model.Submission" %>
<%@attribute name="item" required="true" rtexprvalue="true" type="com.yakimbe.model.Submission" %>

<c:choose>
    <c:when test="${fn:toLowerCase(item.type) == 'link'}">

        <c:url value='/Action' var="upvoteURL">
            <c:param name='vote' value='up'/>
            <c:param name='id' value='${item.itemId}' />
        </c:url>

        <c:url value='/Action' var="downvoteURL">
            <c:param name='vote' value='down'/>
            <c:param name='id' value='${item.itemId}'/>
        </c:url>

        <li id="${item.itemId}" class="submission">
    <%--<a href="/editsubmission?id=${item.itemId}">edit</a>--%>
            <a href="<c:out value='${upvoteURL}' />"
               <c:choose>
                   <c:when test="${sessionScope.user.userActions[y:ToString(item.itemId)] eq 'upvote'}">
                       style="background-position: -13px 0;"
                       title="undo upvote"
                   </c:when>
                   <c:otherwise>
                       title="upvote (click again to undo)"
                   </c:otherwise>
                </c:choose>class="upvote">upvote</a>

            <a href="<c:out value='${downvoteURL}' />"
               <c:choose>
                   <c:when test="${sessionScope.user.userActions[y:ToString(item.itemId)] eq 'downvote'}">
                       style="background-position: -13px -14px;"
                       title="undo downvote"
                   </c:when>
                   <c:otherwise>
                       title="downvote (click again to undo)"
                   </c:otherwise>
                </c:choose>
               class="downvote">downvote</a>
               
            <h3><a target="_blank" title="<c:out value='${item.subhead}' />" href="<c:out value='${item.url}' />">${y:HeadlineFormatting(item.headline)}</a></h3>
            <ul class="submission-info">
                 <li class="first">${item.rating}
                    <c:choose>
                        <c:when test="${item.rating == 1}">
                            point
                        </c:when>
                        <c:otherwise>
                            points
                        </c:otherwise>
                    </c:choose>
                </li>
                <li>
                    <a href="/submission/${item.itemId}">
                        ${item.numComments}
                        <c:choose>
                            <c:when test="${item.numComments == 1}">
                                comment
                            </c:when>
                            <c:otherwise>
                                comments
                            </c:otherwise>
                        </c:choose>
                    </a>
                </li>
                <li>submitted by <a href="/user/${item.userName}">${item.userName}</a> ${item.friendlyTime} </li>
                <li><a href="<c:out value='${y:GetDomain(item.url)}'/>">
                        <c:out value='${y:SimpleDomainDisplay(item.url)}'/>
                    </a>
                </li>
                <%-- popularity algorithm exposed! --%>
                <%--<c:if test="${sessionScope.user.admin}"><li><p>${item.popularity}</p></li></c:if>--%>
            </ul>
        </li>

    </c:when>
</c:choose>
