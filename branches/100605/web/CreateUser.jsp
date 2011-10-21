<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%@taglib prefix="yak" tagdir="/WEB-INF/tags/" %>
<%@page import="net.tanesha.recaptcha.ReCaptcha, net.tanesha.recaptcha.ReCaptchaFactory" %>

<yak:header title="New Account | Yakimbe" />

<script type="text/javascript">
var RecaptchaOptions = {
   theme : 'white'
};
</script>
<div id="main-content">
        
    <c:if test="${requestScope.userCreated or not empty requestScope.createUserErrors}">
        <div id="message">
            <c:choose>
                <c:when test="${not empty requestScope.createUserErrors}">
                    <ol class="error">
                        <c:forEach items="${requestScope.createUserErrors}" var="error">
                            <li>${error}</li>
                        </c:forEach>
                    </ol>
                </c:when>
                <c:when test="${requestScope['createUserResult'] == 'success'}">
                    <%--this should actually redirect to the login page, with this message.--%>
                        <p>Account successfully created! <a href="/userlogin">login</a></p>
                </c:when>
            </c:choose>
        </div>
    </c:if>
            <div class="title">
                <h2>Join the community</h2>
                <p>Already a member?<br /> <a href="<c:url value='/userlogin/' />">Sign in here.</a></p>
            </div>

            <form action="/CreateUser" method="post" id="signup">
                <label for="username">username</label>
                <input type="text" id="userName" name="userName" class="required textfield" tabindex="3" autofocus/>
                <label for="password1">password</label>
                <input type="password" id="password1" name="password1" class="required password textfield" tabindex="4" />
                <label for="retype">retype password</label>
                <input type="password" id="password2" name="password2" class="required password textfield" tabindex="5" />
                <label for="email">e-mail</label>
                <input id="email" name="email" type="email" class="required email textfield" tabindex="6" />
                <%
                     ReCaptcha c = ReCaptchaFactory.newReCaptcha("6LcQpQsAAAAAAMKlo1idpbUlfOKejvnJ4G0tSKcU ", "6LcQpQsAAAAAAL402t_CDlRx3FLqOjfPZNe5pV-N ", false);
                     out.print(c.createRecaptchaHtml(null, null));
                %>

                <%--<fieldset>
                    <legend>Beta Phase</legend>
                    <p>Yakimbe is currently in early beta. To sign up, you must have the beta code.</p>
                    <p>If you don't have a beta code, but would like to participate in the beta, <a href="mailto:webguy@yakimbe.com?subject=Beta Test Access">shoot us an e-mail</a> telling us why you're interested.</p>
                    <label for="email">beta code</label>
                    <input id="betacode" name="betacode" type="text" class="required textfield" tabindex="7" />
                </fieldset>---%>
                <p class="checkbox"><input id="email-optin" type="checkbox" name="email-optin" checked="checked" tabindex="10">
                    please send me updates about Yakimbe!</input></p>
                <input type="submit" value="Submit" class="submit" tabindex="11" />
            </form>


</div>

<!--page-specific js here-->
<script>
$(document).ready(function(){
    $("#signup").validate({
          rules: {
            password1: {
                        required:true,
                        minlength:8,
                        maxlength:25
                },
            password2: {
                equalTo: "#password1"
            },
                userName: {
                        minlength:2,
                        maxlength:25
                }
          }
    });
});
	
$(function(){
        $('[autofocus=""]').autofocus();
});


var RecaptchaOptions = {
   theme : 'white'
};
</script>

</script>

<%@include file="/WEB-INF/jspf/footer.jspf" %>