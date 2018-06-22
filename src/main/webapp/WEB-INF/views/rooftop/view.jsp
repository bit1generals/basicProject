<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="../includes/header.jsp"%>

<section>
	<header class="major">
		<h2>Rooftop View</h2>
	</header>

	<form id="searchForm">
		<input type="hidden" name="key" value="${rooftopVO.boardVO.bno}">
		<input type="hidden" name="page" value="${cri.page}">
		<c:if test="${param.state != null }">
			<input type="hidden" name="state" value="${param.state}">
		</c:if>
		<c:if test="${cri.type != null }">
			<input type="hidden" name="keyword" value="${cri.keyword }">
			<input type="hidden" name="type" value="${cri.type}">
		</c:if>
	</form>

	<div class="row uniform">
		<div class="9u 12u$(xsmall)">
			<label>Title</label>
		</div>
		<div class="3u 12u$(xsmall)">
			<label>ID</label>
		</div>

		<div class="9u 12u$(xsmall)">
			<input type="text" name="title"
				value='<c:out value="${rooftopVO.boardVO.title}"/>' disabled>
		</div>

		<div class="3u 12u$(xsmall)">
			<input type="text" name="id"
				value='<c:out value="${rooftopVO.boardVO.id}"/>' disabled>
		</div>

		<div class="9u 12u$(xsmall)">
			<label>Rooftop Name</label>
		</div>
		<div class="3u 12u$(xsmall)">
			<label>Maximum</label>
		</div>

		<div class="9u 12u$(xsmall)">
			<input type="text" name="rtname" value="${rooftopVO.rtname}" disabled>
		</div>

		<div class="3u 12u$(xsmall)">
			<input type="text" name="maximum" value="${rooftopVO.maximum}"
				disabled>
		</div>

		<div class="6u 12u$(xsmall)">
			<label>RegDate</label>
		</div>
		<div class="6u 12u$(xsmall)">
			<label>UpdateDate</label>
		</div>

		<div class="6u 12u$(xsmall)">
			<input type="text"
				value='<fmt:formatDate value="${rooftopVO.boardVO.regdate}" type="both"/>'
				disabled>
		</div>
		<div class="6u 12u$(xsmall)">
			<input type="text" name="updatedate"
				value='<fmt:formatDate value="${rooftopVO.boardVO.updatedate}" type="both"/>'
				disabled>
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
			<input type="text" class="openCloseDate" name="opendate"
				value='<fmt:formatDate value="${rooftopVO.opendate}" type="date"/>'
				disabled />
		</div>

		<div class="3u 12u$(xsmall)">
			<input type="text" class="openCloseDate" name="closedate"
				value='<fmt:formatDate value="${rooftopVO.closedate}" type="date"/>'
				disabled />
		</div>

		<div class="3u 12u$(xsmall)">
			<input type="text" name="openTime" value="${rooftopVO.openTime}"
				disabled />
		</div>
		<div class="3u 12u$(xsmall)">
			<input type="text" name="closeTime" value="${rooftopVO.closeTime}"
				disabled />
		</div>

		<div class="10u 12u$(xsmall)">
			<label>Address</label>
		</div>

		<div class="12u$">
			<input type="text" name="address" value="${rooftopVO.address}"
				disabled>
		</div>

		<div class="12u$">
			<div id="map" style="width: 100%; height: 350px;"></div>
		</div>

		<div class="12u$ onCheck">
			<div class="fileDrop">
				<div class="fileZone">
					<ul class="uploadFile">

						<c:forEach items="${rooftopVO.boardVO.files}" var="fileVO">
							<div class="fileWrapper">
								<div class="fileContent">
									<c:choose>
										<c:when test="${fileVO.ftype == 'Y'}">
											<li class="img" data-fname="${fileVO.fname}"
												data-uuid="${fileVO.uuid}" data-path="${fileVO.path}"
												data-ftype="${fileVO.ftype}"><img
												src="${fileVO.urlBuilder()}/thumbnails">
										</c:when>

										<c:when test="${fileVO.ftype == 'N'}">
											<li><a href="${fileVO.urlBuilder()}"> <img
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
				disabled="disabled"><c:out
					value="${rooftopVO.boardVO.content}" /></textarea>
		</div>

		<div class="12u$">
			<ul class="actions">

				<li><button class="modify special" data-uri="modify"
						data-method="get">Modify</button></li>
				<li><button class="remove" data-uri="remove" data-method="post">Remove</button></li>
				<li><button class="list special" data-uri="list"
						data-method="get">List</button></li>
				<c:if test="${cri.state eq 'N'}">
					<li><button class="authorize" data-uri="authorize"
							data-method="post">Authorize</button></li>
				</c:if>
				<c:if test="${cri.state eq 'Y'}">
					<li><button class="reserve special"
							data-uri="/reserve/register" data-method="get">Reservation</button></li>
				</c:if>
			</ul>
		</div>
	</div>

	<div class="originImgWrapper">
		<div class="originImg"></div>
	</div>
</section>
</div>
</div>

<%@include file="../includes/footer.jsp"%>
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

	$(".actions li").click(function(event) {
		
				var that = $(event.target);
				formObj.attr("action", that.data("uri")).attr("method",
						that.data("method")).submit();
	});
	
	$(document).ready(function(){
		if(${rooftopVO.boardVO.files[0].fno != null}){
			$(".fileDrop").show();
		}else{
			$(".onCheck").remove();
		}
		showMap();
	});
	
	function showMap(){
		console.log("showMap check");
		var mapContainer = document.getElementById('map'),mapOption = {
			center : new daum.maps.LatLng(${rooftopVO.lat},${rooftopVO.lng}),
			level : 3
		};
		var map = new daum.maps.Map(mapContainer, mapOption);
						
		var coords = new daum.maps.LatLng(${rooftopVO.lat},${rooftopVO.lng});

		// 결과값으로 받은 위치를 마커로 표시합니다
		var marker = new daum.maps.Marker({
			map : map,
			position : coords
		});
		console.dir(map);
		console.log("--------------");
		console.dir(marker);
		console.dir(coords);
		// 인포윈도우로 장소에 대한 설명을 표시합니다
		var infoWindow = new daum.maps.InfoWindow(
				{
					content : '<div style="width:150px;text-align:center;padding:6px 0;">${rooftopVO.rtname}</div>'
				});
		infoWindow.open(map, marker);
		map.setCenter(coords);

	};
	
</script>
