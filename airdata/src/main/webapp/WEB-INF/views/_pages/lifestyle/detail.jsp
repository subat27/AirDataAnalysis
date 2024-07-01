<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib uri='http://java.sun.com/jsp/jstl/core' prefix='c'%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<!DOCTYPE html>
<html lang="ko">
<head>
<jsp:include page="../../_layouts/public/meta.jsp" />
<jsp:include page="../../_layouts/public/link.jsp" />
<title>Blue sky Wellness</title>
</head>
<body>
	<header>
		<h2>라이프스타일 상세</h2>
		<p>${error}</p>
	</header>
	<main>
		<div class="m-5">
			<div class="my-3">
				<label id="subject" class="form-label">제목</label>
				<p class="form-control form-control-lg">${lifestyle.subject }</p>
			</div>
			<div class="my-10">
				<label id="content" class="form-label">내용</label>
				<textarea id="content" class="form-control form-control-lg mytextarea"
						readonly="readonly">${lifestyle.subject }</textarea>
			</div>
			<div class="my-3">
				<label id="tags" class="form-label">해시태그</label>
				<p class="form-control form-control-lg">${lifestyle.tags }</p>
			</div>
			<div class="my-3">
				<label id="category" class="form-label">카테고리</label>
				<p class="form-control form-control-lg">${lifestyle.category }</p>
			</div>
			<div class="my-3">
				<label id="category" class="form-label">썸네일</label>
				<img src="${lifestyle.thumbnail }" onerror="" alt="thumbnail">
			</div>
			
			<div class="row">
				<div class="col-4">
					<a href="/lifestyle" class="btn btn-primary me-1">목록으로</a>
					<sec:authorize access="isAuthenticated()">
						<a href="/lifestyle/modify/${lifestyle.id}" class="btn btn-primary me-1">수정하기</a>
						<a href="/lifestyle/delete/${lifestyle.id}" class="btn btn-primary me-1">삭제</a>
					</sec:authorize>
					<sec:authorize access="!isAuthenticated()">
						<a href="/edit/register/${lifestyle.id}" class="btn btn-primary me-1">수정요청</a>
						<a href="/edit/register" class="btn btn-primary me-1">등록신청</a>
					</sec:authorize>
				</div>
				<div class="col-4"></div>
				<div class="col-4 d-flex justify-content-end">
					<button id="previousBtn" class="btn btn-primary me-1">이전으로</button>
					
				</div>
			</div>
			
		</div>
	</main>

	<jsp:include page="../../_layouts/public/scripts.jsp" />
</body>
</html>
