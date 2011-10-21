<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="yak" tagdir="/WEB-INF/tags/" %>

<c:if test="${empty sessionScope.user}" >
        <%-- Since the user will be kicked to the sign-in, store their request URL
        so we can send them back to where they wanted to go once they log in --%>
        <c:set var="originallyRequestedURL" value="${pageContext.request.requestURI}" scope="session" />
        <c:set scope="session" var="loginMsg" value="To submit a news item, please log in first." />
        <% response.sendRedirect(response.encodeRedirectURL("/userlogin/")); %>
</c:if>

<yak:header title="Submit News | Yakimbe" />

<div id="main-content">

    <%@include file="/WEB-INF/jspf/messagecenter.jspf" %>

    <form id="submit-item" action="/CreateSubmission/" method="post" accept-charset="utf-8">
        <h2>Post an item</h2>
        <label for="headline">headline</label>
        <p class="note-right remaining">70 characters remaining</p>
        <input type="text" id="headline" name="headline" spellcheck="true" class="countdown limit_70_ textfield" autofocus/>
        <span><label for="subhead">subhead</label>
        <p class="note-left">(optional)</p>
        <p class="note-right remaining">90 characters remaining</p>
        <input type="text" id="subhead" spellcheck="true" name="subhead" class="countdown limit_90_ textfield"/></span>
        <label for="url">url</label>
        <input type="url" id="url" name="url" class="url textfield" />
        <input type="hidden" name="type" value="link" />
        <input type="submit" value="Submit" class="submit" />
    </form>
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

 $(function(){
   $('[autofocus=""]').autofocus();
 });

 </script>

<%@include file="/WEB-INF/jspf/footer.jspf" %>