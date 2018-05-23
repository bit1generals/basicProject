<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@include file="../includes/header.jsp"%>

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

label {
	text-decoration: none;
	color: #7f888f;
	display: inline-block;
	font-size: 1em;
	font-weight: 400;
	padding-left: 2.4em;
	padding-right: 0.75em;
	position: relative;
}

.uniform {
	
}

.fileDrop {
	border: 2px dotted rgb(246, 131, 131);
	border-radius: 15px;
	height: 150px;
	color: #92AAB0;
	font-size: 24px;
	background: rgba(252, 218, 218, 0.3);
	font-size: 24px;
}

.uploadFile {
	display: inline-flex;
	list-style: none;
	margin: 0;
}

.fileHeader {
	position: absolute;
	color: rgb(246, 131, 131);
	cursor: pointer;
}

.fileWrapper {
	padding: 10px;
	margin: 10px;
	height: 120px;
	width: 140px;
}

.fileFooter {
	font-size: 12px;
}
</style>

<section>
	<header class="major">
		<h2>View</h2>
	</header>

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


		<div class="12u$">
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
			<ul class="actions" data-bno="${boardVO.bno}">
			
				<li><button class="special update">Update</button></li> 
				<li><button class="delete">Delete</button></li>
				<li><button class="special list">List</button></li>
				
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
	$(".fileContent")
			.on(
					"click",
					".img",
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

	$(".originImgWrapper").on("click", function(event) {
		$(".originImg").animate({
			width : '0%',
			height : '0%'
		}, 1000);
		setTimeout(function() {
			$('.originImgWrapper').hide();
		}, 1000);
	});
	
	$(".actions li").click(function(event){
		
		console.dir(this);
	});
</script>

</body>
</html>

<%@include file="../includes/footer.jsp"%>