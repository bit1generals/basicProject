<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="../includes/header.jsp"%>

<section>
	<header class="major">
		<h2>Modify</h2>
	</header>

	<form method="post" class="inputForm">
		<div class="row uniform">
			<div class="9u 12u$(xsmall)">
				<input type="text" name="title" value='<c:out value="${boardVO.title}"/>'>
			</div>

			<div class="3u 12u$(xsmall)">
				<input type="text" name="id" value="<c:out value="${boardVO.id}"/>" readonly="readonly">
			</div>

			<input type="hidden" name="bno" value="${boardVO.bno}">
			<input type="hidden" name="btype" value="F">

			<div class="fileAttach" data-show="false">
				<ul class="actions">
					<li><a class="button icon fa-download">File Attach</a></li>
				</ul>
			</div>

			<div class="12u$">
			<div class="fileDrop">
				<div class="fileZone">
					<ul class="uploadFile">
						<c:forEach items="${boardVO.files}" var="fileVO">

							<div class="fileWrapper">
								<div class="fileContent">
									<div class="fileHeader">X</div>
									<c:choose>
										<c:when test="${fileVO.ftype == 'Y'}">
											<li class="img" data-fname="${fileVO.fname}"
												data-uuid="${fileVO.uuid}" data-path="${fileVO.path}"
												data-ftype="${fileVO.ftype}"><img
												src="${fileVO.urlBuilder()}/thumbnails">
										</c:when>

										<c:when test="${fileVO.ftype == 'N'}">
											<li data-fname="${fileVO.fname}"
												data-uuid="${fileVO.uuid}" data-path="${fileVO.path}"
												data-ftype="${fileVO.ftype}">
												<a href="${fileVO.urlBuilder()}"> <img
													src="/resources/img/default.png"></a>
										</c:when>
									</c:choose>
									</li>
								<div class="fileFooter">${fileVO.fname}</div>
								</div>
							</div>
						</c:forEach>

					</ul>
				</div>
			</div>
		</div>

			<div class="12u$">
				<textarea name="content" rows="12"><c:out value="${boardVO.content}"/></textarea>
			</div>

			<div class="12u$">
				<ul class="actions">
					<li><input type="submit" value="Modify" class="special" /></li>
					<li><input type="reset" value="Reset" /></li>
				</ul>
			</div>
		</div>
	</form>
</section>
</div>
</div>









<%@include file="../includes/footer.jsp"%>
<script id="template" type="text/x-handlebars-template">
<div class = "fileWrapper">
	<div class="fileHeader">X</div>
	<div class="fileContent">
		<li data-fname="{{fname}}" data-uuid="{{uuid}}" data-path="{{path}}" data-ftype="{{ftype}}">
  			<span><img src="{{imgsrc}}" alt="Attachment"></span>
		<div class="fileFooter">{{fname}}</div>
		</li>
	</div>    
</div>
</script>

<script>
	var template = Handlebars.compile($("#template").html());
	var fileDrop = $(".fileDrop");
	var fileAttach = $(".fileAttach");
	var uploadFile = $(".uploadFile");

	fileDrop.on("dragenter dragover", function(event) {
		event.preventDefault();
		$(this).css('border', '2px solid rgb(246,131,131)').css('background',
				'rgba(252, 218, 218, 0.7)');
	});
	fileDrop.on("drop dragleave", function(event) {
		$(this).css('border', '2px dotted rgb(246,131,131)').css('background',
				'rgba(252, 218, 218, 0.3)');
	});

	fileDrop.on("drop", function(event) {
		console.log("drop event");

		event.preventDefault();

		var files = event.originalEvent.dataTransfer.files;

		console.dir(files);
		var formData = new FormData();

		for (var i = 0; i < files.length; i++) {
			formData.append("files", files[i]);
		}

		$.ajax({
			url : '/file/upload',
			method : 'post',
			data : formData,
			dataType : 'json',
			processData : false,
			contentType : false,
			success : function(dataVOList) {
				console.log("file upload success");
				console.dir(dataVOList[0]);
				dataVOList.forEach(function(data) {
					makeFileInfo(data);
					var html = template(data);

					$(".uploadFile").append(html);
				});
			}
		});
	});

	/* 	$(".wrapper").on("drop dragover", function(event) {
			console.log("wrapper dragover event");
			event.preventDefault();
			fname, uuid, ftype, path
		}); */

	function makeFileInfo(data) {
		console.dir(data);
		var imgsrc;
		if (data.ftype === "Y") {
			imgsrc = "/file/show?fname=" + data.fname + "&uuid=" + data.uuid
					+ "&ftype=" + data.ftype + "&path=" + data.path
					+ "/thumbnails";
		} else {
			imgsrc = "/resources/img/default.png";
		}
		data.imgsrc = imgsrc;

	};

	$(".inputForm").submit(
			function(event) {
				event.preventDefault();
				var form = $(this);
				var html = "";

				$(".uploadFile li").each(
						function(i, data) {
							var file = $(data);
							html += "<input type='hidden' name='files[" + i
									+ "].fname' value='" + file.data("fname")
									+ "'>";
							html += "<input type='hidden' name='files[" + i
									+ "].uuid' value='" + file.data("uuid")
									+ "'>";
							html += "<input type='hidden' name='files[" + i
									+ "].path' value='" + file.data("path")
									+ "'>";
							html += "<input type='hidden' name='files[" + i
									+ "].ftype' value='" + file.data("ftype")
									+ "'>";
						});

				form.append(html).get(0).submit();
			});

	fileAttach.on("click", "a", function(event) {

		if (fileAttach.data("show") == true) {
			fileDrop.hide();
			fileAttach.data("show", false);
		} else {
			fileDrop.show();
			fileAttach.data("show", true);
		}
	});

	uploadFile.on("click", ".fileHeader", function(e) {
		console.log("X click");
		this.parentNode.remove();
	});
	
	$(document).ready(function(){
		if(${boardVO.files[0].fno != null}){
			$(".fileDrop").show();
			fileAttach.data("show", true);
		}
	});
</script>

</body>
</html>