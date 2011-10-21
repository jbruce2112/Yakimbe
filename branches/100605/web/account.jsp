<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="yak" tagdir="/WEB-INF/tags/" %>

<yak:header title="My Account | Yakimbe" />

<div id="main-content">
    <c:if test="${empty sessionScope.user}">
      <% response.sendRedirect(response.encodeRedirectURL("/")); %>
    </c:if>

<%@include file="WEB-INF/jspf/messagecenter.jspf" %>
    
        <c:choose>
            <c:when test="${not empty sessionScope.user}">
                <div class="title">
                    <h2>${sessionScope.user.userName}</h2>
                     <%--<p>Yakimbe karma: ${sessionScope.user.rating}
                       <c:if test="${sessionScope.user.authenticated}">
                             <br />Authenticated member
                        </c:if>
                    </p>--%>
                </div>

                    <p>
                        <a href="<c:url value='/changepassword' />">change password</a>
                    </p>

                <form action="/accountedit" method="post">
                    <label for="firstname">first name</label>
                    <input type="text" name="firstname" class="textfield" tabindex="1" value="<c:out value='${sessionScope.user.firstName}' />" autofocus/>
                    <label for="lastname">last name</label>
                    <input type="text" name="lastname" class="textfield" tabindex="2" value="<c:out value='${sessionScope.user.lastName}' />" />
                    <%---<label for="email">e-mail</label>
                    <input type="email" name="email" class="textfield" tabindex="6" value="<c:out value='${sessionScope.user.email}"' /> />
                    --%>
                    <label for="location">location</label>
                    <select name="location" id="location" class="required" tabindex="3">
                        <option value="" tabindex="8">- home sweet home -</option>
                        <c:forEach items="${applicationScope['locations']}" var="loc">
                            <option value="${loc}"  <c:if test="${sessionScope.user.location eq loc}">selected</c:if> >
                                    ${loc}</option>
                        </c:forEach>
                    </select>
                    <div>
                    <label for="sex">I am a</label>
                    <select name="sex" id="sex" class="required" tabindex="4">
                            <option value="">- sex -</option>
                            <option value="male" <c:if test="${sessionScope.user.sex eq 'male'}">selected</c:if>>man</option>
                            <option value="female" <c:if test="${sessionScope.user.sex eq 'female'}">selected</c:if>>woman</option>
                    </select>
                    </div>
                    <div>
                    <label for="birthdayYear">I was born in</label>
                    <select name="birthday-year" id="year" class="required" tabindex="5">
                            <option value=""> - year - </option>
                            <c:forEach items="${applicationScope['birthyearRange']}" var="year">
                                <option value="${year}" <c:if test="${sessionScope.user.birthYear eq year}">selected</c:if>>${year}</option>
                            </c:forEach>
                    </select>
                    </div>
                    <label for="description">about me</label>
                    <textarea name="description" tabindex="6" class="textarea"><c:out value='${sessionScope.user.description}' /></textarea>
                    <label for="website">website</label>
                    <input type="url" name="website" class="textfield" tabindex="7" value="<c:out value='${sessionScope.user.website}' />" />
                    <%--<c:if test="${sessionScope.user.website}">
                        <a href="#" onclick="alert('TODO: add another website field now');">add</a>
                    </c:if>--%>
                    <p class="checkbox">
                        <input id="email-optin" type="checkbox" name="email-optin" 
                               <c:if test="${sessionScope.user.emailOptedIn}">checked="checked"</c:if> tabindex="10">
                            Yakimbe e-mail updates
                        </input>
                    </p>
                   <%--- <fieldset>
                        <legend>Site preferences</legend>
                    <label for="numItemsPage">items per page</label>
                    <select name="numItemsPage" class="digit-select" >
                        <option value="20" <c:if test="${sessionScope.user.numItemsPage == 20}">selected</c:if>>20</option>
                        <option value="30" <c:if test="${sessionScope.user.numItemsPage == 30}">selected</c:if>>30</option>
                        <option value="40" <c:if test="${sessionScope.user.numItemsPage == 40}">selected</c:if>>40</option>
                        <option value="50" <c:if test="${sessionScope.user.numItemsPage == 50}">selected</c:if>>50</option>
                    </select>
                  <label for="checkbox">e-mail opt-in</label>
                  <p class="checkbox"><input id="email-optin" type="checkbox" name="email-optin" checked="checked" tabindex="10">
                    please send me updates about Yakimbe!</input></p>
                  </fieldset> ---%>
                  <input type="submit" value="update account" class="submit" tabindex="8" />
                </form>
            </c:when>
            <c:otherwise>
                <p>You need to <a href="/userlogin/">login</a> first to edit your account</p>
            </c:otherwise>
        </c:choose>
                    
</div>

<script>
$(function(){
        $('[autofocus=""]').autofocus();
});
</script>

<%@include file="/WEB-INF/jspf/footer.jspf" %>
