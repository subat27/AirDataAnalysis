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
		<h2>라이프스타일 상세</h2>
		<p>${error}</p>
	</header>
	<main>
		<div class="m-5">

			<table>
				<tr>
					<th>제목</th>
					<td>${lifestyle.subject }</td>
				</tr>
				<tr>
					<th>내용</th>
					<td>${lifestyle.content }</td>
				</tr>
				<tr>
					<th>해시태그</th>
					<td>${lifestyle.tags }</td>
				</tr>
				<tr>
					<th>카테고리</th>
					<td>${lifestyle.category }</td>
				</tr>
				<tr>
					<th>썸네일</th>
					<td><img src="${lifestyle.thumbnail }" onerror=""
						alt="thumbnail"></td>
				</tr>
			</table>
			<a href="/lifestyle/modify/${lifestyle.id}" class="btn btn-primary">수정하기</a>
		</div>
	</main>

	<jsp:include page="../../_layouts/public/scripts.jsp" />
</body>
</html>
