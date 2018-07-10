<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ include file="../includes/header.jsp"%>


<style>
.secondRow, .thirdRow {
	display: none;
}
</style>
<section>
	<header class="major">
		<h2>Reservation</h2>
	</header>
	<form method="post" action="/reserve/register" class="inputForm">
		<div class="row uniform">

			<input type="hidden" name="${_csrf.parameterName }"
				value="${_csrf.token }"> <input type="hidden" name="id"
				value="<sec:authentication property='principal.username'/>"
				readonly="readonly">

			<div class="6u 12u$(xsmall)">
				<label>Stage</label>
			</div>
			<div class="6u 12u$(xsmall)">
				<label>ReserveDate</label>
			</div>

			<div class="6u 12u$(xsmall) firstRow">
				<div class="select-wrapper">
					<select name="bno" id="rooftop" data-name="Rooftop">
						<option value = "${selectRooftopVO.bno}"> ${selectRooftopVO.rtname} (${selectRooftopVO.maximum} person)
					</select>
				</div>
			</div>

			<div class="6u 12u$(xsmall) firstRow">
				<div class="select-wrapper">
					<input type="text" id="reservedate" class="datepicker-here"
						name="reservedate" data-name="Date" autocomplete="off" />

				</div>
			</div>

			<div class="6u 12u$(xsmall) secondRow">
				<label for="department">Start Time</label>
				<div class="select-wrapper">
					<select name="startTime" id="startTime" data-name="Start Time">
					</select>
				</div>
			</div>

			<div class="6u 12u$(xsmall) secondRow">
				<label for="department">End Time</label>
				<div class="select-wrapper">
					<select name="endTime" id="endTime" data-name="End Time">
					</select>
				</div>
			</div>

			<div class="3u 12u$(xsmall) thirdRow">
				<label for="department">Article</label>
				<div class="select-wrapper">
					<select name="type" id="type">
						<option value="none">None</option>
						<c:forEach items="${articleList}" var="articleVO">
							<option value="${articleVO.type}" data-aname="${articleVO.aname}">${articleVO.aname}</option>
						</c:forEach>
					</select>
				</div>
			</div>


			<div class="3u 12u$(xsmall) thirdRow">
				<label for="department">Count</label>
				<div class="select-wrapper">
					<select name="count" id="count">
					</select>
				</div>
			</div>

			<div class="3u 12u$(xsmall) articleArea thirdRow">
				<ul class="articleList"></ul>
			</div>


			<div class="12u$ fourthRow">
				<label for="message">Message</label>
				<textarea name="message" id="message" rows="6" style="resize: none"></textarea>
			</div>

			<ul class="actions fifthRow">
				<li><input type="submit" id="submit" value="Reservation"></li>
				<li><input type="reset" id="reset" value="Reset"></li>
				<li><input type="button" id="cancel" value="Cancel"></li>
				<li><input type="button" id="list" value="List" data-uri="list"></li>
			</ul>
		</div>
		<a>rooftopVO = ${rooftopVO}<br></a> 
		<a>rooftopList = ${rooftopList}<br></a> 
		<a>selectRooftopVO = ${selectRooftopVO}<br></a> 
		<a>key = ${key}</a>
	</form>


</section>
</div>
</div>

