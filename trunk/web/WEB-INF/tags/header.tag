<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%@tag description="Header tag includes opening HTML, HEAD and META tags" pageEncoding="UTF-8" %>
<%@attribute name="title" required="true" rtexprvalue="true" %>
<%@attribute name="rssXMLPath" required="false" rtexprvalue="true" %>

<!DOCTYPE html>

<html lang="en">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" >
    <meta name="description" content="Cut through the noise: find the best
          news, information, events and conversation in the mid-Michigan
          area on Yakimbe.com. Yakimbe is made and hosted in Lansing."  >
    <meta name="keywords" content="news, Lansing, mid-Michigan, local,
          east lansing, msu, lansing state journal, state news, wilx,
          wlns, events, information, current events, happening"  >
    <link rel="stylesheet" href="/css/styles.css" type="text/css" >

    <title>${title}</title>
    <link rel="shortcut icon" href="/images/favicon.ico"  >
    <c:if test="${not empty rssXMLPath}">
        <link rel="alternate" type="application/rss+xml" title="RSS" href="${rssXMLPath}">
    </c:if>
    <meta name="google-site-verification" content="-iKetLu7CTvt2tcFaCUS72i8_fk7D6QH4jV024KvHYQ" >
    <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.4.2/jquery.min.js" type="text/javascript"></script>
    <script src="/js/yakimbe.js" type="text/javascript"></script>
    <script src="http://connect.facebook.net/en_US/all.js"></script>
    <script type="text/javascript">
        var yakLoggedIn = ${not empty sessionScope['user']};
    </script>
</head>
<body>
    <div id="container">
            <div id="nav">
                <ul>
                    <li <c:if test="${fn:containsIgnoreCase(title, 'home')}"> class="currentpage"</c:if>>
                    <a href="<c:url value='/active'/>">Active</a></li>
                    <li <c:if test="${fn:containsIgnoreCase(title, 'newest')}"> class="currentpage"</c:if>>
                    <a href="<c:url value='/new' />">Newest</a></li>
                </ul>
            </div>
    <div id="page-wrapper">
        <div id="fb-root"></div>
        
        <script type="text/javascript">
          // initialize the library with the API key
          FB.init({
            appId  : '102923989756957',
            status : true,
            cookie : true,
            xfbml  : true,

          });
          FB.getLoginStatus(function(response) {
              if (response.session && !yakLoggedIn) {
                  //console.log("FB logged in - have to log user yak");
                  document.location.href='/fblogin?exist=true';
              }
              else {
                  //console.log("not logging user in");
              }
           });


</script>
        <script type="text/javascript">
            var timeout	= 500;
            var closetimer	= 0;
            var ddmenuitem	= 0;

            // open hidden layer
            function mopen(id)
            {
                    // cancel close timer
                    mcancelclosetime();

                    // close old layer
                    if(ddmenuitem) ddmenuitem.style.visibility = 'hidden';

                    // get new layer and show it
                    ddmenuitem = document.getElementById(id);
                    ddmenuitem.style.visibility = 'visible';

            }
            // close showed layer
            function mclose()
            {
                    if(ddmenuitem) ddmenuitem.style.visibility = 'hidden';
            }

            // go close timer
            function mclosetime()
            {
                    closetimer = window.setTimeout(mclose, timeout);
            }

            // cancel close timer
            function mcancelclosetime()
            {
                    if(closetimer)
                    {
                            window.clearTimeout(closetimer);
                            closetimer = null;
                    }
            }

            // close layer when click-out
            document.onclick = mclose;
        </script>