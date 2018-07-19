<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ include file="../includes/header.jsp"%>


<section>
	<header class="major">
		<h2>Show Your Busking</h2>
	</header>
	<form method="post" action="./busking/register" class="inputForm">
		<div class="row uniform">

			<input type="hidden" name="${_csrf.parameterName }"
				value="${_csrf.token }"> <input type="hidden" name="id"
				value="<sec:authentication property='principal.username'/>"
				readonly="readonly">

			<div class="6u 12u$(xsmall)">
				<label>Reserved Name</label>
			</div>
			<div class="6u 12u$(xsmall)">
				<label>Reserved Date</label>
			</div>
			<div class="6u 12u$(xsmall) firstRow">
				<div class="select-wrapper">
					<select name="bno" id="stage" data-name="Stage">
						<option></option>
						<c:forEach items="${reserveVOList}" var="reserveVO">
							<c:if test="${reserveVO.state == 'Done'}">
								<option name="${reserveVO.stageVO.rtname}"
									value="${reserveVO.rno}" data-date="${reserveVO.reservedate}"
									data-starttime="${reserveVO.startTime}"
									data-endtime="${reserveVO.endTime}">
									${reserveVO.stageVO.rtname}</option>
							</c:if>
						</c:forEach>
					</select>
				</div>
			</div>

			<div class="6u 12u$(xsmall)">
				<div class="select-wrapper">
					<input type="text" id="reservedate" class="datepicker-here"
						name="reservedate" data-name="Date" autocomplete="off" disabled />

				</div>
			</div>

			<div class="6u 12u$(xsmall) secondRow">
				<label for="department">Start Time</label>
				<div class="select-wrapper">
					<input type="text" name="startTime" id="startTime"
						data-name="Start Time" disabled />
				</div>
			</div>

			<div class="6u 12u$(xsmall) secondRow">
				<label for="department">End Time</label>
				<div class="select-wrapper">
					<input type="text" name="endTime" id="endTime" data-name="End Time"
						disabled />
				</div>
			</div>

			<div class="12u$ fourthRow">
				<label for="department">Title</label> 
				<input name="bktitle" type="text" />
			</div>

			<div class="12u$ fourthRow">
				<label for="message">Message</label>
				<textarea name="bkcontent" id="bkcontent" rows="6"
					style="resize: none"></textarea>
			</div>

			<ul class="actions fifthRow">
				<li><input type="submit" id="submit" value="Reservation"></li>
				<li><input type="reset" id="reset" value="Reset"></li>
				<li><input type="button" id="cancel" value="Cancel"></li>
				<li><input type="button" id="list" value="List" data-uri="list"></li>
			</ul>
		</div>
		<a>reserveVOList = ${reserveVOList} <br></a> 
		<a>stageList = ${stageList}<br>
		</a> <a>selectStageVO = ${selectStageVO}<br></a> <a>key = ${key}</a>
		<sec:authentication property='principal.username' />
	</form>


</section>
</div>
</div>

<%@include file="../includes/footer.jsp"%>
<script>
	var reservedate = $("#reservedate");
	var startTime = $("#startTime");
	var endTime = $("#endTime");
	var type = $("#type");
	var count = $("#count");
	var articleList = $(".articleList");
	var firstRow = $(".firstRow");
	var secondRow = $(".secondRow");
	var stage = $("#stage");
	var inputForm = $(".inputForm");

	firstRow.change(function(event) {
		var that = $(".firstRow option:selected");
		reservedate.val(that.data("date"));
		startTime.val(moment(that.data("starttime")).format('hh:mm'));
		endTime.val(moment(that.data("endtime")).format('hh:mm'));
	});
</script>