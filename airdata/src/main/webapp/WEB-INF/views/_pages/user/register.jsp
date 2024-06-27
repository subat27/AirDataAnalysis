<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib uri='http://java.sun.com/jsp/jstl/core' prefix='c'%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<jsp:include page="../../_layouts/public/meta.jsp" />
<jsp:include page="../../_layouts/public/link.jsp" />
<title>Blue sky Wellness</title>
</head>
<body class="bg-light vh-100 d-flex flex-column">
    <main class="form-signup w-100 m-auto">
        <form:form method="post" action="/user/register" modelAttribute="member">
        	<h1 class="h3 mb-3">관리자 등록</h1>
			<c:if test="${not empty error}">
				<p>${error}</p>
			</c:if>
            <div>
                <div class="form-floating">
                	<form:input path="username" cssClass="form-control"/>
					<form:label path="username">아이디</form:label>
				</div>
                <form:errors path="username" cssClass="invalid-feedback d-block"/>
            </div>
            <div>
                <div class="form-floating">
                	<form:password path="password" cssClass="form-control"/>
					<form:label path="password">비밀번호</form:label>
				</div>
                <form:errors path="password" cssClass="invalid-feedback d-block"/>
            </div>
            <div>
                <div class="form-floating">
                	<form:password path="confirm" cssClass="form-control"/>
					<form:label path="confirm">비밀번호 확인</form:label>
				</div>
                <form:errors path="confirm" cssClass="invalid-feedback d-block"/>
            </div>
            <div>
                <div class="form-floating">
                	<form:input path="name" cssClass="form-control"/>
					<form:label path="name">이름</form:label>
				</div>
                <form:errors path="name" cssClass="invalid-feedback d-block"/>
            </div>
            <div class="my-3">
                <button type="submit" class="btn btn-dark w-100">관리자 등록</button>
            </div>
        </form:form>
    </main>
    <jsp:include page="../../_layouts/public/scripts.jsp"/>
</body>
</html>
