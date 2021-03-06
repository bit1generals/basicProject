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
				<label>Rooftop</label>
			</div>
			<div class="6u 12u$(xsmall)">
				<label>ReserveDate</label>
			</div>

			<div class="6u 12u$(xsmall) firstRow">
				<div class="select-wrapper">
					<select name="bno" id="rooftop" data-name="Rooftop">
						<c:forEach items="${rooftopList}" var="rooftopVO">
							<option value="${rooftopVO.bno}"
								${selectRooftopVO.bno eq rooftopVO.bno ? 'selected' : ''}>${rooftopVO.rtname}
								(${rooftopVO.maximum} person)</option>
						</c:forEach>
					</select>
				</div>
			</div>

			<div class="6u 12u$(xsmall) firstRow">
				<div class="select-wrapper">
					<input type="text" id="reservedate" class="datepicker-here" name="reservedate"
						data-name="Date" autocomplete="off" />
				
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
	var thirdRow = $(".thirdRow select");
	var serialsMap = new Map();
	var rooftop = $("#rooftop");
	var inputForm = $(".inputForm");


	$(".actions .list").click(function name(event) {

	});
	$("#cancel").click(function(event) {
		self.location = "/reserve/list";
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

	    console.log(opendate);
		console.log(closedate);		
		
		reservedate.datepicker({
		    language: 'en',
		    dateFormat : 'yyyy-mm-dd',
		    autoClose: true,
		    minDate : (opendate > new Date() ? opendate : new Date()),
			maxDate : closedate
		});
	};

	//console.dir($('.firstRow input'));

	firstRow.on("change", "select,input", function(e) {
		console.dir("check~!~!~!~!"+$(this));
		
	});

	thirdRow.find('option:first').attr('selected', 'selected');

	secondRow.on("change", "select", function(e) {
		$(".thirdRow").show();

		thirdRow.find('option').removeAttr('selected');
		thirdRow.find('option:first').attr('selected', 'selected');
		articleList.children().remove();
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
		};
		console.dir(new Date(this.value));
		console.log("start : "+start);
		console.log("end : "+end);
		console.log("date : "+date);

	});

	// get date event
	firstRow.on("change",function(event) {
		init();
		console.log("check");
		if (reservedate.val() != "") {
			$(".secondRow").show();
			var obj = {
				"bno" : $('select[name="bno"] option:selected').val(),
				"reservedate" : reservedate.val() + " 00"
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
					console.dir(timeDataList);
					var targetList = $(timeDataList);
					targetList.each(function(idx, item) {
						var start = new Date(item.startTime).getHours();
						var end = new Date(item.endTime).getHours();
						collectTime(start, end);
					});
					makeStartTime(timeDataList[0].openTime,
							timeDataList[0].closeTime);
				}
			});
		}
	});

	rooftop.change(function() {
		reservedate.val("");

		$.ajax({
			url : '/ajax/rooftopData?bno='
					+ $('select[name="bno"] option:selected').val(),
			type : 'get',
			dataType : 'json',
			processData : false,
			contentType : "application/json;charset=UTF-8",
			success : function(data) {
				reservedate.datepicker("destroy");
			   makeDatepicker(new Date(data.opendate),
						new Date(data.closedate)); 
		
			}
		});
	});

	function collectTime(start, end) {
		for (start; start < end; start++) {
			impossibleTime.push(start);
		}
	};
	function makeStartTime(openTime, closeTime) {
		var date = reservedate.val().trim();
		console.log("Date:"+date);
		
		startTime.append('<option data-close="'+closeTime+'"></option>');

		for (var num = openTime; num < closeTime; num++) {
			startTime.append('<option value="'
					+ date
					+ ' '
					+ ('00' + num).slice(-2)
					+ ':00:00"'
					+ (impossibleTime.includes(num) ? 'disabled="disabled"'
							: '') + '">' + num + ':00</option>');
		};
		//startTime.niceSelect();
	};

	function init() {
		impossibleTime = [];
		startTime.empty();
		endTime.empty();
		type.val("none");
		count.empty();
		articleList.empty();
		$(".secondRow").hide();
		$(".thirdRow").hide();
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