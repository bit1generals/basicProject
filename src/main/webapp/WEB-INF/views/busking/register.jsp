<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ include file="../includes/header.jsp"%>


<section>
	<header class="major">
		<h2>Show Your Busking</h2>
	</header>
	<form method="post" action="./register" class="inputForm">
		<div class="row uniform">

			<input type="hidden" name="${_csrf.parameterName }"
				value="${_csrf.token }"> <input type="hidden" name="id"
				value="<sec:authentication property='principal.username'/>"
				readonly="readonly">

			<div class="6u 12u$(xsmall)">
				<label>Reserved Name</label>
			</div>
			<div class="6u 12u$(xsmall)">
				<label>Reserved Date</label>
			</div>
			<div class="6u 12u$(xsmall) firstRow">
				<div class="select-wrapper">
					<select name="rno" id="stage" data-name="Stage">
						<option></option>
						<c:forEach items="${reserveVOList}" var="reserveVO">
							<c:if test="${reserveVO.state == 'Done'}">
								<option name="${reserveVO.stageVO.rtname}"
									value="${reserveVO.rno}" data-date="${reserveVO.reservedate}"
									data-starttime="${reserveVO.startTime}"
									data-endtime="${reserveVO.endTime}">
									${reserveVO.stageVO.rtname}</option>
							</c:if>
						</c:forEach>
					</select>
				</div>
			</div>

			<div class="6u 12u$(xsmall)">
				<div class="select-wrapper">
					<input type="text" id="reservedate" class="datepicker-here"
						name="reservedate" data-name="Date" autocomplete="off" disabled />

				</div>
			</div>

			<div class="6u 12u$(xsmall) secondRow">
				<label for="department">Start Time</label>
				<div class="select-wrapper">
					<input type="text" name="startTime" id="startTime"
						data-name="Start Time" disabled />
				</div>
			</div>

			<div class="6u 12u$(xsmall) secondRow">
				<label for="department">End Time</label>
				<div class="select-wrapper">
					<input type="text" name="endTime" id="endTime" data-name="End Time"
						disabled />
				</div>
			</div>

			<div class="fileAttach" data-show="false">
				<ul class="actions">
					<li><a class="button icon fa-download">Thumbnail Upload</a></li>
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

			<div class="12u$ fourthRow">
				<label for="department">Title</label> <input name="boardVO.title"
					type="text" />
			</div>

			<div class="12u$ fourthRow">
				<label for="message">Message</label>
				<textarea name="boardVO.content" id="content" rows="6"
					style="resize: none"></textarea>
			</div>

			<input type="hidden" name="boardVO.btype" value="BK">

			<ul class="actions">
				<li><input type="submit" class="action" value="Register"></li>
				<li><input type="reset" class="reset" value="Reset"></li>
				<li><input type="button" class="action" value="Cancel"></li>
				<li><input type="button" class="action" value="List"
					data-uri="list"></li>
			</ul>
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
	var reservedate = $("#reservedate");
	var startTime = $("#startTime");
	var endTime = $("#endTime");
	var firstRow = $(".firstRow");
	var secondRow = $(".secondRow");
	var action = $(".action")
	var template = Handlebars.compile($("#template").html());
	var fileDrop = $(".fileDrop");
	var fileAttach = $(".fileAttach");
	var uploadFile = $(".uploadFile");

	firstRow.change(function(event) {
		var that = $(".firstRow option:selected");
		reservedate.val(that.data("date"));
		startTime.val(moment(that.data("starttime")).format('HH:mm'));
		endTime.val(moment(that.data("endtime")).format('HH:mm'));
	});

	action.click(function(event) {
		if ($(this).val() != 'Register') {
			history.back();
		}
	});

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
		var fileCheck = true;
		var files = event.originalEvent.dataTransfer.files;
		var formData = new FormData();

		for (var i = 0; i < files.length; i++) {
			var fileFormat = (files[i].name).split('.')[1];
			if (fileFormat != 'jpg' && fileFormat != 'jpeg' && fileFormat != 'gif') {
				console.log("not img ===")
				swal("jpg, jpeg, gif파일만 Upload 할 수 있습니다.");
				fileCheck = false;
				break;
			} else {
				formData.append("files", files[i]);
			}
		}
		if (fileCheck) {
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
		}
	});

	/* 	$(".wrapper").on("drop dragover", function(event) {
			console.log("wrapper dragover event");
			event.preventDefault();
			fname, uuid, ftype, path
		}); */

	function makeFileInfo(data) {
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

	$(".inputForm").submit( function(event) {
				event.preventDefault();
				var form = $(this);
				var html = "";

				$(".uploadFile li").each(
						function(i, data) {
							var file = $(data);
							html += "<input type='hidden' name='boardVO.files[" + i
									+ "].fname' value='" + file.data("fname")
									+ "'>";
							html += "<input type='hidden' name='boardVO.files[" + i
									+ "].uuid' value='" + file.data("uuid")
									+ "'>";
							html += "<input type='hidden' name='boardVO.files[" + i
									+ "].path' value='" + file.data("path")
									+ "'>";
							html += "<input type='hidden' name='boardVO.files[" + i
									+ "].ftype' value='" + file.data("ftype")
									+ "'>";
						});
				console.dir(form);
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