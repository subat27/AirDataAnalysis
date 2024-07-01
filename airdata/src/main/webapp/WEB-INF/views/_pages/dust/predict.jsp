<%@ taglib uri='http://java.sun.com/jsp/jstl/core' prefix='c'%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<jsp:include page="../../_layouts/public/meta.jsp" />
<jsp:include page="../../_layouts/public/link.jsp" />
<title>Blue sky Wellness</title>
</head>
<body>
	<select id="localSelector">
		<option selected="selected">지역명</option>
		<option>서울</option>
		<option>강원</option>
		<option>경기</option>
		<option>경남</option>
		<option>경북</option>
		<option>광주</option>
		<option>대구</option>
		<option>대전</option>
		<option>부산</option>
		<option>세종</option>
		<option>울산</option>
		<option>인천</option>
		<option>전남</option>
		<option>전북</option>
		<option>제주</option>
		<option>충남</option>
		<option>충북</option>
	</select>

	<div class="row">
		<div class="col-10">
			<h2>날씨 정보</h2>
			<div class="row">
				<div class="col-2">미세먼지</div>
				<div class="col-10 row">
					<div class="col-6"><label>미세먼지(PM10)</label></div>
					<div class="col-6"><label>초미세먼지(PM25)</label></div>
					<div class="col-6"><label class="dust_10_td"></label></div>
					<div class="col-6"><label class="dust_25_td"></label></div>
				</div>
			</div>
		</div>
	
		<div class="col-10">
			<h2>미세먼지 정보</h2>
			<table class="table" >
				<thead>
					<tr>
						<th></th>
						<th>오늘</th>
						<th>내일</th>
						<th>모레</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td>미세먼지(PM10)</td>
						<td><label class="dust_10_td"></label></td>
						<td><label id="dust_10_tm"></label></td>
						<td><label id="dust_10_tdat"></label></td>
					</tr>
					<tr>
						<td>초미세먼지(PM25)</td>
						<td><label class="dust_25_td"></label></td>
						<td><label id="dust_25_tm"></label></td>
						<td><label id="dust_25_tdat"></label></td>
					</tr>
				</tbody>
			</table>
		</div>
	</div>

	<jsp:include page="../../_layouts/public/scripts.jsp" />
	<script type="text/javascript" src="${pageContext.request.contextPath}/assets/scripts/predict.js"></script>
	<script>
		$(document).ready(function() {
			const date = new Date();
						
			const today = getDateString(date);
			
			date.setDate(date.getDate() + 1);
			const tomorrow = getDateString(date);
			
			date.setDate(date.getDate() + 1);
			const tdat = getDateString(date); 
			
			console.log(today, tomorrow, tdat);
			
			$("#localSelector").change(function() {
				$.getJSON('/predict/airCondition?dates=' + today + ','  + tomorrow + ','  + tdat + '&localName='+ $(this).val(), function(data) {
					$("#dust_10_td").html(getAirCondition("PM10", data[today]["PM10"]));
					$("#dust_25_td").html(getAirCondition("PM25", data[today]["PM25"]));
					$("#dust_10_tm").html(getAirCondition("PM10", data[tomorrow]["PM10"]));
					$("#dust_25_tm").html(getAirCondition("PM25", data[tomorrow]["PM25"]));
					$("#dust_10_tdat").html(getAirCondition("PM10", data[tdat]["PM10"]));
					$("#dust_25_tdat").html(getAirCondition("PM25", data[tdat]["PM25"]));
				});
				
				$.getJSON('/predict/getWeather?localName='+$(this).val(), function(data){
					
				});
			});
		});
		
		
	</script>
</body>
</html>