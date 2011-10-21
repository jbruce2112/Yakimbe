<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="pageTitle" scope="page" value="About Us | Yakimbe" />

<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
	<link rel="stylesheet" href="css/styles.css" type="text/css"/>

	<title>Yakimbe | Where Lansing Finds its News</title>



</head>

<body>


	<div id="page-wrapper">
		<div id="header">
			<ul class="toplinks">
				<li><a href="#">sign up</a></li>
				<li><a href="#">blog</a></li>
				<li><a href="#">contact us</a></li>
				<li class="first"><a href="#">toplinks class</a></li>
			</ul>
			<img src="images/yakimbe_logo.gif" alt="Yakimbe: Where Lansing finds its news" />
			<div id="nav">
				<ul>
					<li class="current-page"><a href="#">currentPage</a></li>
					<li><a href="#">link</a></li>
					<li><a href="submit.html">submit</a></li>
					<li><a href="#">about</a></li>
					<li class="last"><a href="login.html">login</a></li>
				</ul>
			</div>
		</div>

		<div id="main-content">
			<div id="message">
		            <p>This is a top-of-page message, with a <a href="#">dummy link</a></p>
					<p>Your submission had some errors:
		            <ol class="error">
		                <li>this is an error message</li>
				<li>And one more error message here here</li>
		            </ol>
		    </div>
				<h2>H2 headline, sentence case</h2>
				<h3>H3 headline, sentence case</h3>
				<h4>h4 headline, lowercase</h4>
				<p>paragraph tag</p>
				<p>lists are pared down to basics, then rebuilt for specific uses</p>
				<a href="#">This is a link with no para tags</a>
				<p><a href="#">This is a link with para tags</a></p>
				<ul>
					<li>unordered list style</li>
					<li>unordered list style</li>
					<li>unordered list style</li>
				</ul>
				<ol>
					<li>ordered list style</li>
					<li>ordered list style</li>
					<li>ordered list style</li>
				</ol>
				<p class="note-right">This is a right-justified note</p>
				<p class="note-left">This is a left-justified note</p>

				&nbsp;<br />
				&nbsp;<br />
				&nbsp;<br />
				&nbsp;<br />
				<h2>Submission listings</h2>
				<ol>
					<li class="submission">
						<a href="#" class="upvote">upvote</a>
						<a href="#" class="downvote">downvote</a>
						<h3><a href="#">H3 submission headline</a></h3>
						<ul class="submission-info">
							<li class="first"><a href="#">Link in list element</a></li>
							<li>12 points</li>
							<li>submitted by <a href="#">link style</a> 3 hours ago</li>
							<li><a href="#">www.today.msnbc.com</a></li>
						</ul>
					</li>
				</ol>
                <a id="prev" class="button" href="#">Prev</a>
                <a id="next" class="button" href="#">Next</a>

				&nbsp;<br />
				&nbsp;<br />
				&nbsp;<br />
				&nbsp;<br />
				<h2>Comments</h2>

				<div id="comments">
					<ul class="comment-root">

						<li>
							<p class="comment-meta">300 points | submitted by <a href="#">dbarry</a> 3 hours ago</p>
							<a href="#" class="upvote">upvote</a>
							<a href="#" class="downvote">downvote</a>
							<p>Well, I guess that's good news, but what does it indicate about our area other than no one wants to move here? I mean, the only reason we're third best is houses are so cheap. You can buy a 1,500sqf house in lansing for $30 large.</p>
							<a href="#" title="reply to this comment" class="reply">reply</a>

							<ul class="comment-reply">
								<li>
									<p class="comment-meta">-1 point | submitted by <a href="#">dbarry</a> 3 hours ago</p>
									<a href="#" class="upvote">upvote</a>
									<a href="#" class="downvote">downvote</a>
									<p class="karma-1">This is a comment to a root-level comment - it is a second-level comment</p>
									<!--<a href="#" title="reply to this comment" class="reply">reply</a>-->
									<div id="newreply38" class="add-reply">
                                                                            <textarea id="replybody38" class="reply-textarea" name="body" tabindex="1" ></textarea>
                                                                            <button class="submit" tabindex="2">submit</button>
                                                                            <button class="submit" tabindex="3">cancel</button>
                                                                        </div>

									<ul class="comment-reply">
										<li class="comment-meta">
											<p class="comment-meta">2 points | submitted by <a href="#">dbarry</a> 3 hours ago</p>
											<a href="#" class="upvote">upvote</a>
											<a href="#" class="downvote">downvote</a>
											<p>this is a third level comment</p>
											<a href="#" title="reply to this comment" class="reply">reply</a>

											<ul class="comment-reply">
												<li class="comment-meta">
													<p class="comment-meta">2 points | submitted by <a href="#">dbarry</a> 3 hours ago</p>
													<a href="#" class="upvote">upvote</a>
													<a href="#" class="downvote">downvote</a>
													<p>this is a fourth level comment</p>
													<a href="#" title="reply to this comment" class="reply">reply</a>
												</li>
											</ul>
										</li>

										<li class="comment-meta">
											<p class="comment-meta">2 points | submitted by <a href="#">dbarry</a> 3 hours ago</p>
											<a href="#" class="upvote">upvote</a>
											<a href="#" class="downvote">downvote</a>
											<p>this is a third level comment</p>
											<a href="#" title="reply to this comment" class="reply">reply</a>
										</li>
									</ul>

								</li>
							</ul>

						</li id="end root-element1">

						<li class="comment-meta" id="reply-element2">
							<p class="comment-meta">2 points | submitted by <a href="#">dbarry</a> 3 hours ago</p>
							<a href="#" class="upvote">upvote</a>
							<a href="#" class="downvote">downvote</a>
							<p>this is a root level reply</p>
							<a href="#" title="reply to this comment" class="reply">reply</a>
						</li id="reply-element3">
					</ul id="end comment-root">

				</div id="end comments">
				</div><!--end main content-->


				&nbsp;<br />
				&nbsp;<br />
				&nbsp;<br />

				<h2>Form styles</h2>
				<form id="add-comment" class="add-comment" action="#">
					<label for="add-comment">text area, submit button</label>
					<textarea id="add-comment" name="add-comment" class="textarea" tabindex="1"></textarea>
					<label for="firstName">text input</label>
					<input type="text" id="firstName" name="firstName" class="required textfield" tabindex="1"autofocus/>
					<label for="sex">select box</label>
					<select name="sex" id="sex" class="required" tabindex="7">
						<option value="">- sex -</option>
						<option value="male">man</option>
						<option value="female">woman</option>
					</select>
					<input type="submit" value="Submit" class="submit" tabindex="2" />
				</form>
		</div>
		<div id="sidebar">
			<h4>H4 headline</h4>
			<ul>
				<li><a href="#">Link in list element in sidebar</a></li>
				<li><a href="#">Today show names Lansing as third best real estate market in the country</a></li>
				<li><a href="#">Today show names Lansing as third best real estate market in the country</a></li>
			</ul>
			<hr />
			<h4>H4 headline</h4>
			<ul>
				<li><a href="#">Today show names Lansing as third best real estate market in the country</a></li>
				<li><a href="#">Today show names Lansing as third best real estate market in the country</a></li>
				<li><a href="#">Today show names Lansing as third best real estate market in the country</a></li>
			</ul>
		</div>

		<div id="footer">
			<ul>
				<li class="first"><a href="#">link in footer</a></li>
				<li><a href="#">It will have copyright info</a></li>
				<li><a href="#">And stuff like that</a></li>
			</ul>
		</div>
	</div>

</body>
</html>