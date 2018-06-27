<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ include file="../includes/header.jsp"%>


<section class="wrapper style1">
	<div class="inner">
		<div class="index align-left">

			<section>
				<header class="list">
					<h3>Reserve List</h3>
				</header>
				<div class="content">
					<div class="table-wrapper">
						<table>
							<thead>
								<tr>
									<th>No</th>
									<th colspan="2">Rooftop Name</th>
									<th>Id</th>
									<th>Reservedate</th>
									<th>Start Time</th>
									<th>End Time</th>
									<th>Regdate</th>
								</tr>
							</thead>
							<tbody>

								<c:forEach items="${reserveList}" var="reserveVO">
									<tr data-rno="${reserveVO.rno}" class="rowData"
										data-state="false" data-msg="${reserveVO.message}">
										<td>${reserveVO.rno}</td>
										<td colspan="2">${reserveVO.rooftopVO.rtname}</td>
										<td>${reserveVO.id}</td>
										<td>${reserveVO.reservedate}</td>
										<td><fmt:formatDate value="${reserveVO.startTime}"
												pattern="HH:mm" /></td>
										<td><fmt:formatDate value="${reserveVO.endTime}"
												pattern="HH:mm" /></td>
										<td><fmt:formatDate value="${reserveVO.regdate}"
												pattern="yyyy-MM-dd HH:mm" /></td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</div>
				</div>
			</section>

		</div>
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
			<div class="7u 12u$(xsmall)">
				<input type="text" name="keyword" placeholder="Input Keyword"
					value="${pm.cri.keyword ne null ? pm.cri.keyword : '' }">
			</div>

			<div class="2u 12u$(xsmall)">
				<ul class="actions">
					<li><button class="button special icon fa-search">Search</button></li>
				</ul>
			</div>
		</div>
	</form>
</section>
</div>
</div>
<%@include file="../includes/footer.jsp"%>


<script id="template" type="text/x-handlebars-template">
<tr class='loadArticle' rowspan='2'>
	<td colspan='8'>
		└> 
	{{#if .}}
		Articles : 
		{{#each .}}
			{{aname}}  {{this.serials.length}}개
		{{/each}}
	{{else}}
           Articles was not reserved.
	{{/if}}
	</td>

</tr>
{{#if this.msg}}
<tr class='loadArticle'>
	<td colspan='8'>
		└> Message : {{this.msg}}
	</td>
</tr>
{{/if}}
<input class='loadArticle' type='hidden'/>



</script>
<script>
	var rowData = $(".rowData");
	var template = Handlebars.compile($("#template").html());
	var statement = "";

	rowData.click(function(event) {
		var selectedData = $(this);
		var rno = selectedData.data("rno");
		var state = selectedData.data("state");
		var msg = selectedData.data("msg");
		console.log(statement);
		console.log($(".loadArticle"));
		$(".loadArticle").remove();
		if (statement != rno) {
			console.log("if in! ==" + statement);
			selectAjax(rno, selectedData, msg);
			statement = rno;
		} else {
			statement = "";
		}

	});
	function selectAjax(rno, selectedData, msg) {
		$.ajax({
			url : '/ajax/reserveArticleData?rno=' + rno,
			type : 'get',
			dataType : 'text',
			processData : false,
			contentType : "application/json;charset=UTF-8",
			success : function(articleVOList) {
				var obj = JSON.parse(articleVOList);
				console.dir($(obj));
				obj.msg = msg;
				console.dir(obj);
				var html = template(obj);
				selectedData.after(html);
			}
		});
	};
</script>
