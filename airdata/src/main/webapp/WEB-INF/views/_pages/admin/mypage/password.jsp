<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib uri='http://java.sun.com/jsp/jstl/core' prefix='c'%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <jsp:include page="../../../_layouts/public/meta.jsp"/>
    <jsp:include page="../../../_layouts/public/link.jsp"/>
    <title>Admin for Blue sky Wellness</title>
</head>
<body>
    <header>
        <h2>나의 비밀번호 수정</h2>
        <p>${error}</p>
    </header>
    <main>
        <section class="password">
            <form:form method="post" id="passwordChange" action="/admin/mypage/password" modelAttribute="password">
                <div class="my-3">
                    <form:label path="nowPassword" cssClass="form-label">기존 </form:label>
                    <form:password path="nowPassword" cssClass="form-control form-control-lg"/>
                    <form:errors path="nowPassword" cssClass="invalid-feedback d-block"/>
                </div>
                <div class="my-3">
                    <form:label path="newPassword" cssClass="form-label">신규 비밀번호</form:label>
                    <form:password path="newPassword" cssClass="form-control form-control-lg"/>
                    <form:errors path="newPassword" cssClass="invalid-feedback d-block"/>
                </div>
                <div class="my-3">
                    <form:label path="confirmPassword" cssClass="form-label">신규 비밀번호 확인</form:label>
                    <form:password path="confirmPassword" cssClass="form-control form-control-lg"/>
                    <form:errors path="confirmPassword" cssClass="invalid-feedback d-block"/>
                </div>
                <hr/>
                <div class="my-3">
                    <button type="submit" class="btn btn-lg btn-dark">비밀번호 변경</button>
                </div>
            </form:form>
        </section>
    </main>
    <jsp:include page="../../../_layouts/public/scripts.jsp"/>
</body>
</html>
