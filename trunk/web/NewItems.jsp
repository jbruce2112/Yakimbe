<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="yak" tagdir="/WEB-INF/tags/" %>

<yak:header title="Newest Submissions | Yakimbe"  rssXMLPath="${initParam['newRSSPath']}" />

<div id="main-content">

    <%@include file="/WEB-INF/jspf/messagecenter.jspf" %>

<c:if test="${not empty requestScope['newItems']}">

    <ol>
        <c:forEach items="${requestScope['newItems']}" var="item" varStatus="i">
            <yak:submission item="${item}" />
        </c:forEach>
    </ol>
    <c:choose>
        <c:when test="${empty sessionScope.user}">
            <%-- default --%>
            <c:set var="newItemsPrevPos" scope="page" value="${param.pos - 20}" />
            <c:set var="newItemsNextPos" scope="page" value="${param.pos + 20}" />
        </c:when>
        <c:otherwise>
            <%-- user preference --%>
            <c:set var="newItemsPrevPos" scope="page" value="${param.pos - sessionScope.user.numItemsPage}" />
            <c:set var="newItemsNextPos" scope="page" value="${param.pos + sessionScope.user.numItemsPage}" />
        </c:otherwise>
    </c:choose>
    <c:choose>
        <c:when test="${requestScope.newItemsLength >= 20 }">
                <a id="next" class="button" href="<c:url value='/new?pos=${pageScope.newItemsNextPos}'/>">Next</a>
        </c:when>
        <c:otherwise>
                It looks like you've browsed all of the news! Perhaps it's time to <a href="/newsubmission/">submit</a> your own!
        </c:otherwise>
    </c:choose>
    <c:if test="${param.pos >= 20}">
        <a id="prev" class="button" href="<c:url value='/new?pos=${pageScope.newItemsPrevPos}'/>">Prev</a>
    </c:if>
</c:if>
</div>
<yak:sidebar showNotifications="true" showNew="false"/>



<script type="text/javascript">
    $(function() {
    $('h3 a').tooltip({
        track:true,
        delay: 175,
        showURL: false
        });
    $("a.downvote, a.upvote").tooltip({
        track:true,
        delay: 750,
        showURL: false
        });
    });

</script>
<%@include file="/WEB-INF/jspf/footer.jspf" %>
