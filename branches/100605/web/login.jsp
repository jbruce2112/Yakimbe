<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%@taglib prefix="yak" tagdir="/WEB-INF/tags/" %>
<%@page import="net.tanesha.recaptcha.ReCaptcha, net.tanesha.recaptcha.ReCaptchaFactory" %>


<yak:header title="Login | Yakimbe" />
<script type="text/javascript">

var RecaptchaOptions = {
   theme : 'white'
};
</script>

<div id="login">
    <c:if test="${not empty sessionScope.loginMsg}">
        <p>${sessionScope.loginMsg}</p>
        <% request.getSession().removeAttribute("loginMsg"); %>
    </c:if>

    <c:choose>
        <c:when test="${not empty sessionScope.user}">
            <p>
                Welcome back, ${sessionScope.user.friendlyDisplayName}!
                <a href="<c:url value='/' />">Home</a>
            </p>
        </c:when>
        <c:otherwise>
            <div id="message">

                 <c:choose>

                    <c:when test="${requestScope.userStatus == 'newAccountCreated'}">
                        <p>Account successfully created!<br>
                            An e-mail will be sent to the address you specifed shortly with a confirmation link.
                            Once you confirm your e-mail, you may log in below.</p>
                        <p>Didn't get that e-mail? <a href="/verification?user=${requestScope.userName}">request one again</a></p>
                    </c:when>

                     <c:when test="${requestScope.userStatus == 'accountUnverified'}">
                        <p>Please verify your account using the link sent to the e-mail you signed up with.</p>
                        <p>Didn't get that e-mail? <a href="/verification?user=${requestScope.userName}">Request one again</a></p>
                    </c:when>

                    <c:when test="${requestScope.userStatus == 'verificationMailResent'}">
                        <p>E-mail resent.</p>
                        <p>Still having issues? <a href="/verification?user=${param.user}">Request one again</a>
                            or <a href="mailto:${initParam.adminEmail}">let us know</a> you're having a problem.</p>
                    </c:when>

                    <c:when test="${requestScope.userStatus == 'verificationSuccess'}">
                        <p>Thanks for confirming your account. Please log in below.</p>
                    </c:when>

                    <c:when test="${not empty requestScope.loginErrors}">
                        <c:forEach items="${loginErrors}" var="error" >
                            <ol class="error">
                                <li>${error}</li>
                            </ol>
                        </c:forEach>
                    </c:when>

                 </c:choose>

            </div>
            <div id="existingacct">
            <h1>Login now</h1>

            <form action="/Login" method="post">
                <label for="username">username</label>
                <input type="text" name="loginUserName" class="textfield" tabindex="1" autofocus/>
                <label for="password">password</label>
                <input type="password" name="loginPassword" class="textfield" tabindex="2" />
                <input type="submit" value="Login" class="submit" tabindex="3" />
                <%--TODO: This is a stupid way to do this. brainstorm other ideas --%>
                <c:if test="${requestScope.userStatus == 'verificationSuccess'}">
                    <input type="hidden" name="showVerificationPage" value="true" />
                </c:if>
            </form>
            </div>

            <div id="newacct">
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

                    <h1>Get an account</h1>
                    <p>Sign up now! It's fast, free and gives you the full benefit of the community.</p>
                    <form action="/CreateUser" method="post" id="signup">
                        <label for="newusername">username</label>
                        <input type="text" id="newUserName" name="newUserName" class="required textfield" tabindex="4" />
                        <label for="password1">password</label>
                        <input type="password" id="password1" name="password1" class="required password textfield" tabindex="5" />
                        <label for="retype">retype password</label>
                        <input type="password" id="password2" name="password2" class="required password textfield" tabindex="6" />
                        <label for="email">e-mail</label>
                        <input id="email" name="email" type="email" class="required email textfield" tabindex="7" />
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
                        <p class="checkbox"><input id="email-optin" type="checkbox" name="email-optin" checked="checked" tabindex="9">
                            please send me updates about Yakimbe!</input></p>
                        <input type="submit" value="Join Now" class="submit" tabindex="10" />
                    </form>
            </div>
        </c:otherwise>
    </c:choose>
</div>
<script>
    $(document).ready(function(){
        $("#signup").validate({
              rules: {
                password: { required:true
                           },
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
</script>

<%@include file="/WEB-INF/jspf/footer.jspf" %>