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
<body>
	<header>
		<h2>라이프스타일 수정</h2>
		<p>${error}</p>
	</header>
	<main>
		<div class="m-5">
			<form:form method="post" modelAttribute="lifestyle">
				<div class="my-3">
					<form:label path="subject" cssClass="form-label">제목</form:label>
					<form:input path="subject" cssClass="form-control form-control-lg" />
					<form:errors path="subject" cssClass="invalid-feedback d-block" />
				</div>
				<div class="my-10">
					<form:label path="content" cssClass="form-label">내용</form:label>
					<form:textarea path="content"
						cssClass="form-control form-control-lg" />
					<form:errors path="content" cssClass="invalid-feedback d-block" />
				</div>
				<div class="my-3">
					<form:label path="tags" cssClass="form-label">해시태그</form:label>
					<form:input path="tags" cssClass="form-control form-control-lg" />
					<form:errors path="tags" cssClass="invalid-feedback d-block" />
				</div>
				<div class="my-3">
					<form:label path="category" cssClass="form-label">카테고리</form:label>
					<form:input path="category" cssClass="form-control form-control-lg" />
					<form:errors path="category" cssClass="invalid-feedback d-block" />
				</div>
				<div class="my-3">
					<label for="thumbnail" class="form-label">썸네일</label> <img
						src="${thumbnail }" onerror="" alt="thumbnail"> <input
						type="file" id="thumbnail" name="thumbnail"
						class="form-control form-control-lg" value="${thumbnail }" />
				</div>
				<hr />
				<div class="my-3">
					<button type="submit" class="btn btn-lg btn-dark">라이프스타일
						수정</button>
				</div>
			</form:form>
		</div>
	</main>
	<jsp:include page="../../_layouts/public/scripts.jsp" />
</body>
</html>
