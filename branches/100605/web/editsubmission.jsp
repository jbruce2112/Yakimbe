<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@taglib prefix="y" uri="YakimbeTags" %>
<%@taglib prefix="yak" tagdir="/WEB-INF/tags" %>

<yak:header title="Edit Submission | Yakimbe" />

<c:if test="${empty sessionScope.user}" >
        <%-- Since the user will be kicked to the sign-in, store their request URL
        so we can send them back to where they wanted to go once they log in --%>
        <c:set var="originallyRequestedURL" value="${pageContext.request.requestURI}" scope="session" />
        <c:set scope="session" var="loginMsg" value="To submit a news item, please log in first." />
        <% response.sendRedirect(response.encodeRedirectURL("/userlogin/")); %>
</c:if>

<div id="main-content">
    
<%@include file="WEB-INF/jspf/messagecenter.jspf" %>
    
    <form id="edit-item" action="/doeditsubmission" method="post" accept-charset="utf-8">
        <h2>Edit your submission</h2>
        <label for="headline">headline</label>
        <p class="note-right remaining">70 characters remaining</p>
        <input type="text" id="headline" name="headline" spellcheck="true"class="countdown limit_70_ textfield" autofocus value="${y:HeadlineFormatting(sessionScope.item.headline)}" />
        <span><label for="subhead">subhead</label>
        <p class="note-left">(optional)</p>
        <p class="note-right remaining">90 characters remaining</p>
        <input type="text" id="subhead" spellcheck="true" name="subhead" class="countdown limit_90_ textfield" value="<c:out value='${sessionScope.item.subhead}' />" /></span>
        <label for="url">url</label>
        <input type="url" id="url" name="url" class="url textfield" value="<c:out value='${sessionScope.item.url}' />" />
        <input type="hidden" name="type" value="link" />
        <span>
            <label for="editnote">what changes did you make?</label>
            <p class="note-right remaining">140 characters remaining</p>
            <textarea id="editnote" name="editnote" spellcheck="true" class="countdown limit_140_ textarea" >
                <c:out value='${requestScope.comments}' />
            </textarea>
        </span>
        <input type="hidden" value="${sessionScope.itemId}" name="id" />
        <input type="submit" value="Submit" class="submit" />
    </form>
</div>

<script>
 $(document).ready(function(){
   $("#edit-item").validate({
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
                },
            editnote: {
                        required: false,
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
