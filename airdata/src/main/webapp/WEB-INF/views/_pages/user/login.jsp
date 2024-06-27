<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib uri='http://java.sun.com/jsp/jstl/core' prefix='c'%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <jsp:include page="../../_layouts/user/meta.jsp"/>
    <jsp:include page="../../_layouts/user/link.jsp"/>
    <title>Blue sky Wellness</title>
</head>
<body class="vh-100 bg-light d-flex flex-column">
    <main class="form-signin w-100 m-auto">
		<form:form method="post" action="/user/login">
			<h1 class="h3 mb-3">관리자 로그인</h1>
			<c:if test="${not empty sessionScope.message}">
				<p>${sessionScope.message}</p>
				<c:remove var="message" scope="session"/>
			</c:if>
			<div class="form-floating">
			  	<input type="text" class="form-control" id="username" name="username" placeholder="아이디">
				<label for="username">아이디</label>
			</div>
			<div class="form-floating">
				<input type="password" class="form-control" id="password" name="password" placeholder="비밀번호">
			  	<label for="password">비밀번호</label>
			</div>
		<button class="btn btn-dark w-100 py-2" type="submit">로그인</button>
		</form:form>
	</main>
    <jsp:include page="../../_layouts/user/scripts.jsp"/>
</body>
</html>
