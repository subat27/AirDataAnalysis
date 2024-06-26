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
        <h2>나의 정보 수정</h2>
        <p>${error}</p>
    </header>
    <main>
        <section class="information">
            <form:form method="post" id="informationChange" action="/admin/mypage/information" modelAttribute="information">
                <div class="my-3">
                    <label for="username" class="form-label">아이디 (수정불가)</label>
                    <input type="text" id="username" readonly="readonly" disabled="disabled" value="${data.username}" class="form-control form-control-lg"/>
                </div>
                <div class="my-3">
                    <form:label path="name" cssClass="form-label">이름</form:label>
                    <form:input path="name" cssClass="form-control form-control-lg"/>
                    <form:errors path="name" cssClass="invalid-feedback d-block"/>
                </div>
                <div class="my-3">
                    <label for="created" class="form-label">등록일시 (수정불가)</label>
                    <input type="text" id="created" readonly="readonly" disabled="disabled" value="${data.created}" class="form-control form-control-lg"/>
                </div>
                <hr/>
                <div class="my-3">
                    <button type="submit" class="btn btn-lg btn-dark">정보수정</button>
                </div>
            </form:form>
        </section>
    </main>
    <jsp:include page="../../../_layouts/public/scripts.jsp"/>
</body>
</html>