<%@include file="../includes/footer.jsp"%>
<script>
	var impossibleTime = [];
	var serials = [];
	var reservedate = $("#reservedate");
	var startTime = $("#startTime");
	var endTime = $("#endTime");
	var type = $("#type");
	var count = $("#count");
	var articleList = $(".articleList");
	var firstRow = $(".firstRow");
	var secondRow = $(".secondRow");
	var thirdRow = $(".thirdRow");
	var serialsMap = new Map();
	var rooftop = $("#rooftop");
	var inputForm = $(".inputForm");

	$("#list").click(function(event) {
		console.log("click event");
		self.location = "/stage/list";
	});

	$("#cancel").click(function(event) {
		history.back();
	});

	inputForm
			.submit(function(event) {
				var form = $(this);
				var submitAllow = false;

				$(".firstRow, .secondRow").find("input, select").each(
						function(idx, target) {
							var inputData = $(target);
							if (!$(target).val()) {
								swal("Oops!", "Please enter "
										+ inputData.data("name"), "warning");
								event.preventDefault();
								return submitAllow;
							}

						});

				$(".article")
						.each(
								function(idx, target) {
									var type = $(target).data("type");
									var count = $(target).data("count");
									var serials = $(target).data("serials");

									form
											.append("<input type='hidden' name='articleList["+ idx +"].type' value='"+ type +"'/>");

									for (var i = 0; i < count; i++) {
										form
												.append("<input type='hidden' name='articleList["
														+ idx
														+ "].serials["
														+ i
														+ "]' value='"
														+ serialsMap.get(type)[i]
														+ "'/>")
									}

								});
				submitAllow = true;

				return submitAllow;
			});

	function makeDatepicker(opendate, closedate) {
		reservedate.datepicker({
			language : 'en',
			dateFormat : 'yyyy-mm-dd',
			autoClose : true,
			minDate : (opendate > new Date() ? opendate : new Date()),
			maxDate : closedate,
			onSelect: function(value){
				init();
				var obj = {
						"bno" : "${selectRooftopVO .bno}",
						"reservedate" : value + " 00"
					};
				$.ajax({
					headers : {
						"X-CSRF-TOKEN" : "${_csrf.token }"
					},
					url : '/ajax/timeData',
					type : 'post',
					data : JSON.stringify(obj),
					dataType : 'json',
					processData : false,
					contentType : "application/json;charset=UTF-8",
					success : function(timeDataList) {
						var targetList = $(timeDataList);
						console.dir(targetList);
						targetList.each(function(idx, item) {
							var start = new Date(item.startTime).getHours();
							var end = new Date(item.endTime).getHours();
							/* var start = item.starttime;
							var end = item.endtime; */
							console.log(start);
							console.log(end);
							collectTime(start, end);
						});
						makeStartTime(timeDataList[0].openTime,	timeDataList[0].closeTime);
					}
				})
				console.log("end");
				secondRow.show();
			}// function end
		})
	};


	thirdRow.find('option:first').attr('selected', 'selected');

	secondRow.on("change", "select", function(e) {
		console.log("secondRow change");
		thirdRow.find('option').removeAttr('selected');
		thirdRow.find('option:first').attr('selected', 'selected');
		articleList.children().remove();
		thirdRow.show();

	});

	articleList.on("click", "span", function(event) {
		console.dir($(this).parent("li").remove());
	});

	count.change(function(event) {
		var value = $(this).val();
		if (value === 0) {
			return;
		}
		serialsMap.set(type.val(), serials.slice());
		makeArticleList(value);

	});

	type.change(function(event) {
		serials = [];
		count.empty();
		var obj = {
			"startTime" : startTime.val(),
			"endTime" : endTime.val(),
			"type" : type.val()
		};

		$.ajax({
			headers : {
				"X-CSRF-TOKEN" : "${_csrf.token }"
			},
			url : '/ajax/articleData',
			type : 'post',
			data : JSON.stringify(obj),
			dataType : 'json',
			processData : false,
			contentType : "application/json;charset=UTF-8",
			success : function(articleVO) {
				serials = articleVO.serials;
				makeCount();
			}
		});
	});

	// get end time event
	startTime.change(function(event) {
		console.log("start change!");
		endTime.empty();
		var start = new Date(this.value).getHours();
		var end = findEndTime(start, $(this[0]).data("close"));
		var date = reservedate.val().trim();
		for (start += 1; start <= end; start++) {
			endTime.append('<option value="' + date + ' '
					+ ('00' + start).slice(-2) + ':00:00">' + start
					+ ':00</option>');
		}
		;
	});

	function collectTime(start, end) {
		for (start; start < end; start++) {
			impossibleTime.push(start);
		}
	};
	
	function makeStartTime(openTime, closeTime) {
		var date = reservedate.val().trim();
		console.log("in makeStartTime()");
		console.log("Date:" + date);
		console.log(openTime);
		console.log(closeTime);
		startTime.append('<option data-close="'+closeTime+'"></option>');

		for (var num = openTime; num < closeTime; num++) {
			startTime.append('<option value="'
					+ date
					+ ' '
					+ ('00' + num).slice(-2)
					+ ':00:00"'
					+ (impossibleTime.includes(num) ? 'disabled="disabled"'
							: '') + '">' + num + ':00</option>');
		}
		;
		//startTime.niceSelect();
	};

	function init() {
		impossibleTime = [];
		startTime.empty();
		endTime.empty();
		type.val("none");
		count.empty();
		articleList.empty();
		secondRow.hide();
		thirdRow.hide();
	};

	function findEndTime(start, end) {
		var result = end;
		if (impossibleTime[0] != null) {
			impossibleTime.sort(function(a, b) {
				return a - b;
			});

			impossibleTime.some(function(imptime) {
				if (start < imptime) {
					result = imptime;
					return result;
				}
				;
			});
		}
		;
		return result;
	};

	function makeCount() {
		for (var num = 0; num <= serials.length; num++) {
			count.append("<option value="+num+">" + num + "</option>");
		}
	};

	function makeArticleList(value) {
		var articleName = $('select[name="type"] option:selected')
				.data("aname");

		articleList.children().each(function(idx, target) {
			var existType = $(target).data("type");
			if (type.val() === existType) {
				$(this).remove();
			}
		});
		articleList.append("<li class='department article' data-type='"
				+ type.val() + "' data-count='" + value + "'>" + articleName
				+ " : " + value + "ea <span>X</span></li>");
	};

	$(document)
			.ready(
					function() {
						makeDatepicker(
								new Date(
										"<fmt:formatDate value="${selectRooftopVO.opendate}" type="date" pattern="yyyy-MM-dd"/>"),
								new Date(
										"<fmt:formatDate value="${selectRooftopVO.closedate}" type="date" pattern="yyyy-MM-dd"/>"));
						//rooftop.niceSelect();
					});
</script>