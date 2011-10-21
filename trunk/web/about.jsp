<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="yak" tagdir="/WEB-INF/tags" %>

<yak:header title="About Us | Yakimbe" />

<div id="main-content">
    <div id="copy">
        <h1>About Us</h1>
        <p>Yakimbe was created by two guys drinking coffee at Gone Wired Cafe. Tired of not finding what we wanted on traditional media sites and the lack of intelligent commenting features on most local sites, we decided to create Yakimbe.</p>
        <h3>Project Goals:</h3>
        <ul class="bodylist">
            <li>Form a single, unique space to share and discuss topics concerning mid-Michigan</li>
            <li>Create an environment for intelligent, civil community discussion</li>
            <li>Empower the community to highlight local news and events they feel are important</li>
            <li>Level the playing field for local alternative media sources, such as amateur bloggers and independent media outlets</li>
        </ul>
        <p>Yakimbe was built from scratch right here in Lansing. We are constantly listening to your feedback and improving Yakimbe to make sure we provide the best possible local news experience you can find.</p>
        <p>Help us build the place we imagine. Give us a hand by submitting a news item or event, sharing your thoughts in the comments or simply voting on an item. And please be sure to read and follow our <a href="<c:url value='/guidelines/' />">community guidelines</a>.</p>

        <h1>The Founders</h1>
        <h3>Jesse Woodruff</h3>
        <p class="contact">Founder and CEO&nbsp; | &nbsp; <a href="mailto:jesse@yakimbe.com">jesse@yakimbe.com</a></p>
        <p>Inveterate tinkerer, day-dreamer and compulsive entrepreneur, Jesse Woodruff is responsible for making Yakimbe relevant. When he's not scaring his business partner with impossible new features or day-dreaming revenue plans, Jesse stays busy grooming the Yakimbe experience.
        </p>
        <h3>John Bruce</h3>
        <p class="contact">Co-Founder and CTO&nbsp; | &nbsp;<a href="mailto:john@yakimbe.com">john@yakimbe.com</a></p>
        <p>Aspiring Computer Science major and cat enthusiast, John Bruce is responsible for the engine that powers Yakimbe. Between studying for class and playing shows with his band Cavalcade, John is busy hacking the logic of Yakimbe to serve up pages smarter and faster.
        </p>
    </div>
</div>
<yak:sidebar />

<%@include file="/WEB-INF/jspf/footer.jspf" %>