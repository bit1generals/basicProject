<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="../includes/header.jsp"%>
<style>
.rowData {
	cursor: pointer;
}
</style>
<section>
	<header class="major">
		<h2>My Page</h2>
	</header>

	<div class="row uniform">
		<div class="12u$">
			<ul class="actions">
				<li><input type="button" value="My Privacy"
					class="action special" data-name="MyPrivacy"></li>
				<li><input type="button" value="My Stage" class="action"
					data-name="myStage"></li>
				<li><input type="button" value="Stage Schedule" class="action"
					data-name="stageSchedule"></li>
				<li><input type="button" value="My Reservation" class="action"
					data-name="myReservation"></li>
			</ul>
		</div>
	</div>
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


	<section class="rooptopListShow">
		<div class="table">
			<form id="joinForm" method="post">

				<div class="row uniform">
					<div class="4u 12u$(xsmall)"></div>
					<div class="4u 12u$(xsmall)">
						<label>ID</label>
					</div>
				</div>
				<div class="row uniform">
					<div class="4u 12u$(xsmall)"></div>
					<div class="4u 12u$(xsmall)">
						<input type="text" name="id" id="id" value="${memberVO.id}"
							readonly="readonly" />
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
							class="pwCheckAction inputs" />
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
						<input type="password" id="pwCheck" class="pwCheckAction inputs" />
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
						<input type="text" name="name" id="name" value="${memberVO.name }"
							readonly="readonly" />
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
						<input type="text" name="email" id="email" class="inputs extra"
							value="${memberVO.email}" />
					</div>
				</div>

				<input type="hidden" name="${_csrf.parameterName }"
					value="${_csrf.token }">

				<div class="row uniform">
					<div class="4u 12u$(xsmall)"></div>

					<div class="4u 12u$(xsmall)">
						<ul class="actions">
							<li><input type="submit" value="Modify" data-uri="myPage"
								data-method="post"></li>
						</ul>
					</div>
				</div>
			</form>
		</div>

	</section>

	<hr>

</section>

