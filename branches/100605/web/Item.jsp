<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="y" uri="YakimbeTags" %>
<%@taglib prefix="yak" tagdir="/WEB-INF/tags/" %>

<yak:header title="${item.headline} | Yakimbe" />


<script type="text/javascript">

$(document).ready(function() {
        var rootItemId = ${item.itemId};
        
        $(".add-reply > button").click(function() {
            var commentId = "";
            var match = /\d+/.exec(this.parentNode.getAttribute('id'));
            if (match != null) {
                for (var i = 0; i < match.length; i++) {
                  commentId += match[i];
                }
            }
            var bodyId = "replybody"+commentId;
            var myVal = document.getElementById(bodyId).value.replace(/\n/g,'%0d');
            window.location.href = "/comment/?parentid="+commentId+"&body="+ myVal + "&itemid="+rootItemId+"";
         });

        $("a.downvote, a.upvote").tooltip({
            track:true,
            delay: 750,
            showURL: false
        });

    });


    var addReplyDisplayed = null;
    function showReply(id) {

        var elm = document.getElementById(id);

        if (addReplyDisplayed === null) {
            addReplyDisplayed = elm;
            elm.style.display = "block";
        }
        else {
            addReplyDisplayed.style.display = "none";
            if (elm !== addReplyDisplayed) {
                elm.style.display = "block"
                addReplyDisplayed = elm;
            }
            else {
                addReplyDisplayed = null;
            }
        }
    }
</script>

<div id="main-content">

<%@include file="WEB-INF/jspf/messagecenter.jspf" %>

            <ol id="item">
                <li class="submission">
                        <ul class="submission-info">
                        <li class="first">
                            ${item.rating}
                                <c:choose>
                                    <c:when test="${item.rating eq 1}">
                                        point
                                    </c:when>
                                    <c:otherwise>
                                        points
                                    </c:otherwise>
                                </c:choose>
                        </li>

                        <li>
                            submitted by <a href="<c:url value='/user/${item.userName}' />">${item.userName}</a> ${item.friendlyTime}
                        </li>

                        <li>
                            <a href="<c:out value='${y:GetDomain(item.url)}'/>">
                                <c:out value='${y:SimpleDomainDisplay(item.url)}'/>
                            </a>
                        </li>

                            <c:if test="${sessionScope.user.id eq item.userId}">
                                <li>
                                    <a href="/editsubmission">edit</a>
                                </li>
                            </c:if>
                            <c:if test="${not empty item.editNotes}">
                                <li>
                                    <a class="historylink" href="#hist_${item.itemId}">history</a>
                                </li>
                                <ol class="edithistory" id="hist_${item.itemId}">
                                    <c:forEach items="${item.editNotes}" var="editNote" varStatus="i">
                                        <li><strong>Edit ${i.count}:</strong> <c:out value='${editNote.comment}' /></li>
                                    </c:forEach>
                                </ol>
                            </c:if>
                        </ul>
                 </li>
                 <br/>


                    <a href="<c:url value='/Action' >
                           <c:param name='vote' value='up'/>
                           <c:param name='id' value='${item.itemId}'/>
                       </c:url>"
                       <c:choose>
                           <c:when test="${user.userActions[y:ToString(item.itemId)] eq 'upvote'}">
                               style="background-position: -13px 0;"
                               title="undo upvote"
                           </c:when>
                           <c:otherwise>
                               title="upvote (click again to undo)"
                           </c:otherwise>
                       </c:choose>class="upvote">upvote</a>

                    <a href="<c:url value='/Action' >
                           <c:param name='vote' value='down'/>
                           <c:param name='id' value='${item.itemId}'/>
                       </c:url>"
                        <c:choose>
                            <c:when test="${user.userActions[y:ToString(item.itemId)] eq 'downvote'}">
                                style="background-position: -13px -14px;"
                                title="undo downvote"
                            </c:when>
                            <c:otherwise>
                                title="downvote (click again to undo)"
                            </c:otherwise>
                        </c:choose>
                        class="downvote">downvote</a>


                <h3><a target="_blank" href="<c:out value='${item.url}' />">${y:HeadlineFormatting(item.headline)}</a></h3>
                <p><c:out value='${item.subhead}' /></p>
            </ol>

            <form id="newcomment" class="add-comment" action="/comment/" method="post">
                <label for="add-comment">add a comment</label>
                <textarea id="add-comment" name="body" class="textarea" tabindex="1"
                          <c:choose>
                              <c:when test="${sessionScope.attemptedCommentParentId eq 0 and sessionScope.attemptedCommentItemCommentingOnId eq item.itemId}">
                                  autofocus>${sessionScope.attemptedCommentBody}
                              </c:when>
                              <c:otherwise> ></c:otherwise>
                          </c:choose></textarea>
                <input type="hidden" name="itemid" value="${item.itemId}" />
                <input type="hidden" name="parentid" value="0" />
                <input type="submit" value="submit" class="submit" tabindex="2"/>
            </form>
            <%--this exists for IE6 compatibility. Don't touch it, don't ask. --%>
            <br />

            <ul id="comments">
                <li id="comment-thread">
                     <y:Comments tree="${comments}" var="comment" level="mylevel" >
                         <yak:comment comment="${comment}" level="${mylevel}" />
                     </y:Comments>
                </li>
            </ul>
</div>

<yak:sidebar />

<script type="text/javascript">
    $(function() {
        
    <c:if test="${not empty sessionScope.attemptedCommentBody and sessionScope.attemptedCommentItemCommentingOnId eq item.itemId}">
        $('[autofocus=""]').autofocus();
    </c:if>

        $('.historylink').tooltip({
            track:true,
            delay: 100,
            showURL: false,
            extraClass: "pretty",
            bodyHandler: function() {
                    return $($(this).attr("href")).html();
            }
        });

        $('.historylink').click(function() {
            return false;
        });
    });
</script>

    <%--
        Since we're redirecting to this page opposed to sending a requestDispatcher, we need to reference the session scope
         when dealing with these vars. We also don't want them to live longer than the duration of the comment attempt - login - reattempt,
         so we remove them here.
    --%>
    <%
        String attemptedCommentBody = (String) request.getSession().getAttribute("attemptedCommentBody");
        
        long attemptedCommentItemCommentingOnId = 0;
        try {
            attemptedCommentItemCommentingOnId = Long.parseLong((String) request.getSession().getAttribute("attemptedCommentItemCommentingOnId"));
        }
        catch (Exception e) {}

        if (attemptedCommentBody != null && attemptedCommentBody.length() > 0 &&
            attemptedCommentItemCommentingOnId == ((com.yakimbe.model.Submission) pageContext.findAttribute("item")).getItemId()) {
            request.getSession().removeAttribute("attemptedCommentBody");
            request.getSession().removeAttribute("attemptedCommentParentId");
            request.getSession().removeAttribute("attemptedCommentItemCommentingOnId");
        }
        
    %>

<%@include file="/WEB-INF/jspf/footer.jspf" %>
