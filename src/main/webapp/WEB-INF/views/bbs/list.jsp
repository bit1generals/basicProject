<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@include file="../includes/header.jsp"%>


<!-- Banner -->
<section id="banner">
	<div class="content">
		<header>
			<h1 class="mainFont">
				Generals<br /> by BitCamp
			</h1>
			<p>DongKyu JungKeun SuHyun</p>
		</header>
		<p>Aenean ornare velit lacus, ac varius enim ullamcorper eu. Proin
			aliquam facilisis ante interdum congue. Integer mollis, nisl amet
			convallis, porttitor magna ullamcorper, amet egestas mauris. Ut magna
			finibus nisi nec lacinia. Nam maximus erat id euismod egestas.
			Pellentesque sapien ac quam. Lorem ipsum dolor sit nullam.</p>
		<ul class="actions">
			<li><a href="#" class="button big">Learn More</a></li>
		</ul>
	</div>
	<span class="image object"> <img
		src="/resources/images/dotte4.gif" alt="" />
	</span>
</section>

<!-- Section -->
<section>
	<header class="major">
		<h2 class="mainFont">Free Board</h2>
	</header>
	<div class="posts">
		<c:forEach items="${list}" var="boardVO">

			<article data-key="${boardVO.bno}" data-uri="view" data-method="get">
				<a class="image"> <img src="/resources/images/1.jpg" alt=""
					class="view" /></a>
				<div class="row uniform textArea">
					<div class="8u 12u$(xsmall)">
						<h3>${boardVO.title}</h3>
					</div>
					<div class="4u 12u$(xsmall)">
						<h3>${boardVO.id}</h3>
					</div>
				</div>
				<c:choose>
					<c:when test="${boardVO.content.length() > 50}">
						<p>${boardVO.content.substring(0,50)}...... (づ｡◕‿‿◕｡)づ </p>
					</c:when>
					<c:otherwise>
						<p>${boardVO.content}</p>
					</c:otherwise>
				</c:choose>
				<ul class="actions">
					<li><button class="view">More</button></li>
				</ul>
			</article>
		</c:forEach>
	</div>

</section>
<center>
	<ul class="pagination">
		<li><span class="button ${pm.prev ?'':'disabled'}">Prev</span></li>
		<c:forEach begin="${pm.start}" end="${pm.end}" var="i">
			<li><a href="#" class="page ${i eq pm.page?'active' : ''}">${i}</a></li>
		</c:forEach>
		<li><span class="button ${pm.next ?'':'disabled'}">Next</span></li>
	</ul>

</center>
</div>
</div>

<form id="searchForm">
	<input type="hidden" name="key" value=""> <input type="hidden"
		name="page" value="${param.page}">
</form>



<%@include file="../includes/footer.jsp"%>
<script>
	var formObj = $("#searchForm");

	$("article .view").click(
			function(event) {

				var that = $(event.target).parents("article");
				formObj.find("[name='key']").val(that.data("key"));
				formObj.attr("action", that.data("uri")).attr("method",
						that.data("method")).submit();
			});
</script>