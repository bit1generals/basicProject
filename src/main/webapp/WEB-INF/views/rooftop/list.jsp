<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="../includes/header.jsp"%>



<!-- Section -->
<section>
	<header class="major">

		<h2 class="mainFont">
			Rooftop
			<c:if test="${param.state eq 'N'}"> Unreceived </c:if>
			List
		</h2>
	</header>
	<form method="get">
		<sec:authorize access="hasRole('ROLE_ADMIN')">
			<div class="row uniform">
				<div class="8u 12u$(xsmall)"></div>
				<div class="4u 12u$(xsmall) radioButton">
					<input type="radio" id="authorize" name="state" value="Y" ${pm.cri.state eq 'Y' ? 'checked="checked"' : '' }>
					<label for="authorize">Authorize</label> 
					
					<input type="radio"
						id="nonAuthorize" name="state" value="N" ${pm.cri.state eq 'N' ? 'checked="checked"' : '' }> <label
						for="nonAuthorize">NonAuthorize</label> 
						
						<input type="radio"
						id="all" name="state" value="" ${pm.cri.state eq null || pm.cri.state eq '' ? 'checked="checked"' : '' }><label for="all">ALL</label>
				</div>
			</div>
			<hr>
		</sec:authorize>



		<div class="posts">
			<c:forEach items="${list}" var="rooftopVO">
				<article data-key="${rooftopVO.boardVO.bno}" data-uri="view"
					data-method="get">

					<a class="image"> <img style="cursor: pointer"
						src="${rooftopVO.boardVO.files[0].fno ne null 
					? rooftopVO.boardVO.files[0].urlBuilder('midthumbnails') : '/resources/images/1.jpg'}"
						alt="" class="view" /></a>

					<div class="row uniform textArea">
						<div class="8u 12u$(xsmall)">
							<h3>${rooftopVO.boardVO.title}</h3>
						</div>
						<div class="4u 12u$(xsmall)">
							<h3>${rooftopVO.boardVO.id}</h3>
						</div>

						<div class="12u">
							<h4>${rooftopVO.address}</h4>
						</div>
					</div>

					<c:choose>
						<c:when test="${rooftopVO.boardVO.content.length() > 50}">
							<p>${rooftopVO.boardVO.content.substring(0,50)}...... (づ｡◕‿‿◕｡)づ </p>
						</c:when>
						<c:otherwise>
							<p>${rooftopVO.boardVO.content}</p>
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


	<div class="row uniform textArea">
		<div class="3u 12u$(xsmall)">
			<div class="select-wrapper">
				<select name="type">
					<option value="" ${pm.cri.type eq null?'selected':''}>-
						Category -</option>
					<option value="a" ${pm.cri.type eq 'a'?'selected':''}>Address</option>
					<option value="rt" ${pm.cri.type eq 'rt'?'selected':''}>Rooftop
						Name</option>
					<option value="w" ${pm.cri.type eq 'w'?'selected':''}>Writer</option>
					<option value="a-rt" ${pm.cri.type eq 'a-rt'?'selected':''}>Address
						+ Rooftop Name</option>
					<option value="a-w" ${pm.cri.type eq 'a-w'?'selected':''}>Address
						+ Writer</option>
					<option value="w-rt" ${pm.cri.type eq 'w-rt'?'selected':''}>Writer
						+ Rooftop Name</option>
					<option value="a-rt-w" ${pm.cri.type eq 'a-rt-w'?'selected':''}>Address
						+ Rooftop Name + Writer</option>
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
				<li><a href="/rooftop/register" class="button">Register</a></li>
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
	<input type="hidden" name="state" value="${pm.cri.state}">

	<c:if test="${pm.cri.type != null }">
		<input type="hidden" name="keyword" value="${pm.cri.keyword }">
		<input type="hidden" name="type" value="${pm.cri.type}">
	</c:if>
</form>



<%@include file="../includes/footer.jsp"%>
<script>
	var formObj = $("#searchForm");
	var radioButton = $(".radioButton");
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
			alert("검색어를 입력하세요.");
		}
	});
	
	radioButton.change("input", function(event){
		console.log(event.target);
		formObj.find("[name='state']").val($(event.target).val())
		formObj.attr("action", "list").submit();
	});
/* 	
	radioButton.click("input", function(event) {
		
	});
	$("label").click(function(event){
		event.stopPropagation();
	}); */
</script>