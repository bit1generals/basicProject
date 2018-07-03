<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="../includes/header.jsp"%>
<!-- <style>
* {
	font-family: 'Open Sans';
}
</style>
 -->
<section>
	<header class="major">
		<h2>Rooftop Register</h2>
	</header>

	<form id="searchForm">
		<input type="hidden" name="key" value="${rooftopVO.boardVO.bno}">
		<input type="hidden" name="page" value="${cri.page}"> <input
			type="hidden" name="state" value="${cri.state}">
		<c:if test="${cri.type != null }">
			<input type="hidden" name="keyword" value="${cri.keyword }">
			<input type="hidden" name="type" value="${cri.type}">
		</c:if>
	</form>

	<form method="post" class="inputForm">
		<div class="row uniform">
			<input type="hidden" name="boardVO.btype" value="R"> <input
				type="hidden" name="lat" value="" data-name="Rooftop Address">
			<input type="hidden" name="lng" value="" data-name="Rooftop Address"><input
				type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">

			<div class="9u 12u$(xsmall)">
				<label>Title</label>
			</div>
			<div class="3u 12u$(xsmall)">
				<label>ID</label>
			</div>
			<div class="9u 12u$(xsmall)">
				<input type="text" name="boardVO.title" value="title test"
					placeholder="Input Title" data-name="Title">
			</div>

			<div class="3u 12u$(xsmall)">
				<input type="text" name="boardVO.id"
					value="<sec:authentication property='principal.username'/>"
					readonly="readonly">
			</div>

			<div class="9u 12u$(xsmall)">
				<label>Rooftop Name</label>
			</div>
			<div class="3u 12u$(xsmall)">
				<label>Maximum</label>
			</div>

			<div class="9u 12u$(xsmall)">
				<input type="text" name="rtname" value="rooftop name"
					placeholder="Input Rooftop Name" data-name="Rooftop Name">
			</div>

			<div class="3u 12u$(xsmall)">
				<input type="text" name="maximum" value="10"
					placeholder="Input Maximum" data-name="Maximum People">
			</div>

			<div class="3u 12u$(xsmall)">
				<label>OpenDate</label>
			</div>
			<div class="3u 12u$(xsmall)">
				<label>CloseDate</label>
			</div>

			<div class="3u 12u$(xsmall)">
				<label>OpenTime</label>
			</div>
			<div class="3u 12u$(xsmall)">
				<label>CloseTime</label>
			</div>
			<div class="3u 12u$(xsmall)">
				 <input type="text" class="openCloseDate datepicker-here" name="opendate"
					autocomplete="off" data-name="OpenDate"
					placeholder="Input OpenDate"  /> 
			</div>


			<div class="3u 12u$(xsmall)">
				 <input type="text" class="openCloseDate datepicker-here" name="closedate"
					autocomplete="off" data-name="CloseDate"
					placeholder="Input CloseDate" > 
			</div>

			<div class="3u 12u$(xsmall)">
				 <select
					name="openTime" class="openTime" data-name="OpenTime">
					<c:forEach begin="0" end="23" var="num">
						<option value="${num}">${num}:00</option>
					</c:forEach>
				</select>
			</div>
			<div class="3u 12u$(xsmall)">
				<select name="closeTime" class="closeTime" data-name="CloseTime">
				</select>
			</div>

			<div class="10u 12u$(xsmall)">
				<label>Address</label>
			</div>
			<div class="10u 12u$(xsmall)">
				<input type="text" name="address" value="서울특별시 종로구 종로2가 9"
					id="address" placeholder="Input Address"
					data-name="Rooftop Address">
			</div>

			<div class="2u 12u$(xsmall)">
				<input type="button" value="Select" id="addressButton">
			</div>


			<div class="12u$">
				<div id="map" style="width: 100%; height: 350px;"></div>
			</div>


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
				<textarea name="boardVO.content" placeholder="Enter your message"
					rows="12" data-name="Content"></textarea>
			</div>

			<div class="12u$">
				<ul class="actions">
					<li><input type="submit" value="Register" class="special" /></li>
					<li><input type="reset" value="Reset" /></li>
					<li><input type="button" value="List" class="list special"
						data-uri="list"></li>
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
	var inputForm = $(".inputForm");
	var marker = new daum.maps.Marker;
	var infoWindow = new daum.maps.InfoWindow;
	var openCloseDate = $(".openCloseDate");
	var openTime = $(".openTime");
	var closeTime = $(".closeTime");



	$(".list").click(
			function(event) {
				event.preventDefault();
				var that = $(event.target);
				$("#searchForm").attr("action", that.data("uri")).attr(
						"method", that.data("method")).submit();
			});

	/* openCloseDate.datepicker({
		dateFormat : 'yy-mm-dd',
		minDate : 1
	}); */
	
	openCloseDate.datepicker({
	    language: 'en',
	    dateFormat : 'yy-mm-dd',
	    autoClose: true,
	    minDate: new Date() // Now can select only dates, which goes after today
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
		event.preventDefault();

		var files = event.originalEvent.dataTransfer.files;
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
				dataVOList.forEach(function(data) {
					makeFileInfo(data);
					var html = template(data);
					$(".uploadFile").append(html);
				});
			}
		});
	});

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

	inputForm.submit(function(event) {
		var form = $(this);
		var html = "";
		var submitAllow = false;

		inputForm.find("input, select, textarea").each(
				function(idx, target) {
					var inputData = $(target);
					if (!inputData.val()) {
						console.dir(inputData);
						swal("Oops!", "Please enter " + inputData.data("name"),
								"warning");
						event.preventDefault();
						return submitAllow;
					}
				});

		$(".uploadFile li").each(
				function(i, data) {
					var file = $(data);
					html += "<input type='hidden' name='boardVO.files[" + i
							+ "].fname' value='" + file.data("fname") + "'>";
					html += "<input type='hidden' name='boardVO.files[" + i
							+ "].uuid' value='" + file.data("uuid") + "'>";
					html += "<input type='hidden' name='boardVO.files[" + i
							+ "].path' value='" + file.data("path") + "'>";
					html += "<input type='hidden' name='boardVO.files[" + i
							+ "].ftype' value='" + file.data("ftype") + "'>";
				});
		inputForm.append(html);
		submitAllow = true;

		return submitAllow;
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

	var mapContainer = document.getElementById('map'),

	mapOption = {
		center : new daum.maps.LatLng(37.571275, 126.985499),
		level : 3
	};

	var map = new daum.maps.Map(mapContainer, mapOption);
	var geocoder = new daum.maps.services.Geocoder();

	$("#addressButton")
			.click(
					function(event) {
						marker.setMap(null);
						infoWindow.close();
						var address = $("#address").val();

						// 주소로 좌표를 검색합니다
						geocoder
								.addressSearch(
										address,
										function(result, status) {
											// 정상적으로 검색이 완료됐으면 
											if (status === daum.maps.services.Status.OK) {

												var coords = new daum.maps.LatLng(
														result[0].y,
														result[0].x);

												// 결과값으로 받은 위치를 마커로 표시합니다
												marker = new daum.maps.Marker({
													map : map,
													position : coords
												});
												// 인포윈도우로 장소에 대한 설명을 표시합니다
												infoWindow = new daum.maps.InfoWindow(
														{
															content : '<div style="width:150px;text-align:center;padding:6px 0;">My Rooftop</div>'
														});
												infoWindow.open(map, marker);
												// 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
												map.setCenter(coords);
												setPosition(result);
											}
										});
					});

	function setPosition(latlng) {
		inputForm.find("[name='lat']").val(latlng[0].y);
		inputForm.find("[name='lng']").val(latlng[0].x);
	};

	openTime.change(function(event) {

		makeCloseTime($(this).val());
	});

	function makeCloseTime(targetTime) {
		closeTime.empty();
		for (++targetTime; targetTime <= 24; targetTime++) {
			closeTime.append("<option value='"+targetTime+"'>" + targetTime
					+ ":00</option>");
		}
	};
</script>
