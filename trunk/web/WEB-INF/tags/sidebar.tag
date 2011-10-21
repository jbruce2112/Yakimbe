<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="y" uri="YakimbeTags" %>

<%@tag description="Sidebar to display information relevant to current page" pageEncoding="UTF-8" %>
<%@attribute name="showNew" required="false" rtexprvalue="true" %>
<%@attribute name="showRecent" required="false" rtexprvalue="true" %>
<%@attribute name="showNotifications" required="false" rtexprvalue="true" %>
<%@attribute name="showSharing" required="false" rtexprvalue="true" %>
<%@attribute name="showForm" required="false" rtexprvalue="true" %>

<%-- defaults --%>
<c:if test="${empty showNew}">
    <c:set var="showNew" value="true" />
</c:if>
<c:if test="${empty showRecent}">
    <c:set var="showRecent" value="true" />
</c:if>
<c:if test="${empty showNotifications}">
    <c:set var="showNotifications" value="false" />
</c:if>
<c:if test="${empty showSharing}">
    <c:set var="showSharing" value="true" />
</c:if>
<c:if test="${empty showForm}">
    <c:set var="showForm" value="true" />
</c:if>

<div id="sidebar">
    <%--begin login/info center--%>

    <c:choose>
        <c:when test="${empty sessionScope.user}">
            <a id="signup" class="button" href="<c:url value='/userlogin' />">Login or sign up</a>
        </c:when>
    </c:choose>

    <%--begin add submission form --%>
        <c:if test="${showForm}">
        <form id="submit-item" action="/CreateSubmission/" method="post" accept-charset="utf-8">
            <h2>Post an item</h2>
            <label for="headline">Headline</label>
            <p class="note-right remaining">70 characters remaining</p>
            <input type="text" id="headline" name="headline" spellcheck="true" class="countdown limit_70_ textfield" />
            <span><label for="subhead">Subhead</label>
            <p class="note-right remaining">90 characters remaining</p>
            <input type="text" id="subhead" spellcheck="true" name="subhead" class="countdown limit_90_ textfield"/></span>
            <label for="url">URL</label>
            <input type="url" id="url" name="url" class="url textfield" />
            <input type="hidden" name="type" value="link" />
            <input type="submit" value="Submit" class="submit" />
        </form>
        </c:if>
    <%--end add submission form --%>

    <%-- begin notfications --%>
    <c:if test="${showNotifications and sessionScope.user.admin}">
        <c:if test="${commentNotif.numReplies gt 0}">
                <h4>Replies to my comments</h4>

                <c:set var="currentHeadlineGroup" value="" scope="page" />

               <ul class="commentNotificationGroup">
                    <c:forEach items="${sessionScope.user.notifications.comment}" var="commentNotif" varStatus="i">

                        <li>
                            <a href="/submission/${commentNotif.itemCommentingOnId}?delNotif=comment#${commentNotif.itemId}">
                                ${commentNotif.time}
                            </a> - ${commentNotif.numReplies} ${commentNotif.numReplies eq 1 ? " reply" : " replies"}
                        </li>
                    </c:forEach>
                </ul>
            <hr />
        </c:if>

       <c:if test="${itemNotif.numReplies gt 0}">
            <h4>Replies to my submissions</h4>
            <ul class="itemNotificationGroup">
                <c:forEach items="${sessionScope.user.notifications.item}" var="itemNotif">
                    <li>
                        <a href="<c:url value='/submission/${itemNotif.itemId}?delNotif=item' />">
                            ${y:HeadlineFormatting(itemNotif.itemHeadline)}
                        </a> - ${itemNotif.numReplies} ${itemNotif.numReplies eq 1 ? " reply" : " replies"}
                    </li>
                </c:forEach>
            </ul>
            <hr />
       </c:if>
    </c:if>
    <%--end notifications--%>

    <c:if test="${showNew}">
               <c:if test="${sessionScope.user.admin}">
                   <form action="/active" class="ninety" method="get" width="=120px">
                       <fieldset>
                       <legend>Sort algorithim</legend>
                       <p>1 <input id="q1" type="radio" class="radio" <c:if test="${sessionScope.queryToRun eq 1}">checked</c:if> name="queryToRun" value="1" />
                       &nbsp;&nbsp;2 <input id="q2" type="radio" <c:if test="${sessionScope.queryToRun eq 2}">checked</c:if> name="queryToRun" value="2" />
                       &nbsp;&nbsp;3 <input id="q3" type="radio" <c:if test="${sessionScope.queryToRun eq 3}">checked</c:if> name="queryToRun" value="3" />
                       &nbsp;&nbsp;4 <input id="q4" type="radio" <c:if test="${sessionScope.queryToRun eq 4}">checked</c:if> name="queryToRun" value="4" /></p>
                       <input type="submit" class="submit" value="change" />
                       </fieldset>
                   </form>
               </c:if>
        <h4>New Submissions</h4>
        <ul>
            <c:forEach items="${newItems}" var="item" varStatus="i" >
                <li><a href="<c:url value='/submission/${item.itemId}' />">${y:HeadlineFormatting(item.headline)}</a></li>
            </c:forEach>
        </ul>
        <hr />
    </c:if>

    <c:if test="${showSharing}">
        <div id="promo-links">
            <ul class="promo-links">
                <li><a href="/active.xml" class="promo-rss">Subscribe</a></li>
                <li><a href="http://www.twitter.com/yakimbe" class="promo-twitter">Follow us</a></li>
                <li><a href="http://www.facebook.com/home.php?#!/pages/Yakimbe/10150141058305521?ref=ts" class="promo-fb">Become a Fan</a></li>
            </ul>
        </div>
    </c:if>

    <%--
    <c:if test="${showNew and showRecent and not empty sessionScope.recentlyViewed}">
        <hr />
    </c:if>

    <c:if test="${showRecent and not empty sessionScope.recentlyViewed}">
        <h4>recently viewed</h4>
        <ul>
            <c:forEach items="${sessionScope.recentlyViewed}" var="item" varStatus="i" >
                <li><a href="${item.url}">${item.headline}</a></li>
            </c:forEach>
        </ul>
    </c:if>
    --%>
</div>

<script type="text/javascript">
 $(document).ready(function(){
   $("#submit-item").validate({
		  rules: {
		    headline: {
				required:true,
				minlength:10,
				maxlength:70
			},
			subhead: {
				required:false,
				minlength:10,
				maxlength:90
			},
			url: {
				required:true
			}
		}
	});
 });

 var countdown = {
     init: function() {
         countdown.remaining = countdown.max - $(countdown.obj).val().length;
         if (countdown.remaining > countdown.max) {
             $(countdown.obj).val($(countdown.obj).val().substring(0,countdown.max));
         }
         $(countdown.obj).siblings(".remaining").html(countdown.remaining + " characters remaining");
     },
     max: null,
     remaining: null,
     obj: null
 };
 $(".countdown").each(function() {
     $(this).focus(function() {
         var c = $(this).attr("class");
         countdown.max = parseInt(c.match(/limit_[0-9]{1,}_/)[0].match(/[0-9]{1,}/)[0]);
         countdown.obj = this;
         iCount = setInterval(countdown.init,1000);
     }).blur(function() {
         countdown.init();
         clearInterval(iCount);
     });
 });
 </script>