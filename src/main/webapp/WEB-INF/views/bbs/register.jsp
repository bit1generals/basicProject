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
			<div class="fileDrop"></div>
		</div>
		<div class="footer"></div>
	</div>


	<script src="https://code.jquery.com/jquery-3.3.1.min.js"
		integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8="
		crossorigin="anonymous"></script>

	<script>
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

			var files = event.originalEvent.dataTransfer.files;
	
			var formData = new FormData();

			for (var i = 0; i < files.length; i++) {
				formData.append("files", files[i]);
			}
			
			$.ajax({
				url : '/file/upload',
				method : 'post',
				data : formData,
				dataType : 'text',
				processData : false,
				contentType : false,
				success : function() {
					console.log("success");
					
				}
			});

		});

	/* 	$(".wrapper").on("drop dragover", function(event) {
			console.log("wrapper dragover event");
			event.preventDefault();
		}); */
	</script>

</body>
</html>