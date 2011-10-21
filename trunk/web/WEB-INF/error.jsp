<%-- A generic error page --%>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="pageTitle" scope="page" value="Error | Yakimbe" />
<%@include file="/WEB-INF/jspf/header.jspf" %>

<div id="main-content">
    
    <p>
        Sorry, looks like there was a problem with your last request. <br>
        If you think this is an error on our end, please <a href="mailto:<c:out value='${initParam.adminEmail}' />">let us know</a>.
    </p>

    <%-- Show any errors we sent here. --%>
    <c:if test="${not empty requestScope['errors']}">
        <p>Some problems with your request:
        <ol>
            <c:forEach items="${requestScope['errors']}" var="error">
                <li><c:out value="${error}" /></li>
            </c:forEach>
        </ol>
    </c:if>

</div>

<%@include file="/WEB-INF/jspf/footer.jspf" %>

