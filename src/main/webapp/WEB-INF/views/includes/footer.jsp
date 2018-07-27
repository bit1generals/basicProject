<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags"
	prefix="sec"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<!-- Sidebar -->
<div id="sidebar">
	<div class="inner">


		<!-- Search -->
		<section id="search" class="alt">
		<form method="post" action="#">
			<input type="text" name="query" id="query" placeholder="Search" />
		</form>
		</section>

		<!-- Section -->

		<sec:authorize access="isAuthenticated()">
			<div class="row uniform">
				<div class="12u$">
					<h3>
						<sec:authentication property="principal.username" />
						님 환영합니다.
					</h3>
				</div>
				<div class="12u$">
					<form action="/member/logout" method="post">
						<input type="hidden" name="${_csrf.parameterName }"
							value="${_csrf.token }">
						<button>Logout</button>
						<a class="button" href="/member/myPage">MyPage</a>
					</form>
				</div>
			</div>




		</sec:authorize>

		<sec:authorize access="isAnonymous()">
			<section> <header class="major">
			<h2>Login</h2>
			</header>
			<div class="mini-posts"></div>
			<form id="loginForm" action="/login" method="post">
				<div class="row uniform">
					<div class="12u$">
						<label>ID</label> <input type="hidden"
							name="${_csrf.parameterName }" value="${_csrf.token }"> <input
							type="text" name="username" id="id" placeholder="Input ID">
					</div>
					<div class="12u$">
						<label>PASSWORD</label><input type="password" name="password"
							id="pw" placeholder="Password">
					</div>
					<div class="12u$">
						<input type="checkbox" id="rememberMe" name="remember-me">
						<label for="rememberMe">Remember Me</label>
						<ul class="actions">
							<li><input type="submit" value="Login"></li>
							<li><a href="/member/join" class="button">Join</a></li>
						</ul>
					</div>
				</div>
			</form>
			</section>
		</sec:authorize>
		<!-- Menu -->
		<nav id="menu"> <header class="major">
		<h2>Menu</h2>
		</header>
		<ul>
			<li><a href="/">Homepage</a></li>
			<li><a href="/bbs/list">Free Board</a></li>
			<li><a href="/stage/list">Stage List</a></li>
			<li><a href="/busking/list">Busking List</a></li>



			<li><span class="opener">Live Streaming</span>
				<ul>
					<li><a href="https://rtctest-bit.herokuapp.com/video#1"
						target="_blank">View</a></li>
					<sec:authorize access="isAuthenticated()">
						<li>
							<form target="_blank"
								action="https://rtctest-bit.herokuapp.com/video#1" method="post" id="streamForm">
								<input type="hidden" name="id"
									value="<sec:authentication property='principal.username'/>">
								<a id="startStream">Streaming</a>
							</form>
						</li>
					</sec:authorize>
				</ul> <sec:authorize access="hasRole('ROLE_ADMIN')">
					<li><a href="/reserve/list">Reserved List</a></li>
				</sec:authorize>
		</ul>

		</nav>
		<!-- Section -->
		<section> <header class="major">
		<h2>Feed Back</h2>
		</header>
		<ul class="contact">
			<li class="fa-envelope-o"><a href="#">nelldkLee@gmail.com</a></li>
			<li class="fa-envelope-o"><a href="#">wjdrnsl@gmail.com</a></li>
			<li class="fa-envelope-o"><a href="#">jish2689@gmail.com</a></li>
			<li class="fa-phone">02-772-1481</li>
			<li class="fa-home">서울특별시 종로구 종로 69 YMCA빌딩 7층<br /></li>
		</ul>
		</section>

		<!-- Footer -->
		<footer id="footer">
		<p class="copyright">&copy; Untitled. All rights reserved.</p>
		</footer>

	</div>
</div>

</div>

<!-- Scripts -->
<script src="/resources/assets/js/jquery.min.js"></script>
<script src="/resources/assets/js/jquery.nice-select.js"></script>
<script src="/resources/assets/js/skel.min.js"></script>
<script src="/resources/assets/js/util.js"></script>
<!--[if lte IE 8]><script src="assets/js/ie/respond.min.js"></script><![endif]-->
<script src="/resources/assets/js/main.js"></script>
<script src="/resources/assets/js/jquery-ui.min.js"></script>
<script type="text/javascript"
	src="//dapi.kakao.com/v2/maps/sdk.js?appkey=2986010b12d8334b24509c1d77fe5837&libraries=services"></script>
<script src="/resources/assets/js/moment.js"></script>
<script src="/resources/assets/js/handlebars.js"></script>
<script src="/resources/assets/js/datepicker.min.js"></script>
<script src="/resources/assets/js/datepicker.en.js"></script>

<script>
$("#startStream").click(function(){
	$("#streamForm").submit();
});

if(${msg ne null}){
	swal("${msg}");
}
</script>
</body>
</html>