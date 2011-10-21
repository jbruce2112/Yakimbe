<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@taglib prefix="y" uri="YakimbeTags" %>

<%@tag description="Displays a comment on the page" pageEncoding="UTF-8" import="com.yakimbe.model.Comment" %>
<%@attribute name="comment" required="true" rtexprvalue="true" type="com.yakimbe.model.Comment" %>
<%@attribute name="level" required="true" rtexprvalue="true" type="java.lang.Integer" %>
            
            <%-- for notification bookmarks--%>
            <a id="${comment.itemId}"></a>
            <li id="${comment.commentId}" >
                <p class="comment-meta">
                ${comment.rating}
                        <c:choose>
                            <c:when test="${comment.rating eq 1}">
                                point
                            </c:when>
                            <c:otherwise>
                                points
                            </c:otherwise>
                        </c:choose>
                                | submitted by <a href="<c:url value='/user/${comment.userName}' />">${comment.userName}</a> ${comment.friendlyTime}
                    <c:if test="${sessionScope.user.id eq comment.userId}">
                                <c:url value='/editcomment' var="editURL">
                                   <c:param name='cid' value='${comment.commentId}'/>
                               </c:url>
                                | <a href="${editURL}">edit</a>
                    </c:if>
                                
                    <c:if test="${not empty comment.editNotes}">
                             | <a class="historylink" href="#hist_${comment.itemId}">history</a>
                            <ol class="edithistory" id="hist_${comment.itemId}">
                            <c:forEach items="${comment.editNotes}" var="editNote" varStatus="i">
                                <li><strong>Edit ${i.count}:</strong> <c:out value='${editNote.comment}' /></li>
                            </c:forEach>
                        </ol>
                    </c:if>
                </p>

                <a href="<c:url value='/Action' >
                       <c:param name='vote' value='up'/>
                       <c:param name='id' value='${comment.itemId}'/>
                   </c:url>"
                       <c:choose>
                           <c:when test="${sessionScope.user.userActions[y:ToString(comment.itemId)] eq 'upvote'}">
                               style="background-position: -13px 0;"
                               title="undo upvote"
                           </c:when>
                           <c:otherwise>
                               title="upvote (click again to undo)"
                           </c:otherwise>
                       </c:choose>class="upvote">upvote</a>

                <a href="<c:url value='/Action' >
                       <c:param name='vote' value='down'/>
                       <c:param name='id' value='${comment.itemId}'/>
                   </c:url>"
                        <c:choose>
                            <c:when test="${sessionScope.user.userActions[y:ToString(comment.itemId)] eq 'downvote'}">
                                style="background-position: -13px -14px;"
                                title="undo downvote"
                            </c:when>
                            <c:otherwise>
                                title="downvote (click again to undo)"
                            </c:otherwise>
                        </c:choose>
                        class="downvote">downvote</a>

              <%-- apply style based on vote tally --%>
                <c:choose>
                      <c:when test="${comment.rating < 0}">
                           <p class="karma-1">
                      </c:when>
                      <c:when test="${comment.rating == 0}">
                           <p class="karma-0">
                      </c:when>
                      <c:otherwise>
                           <p>
                      </c:otherwise>
                 </c:choose>
                               
                    ${y:HTMLFormatting(comment.body)}
                    
                 <c:choose>
                     <c:when test="${(level <= initParam.maxCommentNesting) && (not empty sessionScope.user)}">
                         <a onclick="showReply('newreply${comment.commentId}'); return false; " class="reply smallbutton" href="#">Reply</a></p>

                        <div id="newreply${comment.commentId}" class="add-reply">
                            <textarea id="replybody${comment.commentId}" class="reply-textarea" name="body" tabindex="1" ></textarea>

                            <button class="submit" tabindex="2">Submit</button>
                        </div>
                     </c:when>
                    <c:otherwise>
                        </p>
                    </c:otherwise>
                  </c:choose>