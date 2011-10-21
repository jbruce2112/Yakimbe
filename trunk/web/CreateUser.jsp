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

    <c:choose>
        <%-- If they're creating a yakimbe account that's initially hooked into facebook,
             we only care about what they want their user name to be here --%>
        <c:when test="${not empty sessionScope['attemptFbID']}">
            <div id="message">
                Please select a user name. This will be used as your identity when submitting
                news or commenting on others' articles.
            </div>
            <form action="/CreateUser" method="post" id="signup">
                <label for="username">username</label>
                <input type="text" id="userName" name="userName" class="required textfield" tabindex="3" autofocus/>
                
                <p class="checkbox">
                    <input id="email-optin" type="checkbox" name="email-optin" checked="checked" tabindex="10">
                        please send me updates about Yakimbe!
                    </input>
                </p>
                <input type="submit" value="Submit" class="submit" tabindex="11" />
            </form>

        </c:when>
        <c:otherwise>

            <div class="title">
                <h2>Join the community</h2>
                <p>Already a member?<br /> <a href="<c:url value='/userlogin/' />">Sign in here.</a></p>
            </div>
            <div id="fb-root"></div>

            <fb:login-button onlogin="onLogin();">
                <fb:intl>Sign up using your Facebook account</fb:intl>
            </fb:login-button>

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
                <p class="checkbox">
                    <input id="email-optin" type="checkbox" name="email-optin" checked="checked" tabindex="10">
                        please send me updates about Yakimbe!
                    </input>
                </p>
                <input type="submit" value="Submit" class="submit" tabindex="11" />
            </form>

            <script src="http://connect.facebook.net/en_US/all.js"></script>
            <script>
              // initialize the library with the API key
              FB.init({
                appId  : '102923989756957',
                status : true, // check login status
                cookie : true, // enable cookies to allow the server to access the session
                xfbml  : true  // parse XFBML
              });

              function onLogin() {
                FB.getLoginStatus(function(res) {
                    if (res.session) {
                        console.log("user clicked yes");
                        document.location.href="/fblogin";
                    }
                    else {
                        console.log("user clicked no");
                    }
                });
              }
            </script>

        </c:otherwise>
    </c:choose>
            
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

<%@include file="/WEB-INF/jspf/footer.jspf" %>