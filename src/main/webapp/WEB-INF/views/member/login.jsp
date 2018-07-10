<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="../includes/header.jsp"%>

<sec:authorize access="isAuthenticated()">
	<script>
		swal("You are already signed in.");
		self.location = "/";
	</script>
</sec:authorize>

<section>
	<c:if test="${param.error != null }">
		<script>
			swal("Sorry", "Please check your ID and password!", "warning");
		</script>
	</c:if>

	<header class="major">
		<h2>Login</h2>
	</header>

	<form id="searchForm">
		<input type="hidden" name="key" value="${stageVO.boardVO.bno}">
		<input type="hidden" name="page" value="${cri.page}">

		<c:if test="${param.state != null }">
			<input type="hidden" name="state" value="${param.state}">
		</c:if>
		<c:if test="${cri.type != null }">
			<input type="hidden" name="keyword" value="${cri.keyword }">
			<input type="hidden" name="type" value="${cri.type}">
		</c:if>
	</form>


	<div>
		<form id="loginForm" action="/login">
			<input type="hidden" name="${_csrf.parameterName }"
				value="${_csrf.token }">
			<div class="row uniform">
				<div class="4u 12u$(xsmall)"></div>
				<div class="4u 12u$(xsmall)">
					<label>ID</label>
				</div>
			</div>
			<div class="row uniform">
				<div class="4u 12u$(xsmall)"></div>
				<div class="4u 12u$(xsmall)">
					<input type="text" name="username" id="id" placeholder="Input ID"
						value="bbb" />
				</div>
			</div>

			<div class="row uniform">
				<div class="4u 12u$(xsmall)"></div>
				<div class="4u 12u$(xsmall)">
					<label>PASSWORD</label>
				</div>
			</div>

			<div class="row uniform">
				<div class="4u 12u$(xsmall)"></div>

				<div class="4u 12u$(xsmall)">

					<input type="password" name="password" id="pw" value="bbb"
						placeholder="Password" />
				</div>

			</div>

			<div class="row uniform">
				<div class="4u 12u$(xsmall)"></div>

				<div class="4u 12u$(xsmall)">

					<input type="checkbox" id="rememberMe" name="remember-me">
					<label for="rememberMe">Remember Me</label>

					<ul class="actions">
						<li style="padding-right: 5px;"><input type="submit"
							value="Login" data-uri="/login" data-method="post"></li>
						<li><input type="button" value="JOIN" data-uri="join"
							data-method="get"></li>
					</ul>
				</div>






			</div>
		</form>
	</div>
</section>
</div>
</div>
<%@include file="../includes/footer.jsp"%>

<script>
	var formObj = $("#loginForm");

	$(".actions li").click(
			function(event) {

				var that = $(event.target);
				if (that.data("method") == "get") {
					formObj.find("input").remove();
				}
				formObj.attr("action", that.data("uri")).attr("method",
						that.data("method")).submit();
			});
</script>