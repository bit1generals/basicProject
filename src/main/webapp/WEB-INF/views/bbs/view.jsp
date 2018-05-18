<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

	<style>
.originImgWrapper {
	position: absolute;
	display: none;
	justify-content: center;
	align-items: center;
	top: 0%;
	width: 100%;
	height: 100%;
	background-color: gray;
	z-index: 100;
	background: rgba(87, 97, 100, 0.7);
}

.originImg {
	position: relative;
	display: flex;
	justify-content: center;
	align-items: center;
}
</style>
	<h1>Bbs View Page</h1>

	${boardVO}

	<div class="wrapper">
		<div></div>
		<div class="content">
			<ul>
				<c:forEach items="${boardVO.files}" var="fileVO">

					<c:out value="${fileVO.fname}"></c:out>
					<c:choose>
						<c:when test="${fileVO.ftype == 'Y'}">
							<li data-fname="${fileVO.fname}" data-uuid="${fileVO.uuid}"
								data-path="${fileVO.path}" data-ftype="${fileVO.ftype}"><img
								src="/file/show${fileVO.urlBuilder()}/thumbnails"></a></li>
						</c:when>

						<c:when test="${fileVO.ftype == 'N'}">
							<a href="/file/show${fileVO.urlBuilder()}"> <img
								src="/resources/img/default.png"></a>

						</c:when>

					</c:choose>

				</c:forEach>
			</ul>
		</div>
	</div>

	<div class="originImgWrapper">
		<div class="originImg"></div>
	</div>


	<script src="https://code.jquery.com/jquery-3.3.1.min.js"
		integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8="
		crossorigin="anonymous">
		
	</script>
	<script>
		$(".content").on(
				"click",
				"li",
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
			$(".originImg").html("<img src='/file/show?" + path + "'>")
					.animate({
						width : '100%',
						height : '100%'
					}, 1000);
			console.dir(path);
		};
		
		$(".originImgWrapper").on("click", function(event) {
			$(".originImg").animate({
				width : '0%',
				height : '0%'
			}, 1000);
			setTimeout(function(){
			      $('.originImgWrapper').hide();
			    }, 1000);
		});
	</script>

</body>
</html>