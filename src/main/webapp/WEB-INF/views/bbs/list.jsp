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
				<a class="image"> <img style="cursor: pointer"
					src="/resources/images/1.jpg" alt="" class="view" /></a>
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
<section>

	<center>
		<ul class="pagination" data-uri="list" data-method="get">
			<li data-page="${pm.start-1}"><span style="pointer-events: auto"
				class="button ${pm.prev ?'':'disabled'}">Prev</span></li>
			<c:forEach begin="${pm.start}" end="${pm.end}" var="i">
				<li style="cursor: pointer" data-page="${i}"><span
					class="page ${i eq pm.cri.page?'active' : ''}"> ${i} </span></li>
			</c:forEach>
			<li data-page="${pm.end+1}"><span
				class="button ${pm.next ?'':'disabled'}">Next</span></li>
		</ul>
	</center>

	<form method="get">
		<div class="row uniform textArea">
			<div class="3u 12u$(xsmall)">
				<div class="select-wrapper">
					<select name="type">
						<option value="n" ${pm.cri.type eq null?'selected':''}>- Category -</option>
						<option value="t" ${pm.cri.type eq 't'?'selected':''}>Title</option>
						<option value="c" ${pm.cri.type eq 'c'?'selected':''}>Content</option>
						<option value="w" ${pm.cri.type eq 'w'?'selected':''}>Writer</option>
						<option value="t-c" ${pm.cri.type eq 't-c'?'selected':''}>Title + Content</option>
						<option value="t-w" ${pm.cri.type eq 't-w'?'selected':''}>Title + Writer</option>
						<option value="w-c" ${pm.cri.type eq 'w-c'?'selected':''}>Writer + Content</option>
						<option value="t-c-w" ${pm.cri.type eq 't-c-w'?'selected':''}>Title + Content + Writer</option>
					</select>
				</div>
			</div>
			<div class="5u 12u$(xsmall)">
				<input type="text" name="keyword" placeholder="Input Keyword" value="${pm.cri.keyword ne null ? pm.cri.keyword : '' }">
			</div>

			<div class="4u 12u$(xsmall)">
				<ul class="actions">
					<li><button class="button special icon fa-search">Search</button></li>
					<li><a href="/bbs/register" class="button">Register</a></li>
				</ul>
			</div>
		</div>
	</form>
</section>
</div>
</div>

<form id="searchForm">
	<input type="hidden" name="key" value=""> <input type="hidden"
		name="page" value="${pm.cri.page}">

	<c:if test="${pm.cri.type != null }">
		<input type="hidden" name="keyword" value="${pm.cri.keyword }">
		<input type="hidden" name="type" value="${pm.cri.type}">
	</c:if>
</form>



<%@include file="../includes/footer.jsp"%>
<script>
	var formObj = $("#searchForm");

	$(".pagination").on(
			"click",
			"span:not(.disabled)",
			function(event) {
				var that = $(event.target).parents("li");
				var parents = that.parents(".pagination");
				formObj.find("[name='key']").remove();
				formObj.find("[name='page']").val(that.data("page"));
				formObj.attr("action", parents.data("uri")).attr("method",
						parents.data("method")).submit();
			});

	$("article .view").click(
			function(event) {
				var that = $(event.target).parents("article");
				formObj.find("[name='key']").val(that.data("key"));
				formObj.attr("action", that.data("uri")).attr("method",
						that.data("method")).submit();
			});
	
	$(".fa-search").click(function(event){
		
		var keyword = $("[name='keyword']").val().trim();
		
		
		if(keyword.length == 0){
			event.preventDefault();
			alert("검색어를 입력하세요.");
		}
	});
</script>