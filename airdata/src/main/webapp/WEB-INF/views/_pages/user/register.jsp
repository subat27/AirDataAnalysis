<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib uri='http://java.sun.com/jsp/jstl/core' prefix='c'%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <jsp:include page="../../_layouts/public/meta.jsp"/>
    <jsp:include page="../../_layouts/public/link.jsp"/>
    <title>Blue sky Wellness</title>
</head>
<body class="bg-light">
    <div id="page-content--user" class="container user-form my-5">
        <header class="pb-4">
            <h2 class="fs-1">사용자 등록</h2>
            <p class="fs-8 mt-1 mb-0">${error}</p>
        </header>
        <main>
            <form:form method="post" action="/user/register" modelAttribute="member">
                <div class="my-3">
                    <form:label path="username" cssClass="form-label fs-8 mb-1">아이디</form:label>
                    <form:input path="username" cssClass="form-control form-control-lg"/>
                    <form:errors path="username" cssClass="invalid-feedback d-block"/>
                </div>
                <div class="my-3">
                    <form:label path="password" cssClass="form-label fs-8 mb-1">비밀번호</form:label>
                    <form:password path="password" cssClass="form-control form-control-lg"/>
                    <form:errors path="password" cssClass="invalid-feedback d-block"/>
                </div>
                <div class="my-3">
                    <form:label path="confirm" cssClass="form-label fs-8 mb-1">비밀번호 확인</form:label>
                    <form:password path="confirm" cssClass="form-control form-control-lg"/>
                    <form:errors path="confirm" cssClass="invalid-feedback d-block"/>
                </div>
                <div class="my-3">
                    <form:label path="name" cssClass="form-label fs-8 mb-1">이름</form:label>
                    <form:input path="name" cssClass="form-control form-control-lg"/>
                    <form:errors path="name" cssClass="invalid-feedback d-block"/>
                </div>
                <hr/>
                <div class="my-3">
                    <button type="submit" class="btn btn-lg btn-dark w-100">사용자 등록</button>
                </div>
            </form:form>
        </main>
    </div>
    <jsp:include page="../../_layouts/public/scripts.jsp"/>
</body>
</html>
