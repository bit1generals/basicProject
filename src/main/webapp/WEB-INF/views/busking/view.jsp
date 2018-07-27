<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="../includes/header.jsp"%>

<section>
	<header class="major">
		<h2>Busking View</h2>
	</header>
	<form id="searchForm">
		<input type="hidden" name="key" value="${BuskingVO.bkno}"> <input
			type="hidden" name="page" value="${cri.page}">
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
				value='<c:out value="${buskingVO.boardVO.title}"/>' disabled>

		</div>

		<div class="3u 12u$(xsmall)">
			<input type="text" name="id"
				value='<c:out value="${buskingVO.boardVO.id}"/>' disabled>
		</div>

		<div class="9u 12u$(xsmall)">
			<label>Stage Name</label>
		</div>
		<div class="3u 12u$(xsmall)">
			<label>RegDate</label>
		</div>

		<div class="9u 12u$(xsmall)">
			<input type="text" name="rtname"
				value="${buskingVO.reserveVO.stageVO.rtname}" disabled>
		</div>

		<div class="3u 12u$(xsmall)">
			<input type="text" name="maximum"
				value='<fmt:formatDate value="${buskingVO.boardVO.regdate}" type="both"/>'
				disabled>
		</div>

		<div class="3u 12u$(xsmall)">
			<label>Busking Date</label>
		</div>
		<div class="3u 12u$(xsmall)">
			<label>Start Time</label>
		</div>

		<div class="3u 12u$(xsmall)">
			<label>End Time</label>
		</div>
		<div class="3u 12u$(xsmall)">
			<label><br></label>
		</div>

		<div class="3u 12u$(xsmall)">
			<input type="text" class="openCloseDate" name="opendate"
				value="${buskingVO.reserveVO.reservedate}" disabled />
		</div>

		<div class="3u 12u$(xsmall)">
			<input type="text" class="startTime"
				value='<fmt:formatDate value="${buskingVO.reserveVO.startTime}" type="time" pattern="HH:00"/>'
				disabled />
		</div>

		<div class="3u 12u$(xsmall)">
			<input type="text" name="endTime"
				value='<fmt:formatDate value="${buskingVO.reserveVO.endTime}" type="time" pattern="HH:00"/>'
				disabled />
		</div>

		<div class="3u 12u$(xsmall)">
			<button class="favorite">즐겨찾기</button>
		</div>

		<div class="10u 12u$(xsmall)">
			<label>Address</label>
		</div>

		<div class="12u$">
			<input type="text" name="address"
				value="${buskingVO.reserveVO.stageVO.address}" disabled>
		</div>

		<div class="12u$">
			<div id="map" style="width: 100%; height: 350px;"></div>
		</div>

		<div class="12u$ onCheck">
			<div class="fileDrop">
				<div class="fileZone">
					<ul class="uploadFile">

						<c:forEach items="${buskingVO.boardVO.files}" var="fileVO">
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
					value="${buskingVO.boardVO.content}" /></textarea>
		</div>

		<div class="12u$">
			<ul class="actions">
				<sec:authentication property="principal" var="user" />
				<c:if test="${buskingVO.boardVO.id eq user.username}">
					<li><button class="modify special" data-uri="modify"
							data-method="get">Modify</button></li>
					<li><button class="remove" data-uri="remove"
							data-method="post">Remove</button></li>
				</c:if>
				<li><button class="list special" data-uri="list"
						data-method="get">List</button></li>
				<c:if test="${buskingVO.reserveVO.stageVO.state eq 'N'}">
					<sec:authorize access="hasRole('ROLE_ADMIN')">
						<li><button class="authorize" data-uri="authorize"
								data-method="post">Authorize</button></li>
					</sec:authorize>
				</c:if>
				<c:if test="${buskingVO.reserveVO.stageVO.state eq 'Y'}">
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
var favorite = $(".favorite");
	var formObj = $("#searchForm");

	favorite.click(function(){
		favorite.attr("class", "special");
		swal("즐겨찾기에 추가되었습니다.");
	});
	
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

			if(that.data("method")=="post"){
				formObj.append("<input type='hidden' name='${_csrf.parameterName }' value='${_csrf.token }'>");
			}
			
			formObj.attr("action", that.data("uri")).attr("method",
					that.data("method")).submit();
	});
	
	$(document).ready(function(){
		if(${stageVO.boardVO.files[0].fno != null}){
			$(".fileDrop").show();
		}else{
			$(".onCheck").remove();
		}
		showMap();
	});
	
	function showMap(){
		console.log("showMap check");
		var mapContainer = document.getElementById('map'),mapOption = {
			center : new daum.maps.LatLng(${buskingVO.reserveVO.stageVO.lat},${buskingVO.reserveVO.stageVO.lng}),
			level : 3
		};
		var map = new daum.maps.Map(mapContainer, mapOption);
						
		var coords = new daum.maps.LatLng(${buskingVO.reserveVO.stageVO.lat},${buskingVO.reserveVO.stageVO.lng});

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
					content : '<div style="width:150px;text-align:center;padding:6px 0;">${buskingVO.reserveVO.stageVO.rtname}</div>'
				});
		infoWindow.open(map, marker);
		map.setCenter(coords);

	};
	
</script>
