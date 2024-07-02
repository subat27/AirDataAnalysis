<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib uri='http://java.sun.com/jsp/jstl/core' prefix='c'%>
<%@ taglib prefix="fmt" uri='http://java.sun.com/jsp/jstl/fmt'%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<jsp:include page="../../_layouts/public/meta.jsp" />
<jsp:include page="../../_layouts/public/link.jsp" />
<title>Blue sky Wellness</title>
</head>
<body>
	<div id="wrapper" class="container-fluid">
		<div class="row">
			<jsp:include page="../../_layouts/public/sidebar.jsp" />
			<div id="page-content--sub"
				class="col-12 col-lg-9 col-xxl-10 offset-lg-3 offset-xxl-2 p-3">
				<header class="page-subject">
					<h2>수정요청 확인</h2>
					<p>${error}</p>
				</header>
				<div class="row">
					<div class="col">
						<div class="row m-5">
							<h4>라이프스타일 수정 요청 목록</h4>
						</div>
						<div class="row m-5">
							<c:forEach items="${items.content }" var="editRequest">
								<div class="col-12 p-2">
									<div class="row">
										<div class="col-6 d-flex">
											<p>작성자: ${editRequest.name }
											<p>
										</div>
										<div class="col-6 d-flex justify-content-end">
											<fmt:parseDate value="${editRequest.created }"
												pattern="yyyy-MM-dd'T'HH:mm" var="parsedDateTime"
												type="both" />
											<p>
												<fmt:formatDate value="${parsedDateTime }"
													pattern="yyyy-MM-dd HH:mm" />
											<p>
										</div>
									</div>
									<div class="card_footer">
										<a class="link-dark link-underline-opacity-0"
											href="/admin/edit/detail/${editRequest.id }">${editRequest.subject }</a>
									</div>
									<hr>
								</div>
							</c:forEach>
						</div>
					</div>

					<div class="row">
						<c:if test="${not empty items }">
							<div>
								<ul class="pagination justify-content-center">
									<c:if test="${currentPage gt 1 }">
										<li class="page-item"><a
											href="/admin/edit/list?page=${currentPage-1 }" class="page-link">이전</a></li>
									</c:if>

									<c:forEach var="page" begin="${start }" end="${end }">
										<li class="page-item"><a href="/admin/edit/list?page=${page }"
											class="page-link <c:if test="${page eq currentPage }">active</c:if>">${page }</a>
										</li>
									</c:forEach>

									<c:if test="${currentPage lt totalPages }">
										<li class="page-item"><a
											href="/admin/edit/list?page=${currentPage-1 }" class="page-link">다음</a></li>
									</c:if>

								</ul>
							</div>
						</c:if>
					</div>

					<div class="row m-5">
						<div class="col-6 d-flex justify-content-start">
							<a class="btn btn-primary" href="/">이전으로</a>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<jsp:include page="../../_layouts/public/scripts.jsp" />
</body>
</html>