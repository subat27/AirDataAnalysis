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
<body>
    <header>
        <h2>로그인</h2>
        <p>요청하신 페이지는 관리자 권한이 있어야 합니다.</p>
        <c:if test="${sessionScope.message}">
            <small>${sessionScope.message}</small>
            <c:remove var="message" scope="session"/>
        </c:if>
    </header>
    <main>
        <form:form method="post" action="/user/login">
            <div class="my-3">
                <label for="username" class="form-label">아이디</label>
                <input type="text" class="form-control form-control-lg" name="username" id="username" placeholder="아이디 입력">
            </div>
            <div class="my-3">
                <label for="password" class="form-label">비밀번호</label>
                <input type="password" class="form-control form-control-lg" name="password" id="password" placeholder="비밀번호 입력">
            </div>
            <hr/>
            <div class="my-3">
                <button type="submit" class="btn btn-lg btn-dark">로그인</button>
            </div>
        </form:form>
    </main>
    <jsp:include page="../../_layouts/public/scripts.jsp"/>
</body>
</html>
