<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page session="false"%>
<%@include file="./includes/header.jsp"%>
<%@include file="./includes/banner.jsp"%>

<section>
	<div class="12u$">
		<div id="map" style="width: 100%; height: 350px;"></div>
		<br>
	</div>
</section>
<section>
	<header class="major">
		<h2>Busking System</h2>
	</header>
	<div class="features">
		<article>
			<span class="icon"><img src="/resources/images/busking.png"
				style="margin-left: -9px; width: 80px; height: 80px; margin-top: 27px;"></span>
			<div class="content">
				<h3>Busking Place</h3>
				<p>버스킹 장소를 안내합니다.</p>
			</div>

		</article>
		<article>
			<span class="icon"><img src="/resources/images/microphone.png"
				style="width: 70px; height: 70px; margin-top: 31px;"></span>
			<div class="content">
				<h3>Busking Article Reservation</h3>
				<p>버스킹에 관한 장비를 대여해줍니다.</p>
			</div>
		</article>
		<article>
			<span class="icon"><img src="/resources/images/movie.png"
				style="width: 50px; height: 50px; margin-top: 41px;"></span>
			<div class="content">
				<h3>Live Show Busking</h3>
				<p>Live로 Busking을 실시간으로 제공합니다.</p>
			</div>
		</article>
		<article>
			<span class="icon"> <img src="/resources/images/network.png"
				style="width: 70px; height: 70px; margin-top: 30px;"></span>
			<div class="content">
				<h3>Who You Are</h3>
				<p>누구나 공연에 참여 및 제공 할 수 있습니다.</p>
			</div>
		</article>
	</div>
</section>

</div>
</div>


<%@include file="./includes/footer.jsp"%>
<script>
	var markers = [];

	$(document).ready(function() {
		console.log("document ");
		initMarkers();
	});

	function initMarkers() {
		var stageVOList = new Array();

		<c:forEach items="${stageVO}" var="stage">
		var obj = {
			"lat" : "${stage.lat}",
			"lng" : "${stage.lng}",
			"rtname" : "${stage.rtname}"
		};
		stageVOList.push(obj);
		</c:forEach>

		showMap(stageVOList);

		console.dir(stageVOList);
	};

	function showMap(stageVOList) {
		console.log("showMap check");
		var mapContainer = document.getElementById('map'), mapOption = {
			center : new daum.maps.LatLng(37.570834, 126.985249),
			level : 3
		};
		var map = new daum.maps.Map(mapContainer, mapOption);

		var coords = new daum.maps.LatLng(37.570834, 126.985249);
		var imageSize = new daum.maps.Size(40, 45);
		var imageSrc = "/resources/images/location-pointer.png";
		var markerImage = new daum.maps.MarkerImage(imageSrc, imageSize);

		// 결과값으로 받은 위치를 마커로 표시합니다
		var marker = new daum.maps.Marker({
			map : map,
			position : coords,
			image : markerImage
		});
		console.dir(map);
		console.log("--------------");
		console.dir(marker);
		console.dir(coords);
		// 인포윈도우로 장소에 대한 설명을 표시합니다
		var infoWindow = new daum.maps.InfoWindow(
				{
					content : '<div style="width:150px;text-align:center;padding:6px 0;">현재위치</div>'
				});
		infoWindow.open(map, marker);
		map.setCenter(coords);
		// 여기까지 현재 위치, map 찍기

		stageVOList
				.forEach(function(target, idx) {
					// 마커 이미지를 생성합니다    
					var imageSize = new daum.maps.Size(24, 35);
					var imageSrc = "http://t1.daumcdn.net/localimg/localimages/07/mapapidoc/markerStar.png";
					var markerImage = new daum.maps.MarkerImage(imageSrc,
							imageSize);

					var coords = new daum.maps.LatLng(target.lat, target.lng);
					var marker = new daum.maps.Marker({
						map : map,
						position : coords,
						title : target.rtname,
						image : markerImage
					});

				});

	};
</script>