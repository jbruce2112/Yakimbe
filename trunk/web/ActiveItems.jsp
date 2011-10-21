<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="yak" tagdir="/WEB-INF/tags" %>

<yak:header title="Home | Yakimbe" rssXMLPath="${initParam['activeRSSPath']}" />

        <div id="main-content">

        <%@include file="/WEB-INF/jspf/messagecenter.jspf" %>

        <c:if test="${not empty requestScope['currentItems']}">
            <ol>
                <c:forEach items="${requestScope['currentItems']}" var="item" varStatus="i">
                    <yak:submission item="${item}" />
                </c:forEach>
            </ol>
            <c:choose>
                <c:when test="${empty sessionScope.user}">
                    <%-- default --%>
                    <c:set var="activeItemsPrevPos" scope="page" value="${param.pos - 20}" />
                    <c:set var="activeItemsNextPos" scope="page" value="${param.pos + 20}" />
                </c:when>
                <c:otherwise>
                    <%-- user preference --%>
                    <c:set var="activeItemsPrevPos" scope="page" value="${param.pos - sessionScope.user.numItemsPage}" />
                    <c:set var="activeItemsNextPos" scope="page" value="${param.pos + sessionScope.user.numItemsPage}" />
                </c:otherwise>
            </c:choose>
            <c:if test="${requestScope.currentItemsLength >= 20 and not requestScope.isEndOfActiveItems}">
                    <a id="next" class="button" href="<c:url value='/active?pos=${pageScope.activeItemsNextPos}'/>">Next</a>
            </c:if>

            <c:if test="${param.pos >= 20}">
                <a id="prev" class="button" href="<c:url value='/active?pos=${pageScope.activeItemsPrevPos}'/>">Prev</a>
            </c:if>


        </c:if>
    </div>

<yak:sidebar showNotifications="true" />



    <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.4.2/jquery.min.js" type="text/javascript"></script>
    <script src="/js/yakimbe.js" type="text/javascript"></script>

    <script type="text/javascript">
        $(function() {
            $('.toggleCommentNotifications').toggle(function() {
               $(this).parent().next().fadeIn("fast");
               return false;
            }, function() {
                $(this).parent().next().fadeOut("fast");
                return false;
            });
            $('h3 a').tooltip({
                track:true,
                delay: 150,
                showURL: false
                });
            $("a.downvote, a.upvote").tooltip({
                track:true,
                delay: 500,
                showURL: false
                });
        });

    </script>


<%@include file="/WEB-INF/jspf/footer.jspf" %>