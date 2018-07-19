<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="../includes/header.jsp"%>

<!-- Section -->
<section>
	<header class="major">
		<h2 class="mainFont">Free Board</h2>
	</header>
	<section>
		<div>
			<table>
				<thead>
					<tr>
						<th>No</th>
						<th>Title</th>
						<th>ID</th>
						<th>RegDate</th>
						<th>UpdateDate</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${list}" var="boardVO">
						<tr class="rowData" data-value="${boardVO.bno}">
							<td name="bno">${boardVO.bno}</td>
							<td name="rtname">${boardVO.title}</td>
							<td name="id">${boardVO.id}</td>
							<td name="regidate"><fmt:formatDate value="${boardVO.regdate}" type="both"/></td>
							<td name="updatedate"><fmt:formatDate value="${boardVO.updatedate}" type="both"/></td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
	</section>
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
						<option value="n" ${pm.cri.type eq null?'selected':''}>-
							Category -</option>
						<option value="t" ${pm.cri.type eq 't'?'selected':''}>Title</option>
						<option value="c" ${pm.cri.type eq 'c'?'selected':''}>Content</option>
						<option value="w" ${pm.cri.type eq 'w'?'selected':''}>Writer</option>
						<option value="t-c" ${pm.cri.type eq 't-c'?'selected':''}>Title
							+ Content</option>
						<option value="t-w" ${pm.cri.type eq 't-w'?'selected':''}>Title
							+ Writer</option>
						<option value="w-c" ${pm.cri.type eq 'w-c'?'selected':''}>Writer
							+ Content</option>
						<option value="t-c-w" ${pm.cri.type eq 't-c-w'?'selected':''}>Title
							+ Content + Writer</option>
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
	var rowData = $(".rowData");
	
	rowData.click(function(event){
		$(this).data("value");
	});
	
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
</script>