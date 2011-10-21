<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="y" uri="YakimbeTags" %>
<%@taglib prefix="yak" tagdir="/WEB-INF/tags" %>

<yak:header title="Create User | Yakimbe" />

<div id="main-content">
    <div class="title">
    <h2>Welcome to Yakimbe!</h2>
    </div>
    <div id="copy">
        <p>Thanks for joining us! 
           As a member of Yakimbe, we depend on you to help create a smart, thought-provoking environment. To encourage civility and authenticity in our community, we ask that you provide a few more details about yourself.</p>
        <p>This optional information will give your account an authenticated status, letting other know you stand behind your submissions. Your information can be hidden from your profile, if you wish, and is governed by our  <a href="<c:url value='/privacy/' />">Privacy Policy</a>.</p>
        <p>To learn more about how you can help improve the Yakimbe community, please read the <a href="<c:url value='/guidelines/' />">Community Guidelines</a>.</p>
        <p>We're glad you joined us. Happy reading!</p>
        <p>
            <a href="<c:url value='/' />">no thanks, I'll skip for now</a>
        </p>
    </div>
        
    <form action="/accountedit" method="post" id="signup">
        <fieldset>
            <legend>Authenticate your account</legend>
		<label for="firstName">first name</label>
		<input type="text" id="firstName" name="firstname" class="required textfield" tabindex="1"autofocus/>
		<label for="lastName">last name</label>
		<input type="text" id="lastName" name="lastname" class="required textfield"tabindex="2" />
                <label for="location">I hail from</label>
                <%-- all towns with high schools in Ingham, Eaton, Clinton, Shiaasse and Ionia Gratiot counties --%>
                <select name="location" id="location" class="required" tabindex="3">
                    <option value="">- home sweet home -</option>
                    <c:forEach items="${applicationScope['locations']}" var="loc">
                        <option value="${loc}">${loc}</option>
                    </c:forEach>
                </select>
                <div>
                <label for="sex">I am a</label>
                <select name="sex" id="sex" class="required" tabindex="4">
                        <option value="">- sex -</option>
                        <option value="male">man</option>
                        <option value="female">woman</option>
                </select>
                </div>
                <div>
                <label for="birthdayYear">I was born in</label>
                <select name="birthday-year" id="year" class="required" tabindex="5">
                        <option value=""> - year - </option>
                        <c:forEach items="${applicationScope['birthyearRange']}" var="year">
                            <option value="${year}">${year}</option>
                        </c:forEach>
                </select>
                </div>
                <label for="description">about me</label>
                <textarea name="description" rows="5" cols="40" tabindex="6">${sessionScope.user.description}</textarea>
                <label for="website">website</label>
                <input type="url" name="website" class="url textfield" tabindex="7" value="${sessionScope.user.website}" />
                <c:if test="${sessionScope.user.website}">
                    <a href="#" onclick="alert('TODO: add another website field now');">add</a>
                </c:if>
                     <input type="submit" value="continue" class="submit" tabindex="8" />
        </fieldset>
</form>


</div>

<!--page-specific js here-->
<script>
$(function(){
        $('[autofocus=""]').autofocus();
});
</script>

<%@include file="/WEB-INF/jspf/footer.jspf" %>