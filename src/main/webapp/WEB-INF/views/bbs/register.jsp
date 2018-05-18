<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<style>
.header {
	width: 100%;
	height: 150px;
	background-color: blue;
}

.content {
	width: 100%;
	height: 500px;
}

.content .fileZone {
	width: 100%;
	height: 150px;
}

.footer {
	width: 100%;
	height: 100px;
	background-color: red;
}

.fileDrop {
	border: 2px dotted #3292A2;
	width: 90%;
	height: 50px;
	color: #92AAB0;
	text-align: center;
	font-size: 24px;
	padding-top: 12px;
	margin-top: 10px;
}
</style>

	<div class="wrapper">
		<h1>Bbs Register Page</h1>

		<div class="header"></div>
		<div class="content">
			<form method="post" class="inputForm" action="">
			<input type="text" name="title" value="title test">
			<input type="text" name="content" value="content test">
			<input type="text" name="id" value="user0">
			<input type="text" name="btype" value="F"> 
			
				<div class="fileDrop"></div>
				<div class="fileZone">
					<ul class="uploadFile">
					</ul>
				</div>
				<button>Submit</button>
			</form>
		</div>
		<div class="footer"></div>
	</div>


	<script src="https://code.jquery.com/jquery-3.3.1.min.js"
		integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8="
		crossorigin="anonymous">
		
	</script>

	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/3.0.1/handlebars.js"></script>

	<script id="template" type="text/x-handlebars-template">
<li data-fname="{{fname}}" data-uuid="{{uuid}}" data-path="{{path}}" data-ftype="{{ftype}}">
  <span><img src="{{imgsrc}}" alt="Attachment"></span>
</li>    
	</script>

	<script>
		var template = Handlebars.compile($("#template").html());
		var fileDrop = $(".fileDrop");

		fileDrop.on("dragenter dragover", function(event) {
			event.preventDefault();
			$(this).css('border', '2px solid #5272A0');
		});
		/* fileDrop.on("drop dragleave", function(event) {
			$(this).css('border', '2px dotted #3292A2');
		}); */

		fileDrop.on("drop", function(event) {
			console.log("drop event");

			event.preventDefault();

			console.dir(event);

			console.dir(event.originalEvent);

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
				imgsrc = "/file/show?fname=" + data.fname + "&uuid="
						+ data.uuid + "&ftype=" + data.ftype + "&path="
						+ data.path + "/thumbnails";
			} else {
				imgsrc = "/resources/img/default.png";
			}
			data.imgsrc = imgsrc;

		};
		
		$(".inputForm").submit(function(event) {
			event.preventDefault();
			var form = $(this);
			var html = "";
			
			$(".uploadFile li").each(function(i, data) {
				var file = $(data);
				html += "<input type='hidden' name='files["+i+"].fname' value='"+file.data("fname")+"'>";
				html += "<input type='hidden' name='files["+i+"].uuid' value='"+file.data("uuid")+"'>";
				html += "<input type='hidden' name='files["+i+"].path' value='"+file.data("path")+"'>";
				html += "<input type='hidden' name='files["+i+"].ftype' value='"+file.data("ftype")+"'>";
			});
	
			form.append(html).get(0).submit();
		});
	</script>

</body>
</html>