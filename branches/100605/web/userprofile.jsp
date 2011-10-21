<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="y" uri="YakimbeTags" %>
<%@taglib prefix="yak" tagdir="/WEB-INF/tags/" %>

<yak:header title="${requestScope.returnedUser.userName}'s profile | Yakimbe" />

<div id="main-content">
    <div class="title">
    <h2>${requestScope.returnedUser.userName}</h2>
        <p><%--Yakimbe karma: ${requestScope.returnedUser.rating}--%>
            <c:if test="${requestScope.isLoggedInUser}">
                <br /><a href="/account/">edit</a>
            </c:if>
        </p>
    </div>
    <div id="copy">
                    <ul>
                        <li><strong>time on yakimbe:</strong> ${requestScope.returnedUser.friendlyTimeOnSite}</li>
                        <li><strong>location:</strong> <c:out value="${requestScope.returnedUser.location}" /></li>
                        <li><strong>about me:</strong> <c:out value="${requestScope.returnedUser.description}" /></li>
                        <li><strong>my website:</strong> 
                            <c:if test="${not empty requestScope.returnedUser.website}">
                                <a href="<c:out value='${y:EnsureProtocolExists(requestScope.returnedUser.website)}' />"><c:out value="${requestScope.returnedUser.website}" /></a>
                            </c:if>
                        </li>
                        <ul>
                            <c:if test="${not empty requestScope.returnedUser.facebook}">
                                <li>
                                    <a href="${requestScope.returnedUser.facebook}">facebook</a>
                                </li>
                            </c:if>
                            <c:if test="${not empty requestScope.returnedUser.linkedin}">
                                <li>
                                    <a href="${requestScope.returnedUser.linkedin}">linkedin</a>
                                </li>
                            </c:if><c:if test="${not empty requestScope.returnedUser.flickr}">
                                <li>
                                    <a href="${requestScope.returnedUser.flickr}">flickr</a>
                                </li>
                            </c:if><c:if test="${not empty requestScope.returnedUser.myspace}">
                                <li>
                                    <a href="${requestScope.returnedUser.myspace}">myspace</a>
                                </li>
                            </c:if>
                        </ul
                    </ul>
    </div>
</div>

<%@include file="/WEB-INF/jspf/footer.jspf" %>
