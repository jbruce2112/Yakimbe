<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="yak" tagdir="/WEB-INF/tags/" %>

<yak:header title="${sessionScope.user.userName}'s Profile | Yakimbe" />

<div id="main-content">
    <c:if test="${empty sessionScope.user}">
      <% response.sendRedirect(response.encodeRedirectURL("/")); %>
    </c:if>

<%@include file="WEB-INF/jspf/messagecenter.jspf" %>

     <h3>Password Change</h3>
     <form id="changepassword" action="/dochangepassword" method="post">
        <label for="oldpassword">current password</label>
        <input type="password" id="oldpassword" name="oldpassword" class="textfield" tabindex="1" autofocus />


        <label for="newpassword1">new password</label>
        <input type="password" id="newpassword1" name="newpassword1" class="textfield" tabindex="2" />

        <label for="newpassword2">retype new password</label>
        <input type="password" id="newpassword2" name="newpassword2" class="textfield" tabindex="3" />

        <input type="submit" class="submit" value="change password" />
     </form>
</div>

<script>
    $(document).ready(function(){
    $("#changepassword").validate({
          rules: {
            oldpassword:{
                        required:true
            },
            newpassword1: {
                        required:true,
                        minlength:8,
                        maxlength:25
                },
            newpassword2: {
                equalTo: "#newpassword1"
            }
          }
    });
});

$(function(){
        $('[autofocus=""]').autofocus();
});
</script>

<%@include file="/WEB-INF/jspf/footer.jspf" %>
