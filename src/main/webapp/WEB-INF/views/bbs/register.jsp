<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="../includes/header.jsp"%>
<section>
	<header class="major">
		<h2>Register</h2>
	</header>
	<form method="post" class="inputForm">
		<div class="row uniform">
				
			<div class="9u 12u$(xsmall)">
				<input type="text" name="title" value="title test"
					placeholder="Input Title">
			</div>

			<div class="3u 12u$(xsmall)">
				<input type="text" name="id"
					value="<sec:authentication property='principal.username'/>"
					readonly="readonly">

			</div>
			<input type="hidden" name="btype" value="B"> <input
				type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">

			<div class="fileAttach" data-show="false">
				<ul class="actions">
					<li><a class="button icon fa-download">File Attach</a></li>
				</ul>
			</div>

			<div class="12u$">
				<div class="fileDrop">
					<div class="fileZone">
						<ul class="uploadFile">
						</ul>
					</div>
				</div>
			</div>


			<div class="12u$">
				<textarea name="content" placeholder="Enter your message" rows="12"></textarea>
			</div>

			<div class="12u$">
				<ul class="actions">
					<li><input type="submit" value="Register" class="special" /></li>
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
			headers : {
				"X-CSRF-TOKEN" : "${_csrf.token }"
			},
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
</script>

</body>
</html>