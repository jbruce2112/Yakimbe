<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@taglib prefix="y" uri="YakimbeTags" %>
<%@taglib prefix="yak" tagdir="/WEB-INF/tags" %>

<yak:header title="Edit Comment | Yakimbe" />

<%-- TODO, this redirect doesn't work. needs to be in a c:choose? --%>
<c:if test="${empty sessionScope.user}" >
        <%-- Since the user will be kicked to the sign-in, store their request URL
        so we can send them back to where they wanted to go once they log in --%>
        <c:set var="originallyRequestedURL" value="${pageContext.request.requestURI}" scope="session" />
        <c:set scope="session" var="loginMsg" value="To submit a news item, please log in first." />
        <% response.sendRedirect(response.encodeRedirectURL("/userlogin/")); %>
</c:if>

<div id="main-content">
    
<%@include file="WEB-INF/jspf/messagecenter.jspf" %>

     <%-- get comment --%>
     <c:forEach items="${y:CommentsSetToList(sessionScope.comments)}" var="item">
         <c:if test="${item.commentId eq param.cid}">
             <c:set var="comment" value="${item}" />
         </c:if>
     </c:forEach>
     
    <form id="edit-item" action="/doeditcomment" method="post" accept-charset="utf-8">
        <h2>Edit your comment</h2>
        <label for="comment">comment</label>
        <p class="note-right remaining">2000 characters remaining</p>
        <textarea id="comment" name="comment" class="countdown limit_2000_ textarea" autofocus><c:out value='${pageScope.comment.body}' /></textarea>

        <span>
            <label for="editnote">what changes did you make?</label>
            <p class="note-right remaining">140 characters remaining</p>
            <textarea id="editnote" name="editnote" spellcheck="true" class="countdown limit_140_ textarea"><c:out value='${requestScope.editNotes}' /></textarea>
        </span>
        <input type="hidden" value="${param.cid}" name="commentid" />
        <input type="submit" value="Submit" class="submit" />
    </form>
</div>

<script type="text/javascript">
 $(document).ready(function(){
   $("#edit-item").validate({
		  rules: {
                    comment: {
				required:true,
                                minlength:1,
                                maxlength:2000
			},
                    editnote: {
                                required:false,
                                maxlength:140
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

 $(function(){
   $('[autofocus=""]').autofocus();
 });

 </script>

<%@include file="/WEB-INF/jspf/footer.jspf" %>
