<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="../includes/header.jsp"%>



<!-- Section -->
<section>
	<header class="major">

		<h2 class="mainFont">
			Busking List
		</h2>
	</header>
	<form method="get">
		<hr>
		<div class="posts content">
			<c:forEach items="${list}" var="stageVO">
				<article data-key="${stageVO.boardVO.bno}" data-uri="view"
					data-method="get">

					<a class="image"> <img style="cursor: pointer"
						src="${stageVO.boardVO.files[0].fno ne null 
					? stageVO.boardVO.files[0].urlBuilder('midthumbnails') : '/resources/images/1.jpg'}"
						alt="" class="view" /></a>

					<div class="row uniform textArea">
						<div class="8u 12u$(xsmall)">
							<h3>${stageVO.boardVO.title}</h3>
						</div>
						<div class="4u 12u$(xsmall)">
							<h3>${stageVO.boardVO.id}</h3>
						</div>

						<div class="12u">
							<h4>${stageVO.address}</h4>
						</div>
					</div>

					<c:choose>
						<c:when test="${stageVO.boardVO.content.length() > 50}">
							<p>${stageVO.boardVO.content.substring(0,50)}...... (づ｡◕‿‿◕｡)づ </p>
						</c:when>
						<c:otherwise>
							<p>${stageVO.boardVO.content}</p>
						</c:otherwise>
					</c:choose>
					<ul class="actions">
						<li><button class="view">More</button></li>
					</ul>
				</article>
			</c:forEach>
			${buskingVOList}
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


	<div class="row uniform textArea">
		<div class="3u 12u$(xsmall)">
			<div class="select-wrapper">
				<select name="type">
					<option value="" ${pm.cri.type eq null?'selected':''}>-
						Category -</option>
					<option value="a" ${pm.cri.type eq 'a'?'selected':''}>Address</option>
					<option value="rt" ${pm.cri.type eq 'rt'?'selected':''}>Stage
						Name</option>
					<option value="w" ${pm.cri.type eq 'w'?'selected':''}>Writer</option>
					<option value="a-rt" ${pm.cri.type eq 'a-rt'?'selected':''}>Address
						+ Stage Name</option>
					<option value="a-w" ${pm.cri.type eq 'a-w'?'selected':''}>Address
						+ Writer</option>
					<option value="w-rt" ${pm.cri.type eq 'w-rt'?'selected':''}>Writer
						+ Stage Name</option>
					<option value="a-rt-w" ${pm.cri.type eq 'a-rt-w'?'selected':''}>Address
						+ Stage Name + Writer</option>
				</select>
			</div>
		</div>
		<div class="5u 12u$(xsmall)">
			<input type="text" name="keyword" placeholder="Input Keyword"
				value="${pm.cri.keyword ne null ? pm.cri.keyword : '' }">
		</div>

		<div class="4u 12u$(xsmall)">
			<ul class="actions">
				<li><button class="button special icon fa-search">Search</button></li>
				<li><a href="./register" class="button">Register</a></li>
			</ul>
		</div>
	</div>
	</form>
</section>
</div>
</div>

<form id="searchForm">
	<input type="hidden" name="key" value=""> <input type="hidden"
		name="page" value="${pm.cri.page}"> <input type="hidden"
		name="state" value="${pm.cri.state}">

	<c:if test="${pm.cri.type != null }">
		<input type="hidden" name="keyword" value="${pm.cri.keyword }">
		<input type="hidden" name="type" value="${pm.cri.type}">
	</c:if>
</form>

<script id="tableFormat" type="text/x-handlebars-template">
	<h1>tableFormat</h1>
</script>
<script id="listFormat" type="text/x-handlebars-template">
	<h1>listFormat</h1>
</script>

<%@include file="../includes/footer.jsp"%>
<script>
	var formObj = $("#searchForm");
	var radioButton = $(".radioButton");
	var formatBtn = $(".formatBtn");
	var content = $(".content");
	
/* 	formatBtn.click(function(event){
		var inhtml = Handlebars.compile($("#"+this.name).html());
		content.html(inhtml);
	}); */
	
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

	$(".fa-search").click(function(event) {

		var keyword = $("[name='keyword']").val().trim();

		if (keyword.length == 0) {
			event.preventDefault();
			swal("Please enter your search term.");
		}
	});

	radioButton.change("input", function(event) {
		console.log(event.target);
		formObj.find("[name='state']").val($(event.target).val())
		formObj.attr("action", "list").submit();
	});

</script>