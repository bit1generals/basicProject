<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@include file="../includes/header.jsp"%>
<section>
	<header class="major">
		<h2>View</h2>
	</header>

	<form id="searchForm">
		<input type="hidden" name="key" value="${boardVO.bno}">

	</form>

	<div class="row uniform">
		<div class="9u 12u$(xsmall)">


			<input type="text" name="title"
				value='<c:out value="${boardVO.title}"/>' readonly="readonly"
				disabled>
		</div>

		<div class="3u 12u$(xsmall)">
			<input type="text" name="id" value='<c:out value="${boardVO.id}"/>'
				readonly="readonly" disabled>
		</div>

		<div class="6u 12u$(xsmall)">
			<input type="text" style="text-align: center;"
				value='RegDate   :   <fmt:formatDate value="${boardVO.regdate}" type="both"/>'
				readonly="readonly" disabled>
		</div>
		<div class="6u 12u$(xsmall)">
			<input type="text" name="updatedate" style="text-align: center"
				value='UpdateDate   :   <fmt:formatDate value="${boardVO.updatedate}" type="both"/>'
				readonly="readonly" disabled>
		</div>


		<div class="12u$ onCheck">
			<div class="fileDrop">
				<div class="fileZone">
					<ul class="uploadFile">

						<c:forEach items="${boardVO.files}" var="fileVO">
							<div class="fileWrapper">
								<div class="fileContent">
									<c:choose>
										<c:when test="${fileVO.ftype == 'Y'}">
											<li class="img" data-fname="${fileVO.fname}"
												data-uuid="${fileVO.uuid}" data-path="${fileVO.path}"
												data-ftype="${fileVO.ftype}"><img
												src="/file/show${fileVO.urlBuilder()}/thumbnails">
										</c:when>

										<c:when test="${fileVO.ftype == 'N'}">
											<li><a href="/file/show${fileVO.urlBuilder()}"> <img
													src="/resources/img/default.png"></a>
										</c:when>
									</c:choose>
									</li>
								</div>
								<div class="fileFooter">${fileVO.fname}</div>
							</div>
						</c:forEach>

					</ul>
				</div>
			</div>
		</div>


		<div class="12u$">
			<textarea name="content" rows="12" style="resize: none"
				disabled="disabled"><c:out value="${boardVO.content}" /></textarea>
		</div>

		<div class="12u$">
			<ul class="actions">

				<li><button class="modify special" data-uri="modify"
						data-method="get">Modify</button></li>
				<li><button class="remove" data-uri="remove" data-method="post">Remove</button></li>
				<li><button class="list special" data-uri="list"
						data-method="get">List</button></li>

			</ul>
		</div>
	</div>

	<div class="originImgWrapper">
		<div class="originImg"></div>
	</div>
</section>
</div>
</div>


<script src="https://code.jquery.com/jquery-3.3.1.min.js"
	integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8="
	crossorigin="anonymous">
	
</script>


<script>
	var formObj = $("#searchForm");

	$(".fileContent .img")
			.click(
					function(event) {
						event.preventDefault();
						var target = $(this);

						var path = "fname=" + target.data("fname") + "&uuid="
								+ target.data("uuid") + "&ftype="
								+ target.data("ftype") + "&path="
								+ target.data("path");
						originShow(path);
					});

	function originShow(path) {
		$(".originImgWrapper").css("display", "flex").show();
		$(".originImg").html("<img src='/file/show?" + path + "'>").animate({
			width : '100%',
			height : '100%'
		}, 1000);
		console.dir(path);
	};

	$(".originImgWrapper").click(function(event) {
		$(".originImg").animate({
			width : '0%',
			height : '0%'
		}, 1000);
		setTimeout(function() {
			$('.originImgWrapper').hide();
		}, 1000);
	});

	$(".actions li").click(
			function(event) {
				var that = $(event.target);
				formObj.attr("action", that.data("uri")).attr("method",
						that.data("method")).submit();
			});
	
	$(document).ready(function(){
		if(${boardVO.files[0].fno != null}){
			$(".fileDrop").show();
		}else{
			$(".onCheck").remove();
		}
	});
</script>

</body>
</html>

<%@include file="../includes/footer.jsp"%>