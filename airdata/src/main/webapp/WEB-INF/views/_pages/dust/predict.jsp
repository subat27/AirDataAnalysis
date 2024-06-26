<%@ taglib uri='http://java.sun.com/jsp/jstl/core' prefix='c'%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <jsp:include page="../../_layouts/public/meta.jsp"/>
    <jsp:include page="../../_layouts/public/link.jsp"/>
    <title>Blue sky Wellness</title>
</head>
<body>
	<div>
		<label>미세먼지(PM10) : </label>
		<label id="dust_10"></label>		
	</div>
	<div>
		<label>초미세먼지(PM25) : </label>
		<label id="dust_25"></label>		
	</div>

    <jsp:include page="../../_layouts/public/scripts.jsp"/>
    <script>
    	$(document).ready(function(){
    		$.getJSON('/predict/airCondition?date=20240627&localName=서울', function(data) {
    			$("#dust_10").html(JSON.parse(data.data)["미세먼지"]);
    			$("#dust_25").html(JSON.parse(data.data)["초미세먼지"]);
    		});
    	});
    	
    </script>
</body>
</html>
