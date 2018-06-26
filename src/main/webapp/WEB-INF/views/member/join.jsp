<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="../includes/header.jsp"%>


<section>
	<header class="major">
		<h2>Join</h2>
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
		<form id="joinForm" method="post">

			<div class="row uniform">
				<div class="4u 12u$(xsmall)"></div>
				<div class="4u 12u$(xsmall) checkID">
					<label>ID</label>
				</div>
			</div>
			<div class="row uniform">
				<div class="4u 12u$(xsmall)"></div>
				<div class="4u 12u$(xsmall)">
					<input type="text" name="id" id="id" placeholder="ID"
						class="inputs" />

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
					<input type="password" name="pw" id="pw"
						class="pwCheckAction inputs" value="pw1" placeholder="Password" />
				</div>
			</div>

			<div class="row uniform">
				<div class="4u 12u$(xsmall)"></div>
				<div class="4u 12u$(xsmall) checkMsg">
					<label>PASSWORD CHECK</label>
				</div>

			</div>

			<div class="row uniform">
				<div class="4u 12u$(xsmall)"></div>
				<div class="4u 12u$(xsmall)">
					<input type="password" id="pwCheck" class="pwCheckAction inputs"
						value="pw1" placeholder="Password" />
				</div>
				<div class="4u 12u$(xsmall)"></div>
			</div>

			<div class="row uniform">
				<div class="4u 12u$(xsmall)"></div>
				<div class="4u 12u$(xsmall)">
					<label>NAME</label>
				</div>
			</div>
			<div class="row uniform">
				<div class="4u 12u$(xsmall)"></div>
				<div class="4u 12u$(xsmall)">
					<input type="text" name="name" id="name" value="name"
						class="inputs extra" placeholder="Name" />
				</div>
			</div>

			<div class="row uniform">
				<div class="4u 12u$(xsmall)"></div>
				<div class="4u 12u$(xsmall)">
					<label>EMAIL</label>
				</div>
			</div>
			<div class="row uniform">
				<div class="4u 12u$(xsmall)"></div>
				<div class="4u 12u$(xsmall)">
					<input type="text" name="email" id="email" value="email@email.com"
						class="inputs extra" placeholder="Email" />
				</div>
			</div>
			<input type="hidden"
			name="${_csrf.parameterName }" value="${_csrf.token }">

			<div class="row uniform">
				<div class="4u 12u$(xsmall)"></div>

				<div class="4u 12u$(xsmall)">
					<ul class="actions">
						<li style="padding-right: 5px;"><input type="reset"
							value="reset"></li>
						<li><input type="submit" value="JOIN" data-uri="join"
							data-method="post"></li>
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
	var pwCheckAction = $(".pwCheckAction");
	var pwCheck = $("#pwCheck");
	var pw = $("#pw");
	var checkMsg = $(".checkMsg");
	var id = $("#id");
	var inputs = $(".inputs");
	var checkID = $(".checkID");
	var joinForm = $("#joinForm");
	var extra = $(".extra");

	extra.blur(function() {
		//만약 각 input에서 입력 안한것과 state가 틀린것을 구분안한다면 어떻게 구분함?
		if ($(this).val() != "") {
			$(this).data("state", true);
		} else {
			$(this).data("state", false);
		}
	});

	pwCheckAction.on('input', function() {
		pw.val() == pwCheck.val() ? makeCheckPW(true) : makeCheckPW(false);
	});

	// Enter press next focus
	inputs.keydown(function(event) {
		if (event.keyCode == 13) {
			event.preventDefault();
			var index = inputs.index(this) + 1;
			inputs.eq(index).focus();
		}
	});

	// Input id check overlap
	id.blur(function(event) {

		$.ajax({
			url : '/ajax/idCheck?id=' + id.val(),
			type : 'get',
			dataType : 'json',
			processData : false,
			contentType : "application/json;charset=UTF-8",
			success : function(map) {
				makeCheckID(map.result);
			}
		});
	});

	joinForm.submit(function(event) {
		inputs.each(function(idx, target) {
			//여기는 밸류값이 ""가아닌애들 즉, 입력자체를 아예 안한얘들 거르는 곳 
			if (!checkEmptyValue(target) || !checkState(target)) {
				event.preventDefault();
				return false;
			}
		});
		return true;
	});

	function checkState(target) {
		var check = $(target).data("state");
		if (check) {
			return true;
		} else {
			alert(target.name + "를 다시 입력해주세요.");
			return false;
		}
	}

	function checkEmptyValue(target) {
		var value = $(target).val();
		if (value == "") {
			alert(target.name + "을(를) 입력해주세요.");
			return false;
		}
		return true;
	}

	function makeCheckID(check) {
		if (check) {
			checkID
					.html("<label class='join'>ID&nbsp</label><label class='join red'>(Can not use it)</label>");
			id.data("state", false);
		} else {
			checkID
					.html("<label class='join'>ID&nbsp</label><label class='join green'>(Can use it)</label>");
			id.data("state", true);
		}
	}

	function makeCheckPW(check) {
		if (check) {
			checkMsg
					.html("<label class='join'>PASSWORD CHECK&nbsp</label><label class='join green'>(Matched)</label>");
			pw.data("state", true);
			pwCheck.data("state", true);
		} else {
			checkMsg
					.html("<label class='join'>PASSWORD CHECK&nbsp</label><label class='join red'>(Not Matched)</label>");
			pw.data("state", false);
			pwCheck.data("state", false);
		}
	}
</script>