</div>
</div>
<%@include file="../includes/footer.jsp"%>
<script id="myStage" type="text/x-handlebars-template">
<table>
	<thead>
		<tr>
			<th>No</th>
			<th colspan="2">Stage Name</th>
			<th>Open Date</th>
			<th>Close Date</th>
			<th>Start Time</th>
			<th>End Time</th>
			<th>Regdate</th>
			<th>State</th>
		</tr>
	</thead>
	<tbody>
		{{#each .}}
			<tr class="rowData" data-msg="{{message}}">
				<td name="rtno">{{rtno}}</td>
				<td colspan="2" name="rtname">{{rtname}}</td>
				<td name="opendate">{{formatTime opendate "YYYY-MM-DD"}}</td>
				<td name="closedate">{{formatTime closedate "YYYY-MM-DD"}}</td>
				<td name="openTime">{{openTime}}:00</td>
				<td name="closeTime">{{closeTime}}:00</td>
				<td name="regdate">{{formatTime regdate "YYYY-MM-DD h:mm"}}</td>
				<td name="state">{{state}}</td>
			</tr>
		{{/each}}
	
	</tbody>
</table>
</script>

<script id="myReservation" type="text/x-handlebars-template">
<table>
	<thead>
		<tr>
			<th>No</th>
			<th colspan="2">Stage Name</th>
			<th>Reserve Date</th>
			<th>Start Time</th>
			<th>End Time</th>
			<th>Regdate</th>
			<th>State</th>
		</tr>
	</thead>
	<tbody>
		{{#each .}}
			<tr class="rowData" data-msg="{{message}}">
				<td name="rno">{{rno}}</td>
				<td colspan="2" name="rtname">{{stageVO.rtname}}</td>
				<td name="reservedate">{{reservedate}}</td>
				<td name="stateTime">{{formatTime startTime "H:mm"}}</td>
				<td name="endTime">{{formatTime endTime "H:mm"}}</td>
				<td name="regdate">{{formatTime regdate "YYYY-MM-DD H:mm"}}</td>
				<td name="state">{{state}}</td>
			</tr>
		{{/each}}
	</tbody>
</table>
</script>
<script id="stageSchedule" type="text/x-handlebars-template">
<table>
	<thead>
		<tr>
			<th>No</th>
			<th>Stage Name</th>
			<th>reserver ID</th>
			<th>Reserve Date</th>
			<th>Start Time</th>
			<th>End Time</th>
			<th>Regdate</th>
			<th>State</th>
		</tr>
	</thead>
	<tbody>
		{{#each .}}
			<tr class="rowData" data-msg="{{message}}">
				<td name="rno">{{rno}}</td>
				<td name="rtname">{{stageVO.rtname}}</td>
				<th name="id">{{stageVO.boardVO.id}}</th>
				<td name="reservedate">{{reservedate}}</td>
				<td name="stateTime">{{formatTime startTime "H:mm"}}</td>
				<td name="endTime">{{formatTime endTime "H:mm"}}</td>
				<td name="regdate">{{formatTime regdate "YYYY-MM-DD H:mm"}}</td>
				<td name="state">{{state}}</td>
			</tr>
		{{/each}}
	</tbody>
</table>
</script>
<script id="template" type="text/x-handlebars-template">
<tr class='loadArticle' rowspan='2'>
	<td colspan='8'>
		└> 
	{{#if .}}
		Articles : 
		{{#each .}}
			{{aname}}  {{this.serials.length}}개
		{{/each}}
	{{else}}
           Articles was not reserved.
	{{/if}}
		<br>
	{{#if this.msg}}
		└> Message : {{this.msg}}
	{{/if}}
	</td>

</tr>

<input class='loadArticle' type='hidden'/>
</script>
<script>
	var pwCheckAction = $(".pwCheckAction");
	var pwCheck = $("#pwCheck");
	var pw = $("#pw");
	var checkMsg = $(".checkMsg");
	var id = $("#id");
	var inputs = $(".inputs");
	var joinForm = $("#joinForm");
	var extra = $(".extra");
	var actions = $(".actions");
	var action = $(".action");
	var tableTarget = $(".table");
	var template = Handlebars.compile($("#template").html());

	function eventAdd(showList) {
		var statement;
		var rowData = $(".rowData");
		rowData.click(function(event) {
			var selectedData = $(this);
			var rno = selectedData.find("td[name=rno]").text();
			var msg = selectedData.data("msg");
			console.log(msg);
			$(".loadArticle").remove();
			if (statement != rno) {
				//console.log("if in! ==" + statement);
				selectAjax(rno, selectedData, msg);
				statement = rno;
			} else {
				statement = "";
			}
		});

		// rowData click event..
		function selectAjax(rno, selectedData, msg) {
			$.ajax({
				url : '/ajax/reserveArticleData?rno=' + rno,
				type : 'get',
				dataType : 'text',
				processData : false,
				contentType : "application/json;charset=UTF-8",
				success : function(articleVOList) {
					var obj = JSON.parse(articleVOList);
					obj.msg = msg;
					//console.log($(".special").data("name"));
					if ($(".special").data("name") != "myStage") {
						var html = template(obj);
						selectedData.after(html);
					}
				}
			});
		}
		;
	}

	action.click(function(event) {
		var target = $(this);
		var showList = target.data("name");
		var obj = {
			"id" : "${memberVO.id}"
		};
		action.removeClass("special");
		target.addClass("special");
		if (showList != 'MyPrivacy') {
			getListData(showList, obj);
		} else {
			location.reload();
		}
	});

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
			swal("Oops!", "Please re-enter " + target.name, "warning");
			return false;
		}
	}

	function checkEmptyValue(target) {
		var value = $(target).val();
		if (value == "") {
			swal("Oops!", "Please re-enter " + target.name, "warning");
			return false;
		}
		return true;
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

	function getListData(showList, obj) {
		$.ajax({
			headers : {
				"X-CSRF-TOKEN" : "${_csrf.token }"
			},
			url : '/ajax/' + showList,
			type : 'post',
			dataType : 'json',
			data : JSON.stringify(obj),
			processData : false,
			contentType : "application/json;charset=UTF-8",
			success : function(dataList) {
				var handle = Handlebars.compile($("#" + showList).html());
				tableTarget.html(handle(dataList));
				eventAdd(showList);
			}
		});
	}
</script>