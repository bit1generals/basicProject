<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="../includes/header.jsp"%>


<section>
	<header class="major">
		<h2>Login</h2>
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


	<div>
		<form id="loginForm">
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
					<input type="text" name="id" id="id" placeholder="Input ID"
						value="user1" />
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

					<input type="password" name="pw" id="pw" value="pw1"
						placeholder="Password" />
				</div>

			</div>

			<div class="row uniform">
				<div class="4u 12u$(xsmall)"></div>

				<div class="4u 12u$(xsmall)">

					<input type="checkbox" id="rememberMe" name="rememberMe"> <label
						for="rememberMe">Remember Me</label>

					<ul class="actions">
						<li style="padding-right: 5px;"><input type="submit"
							value="Login" data-uri="login" data-method="post"></li>
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