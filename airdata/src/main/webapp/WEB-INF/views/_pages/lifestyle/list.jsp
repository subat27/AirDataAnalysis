<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib uri='http://java.sun.com/jsp/jstl/core' prefix='c'%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<jsp:include page="../../_layouts/public/meta.jsp" />
<jsp:include page="../../_layouts/public/link.jsp" />
<title>Blue sky Wellness</title>
<style>
	.card-img-top {
    	object-fit: cover;
	    height: 15rem;
	}

	.card-text {
		max-height: 4em;
		line-height: 2em;
		white-space: normal;
		overflow: hidden;
	}
</style>
</head>
<body>
	<header>
		<h2>라이프스타일 목록</h2>
		<p>${error}</p>
	</header>
	<main>
		<form:form method="get" action="/lifestyle/list">
			<div class="row m-5">
				<div class="col-8 col-md-3">
					<label for="type" class="form-label d-md-none">카테고리명</label> <select
						name="type" id="type" class="form-select">
						<option value="">선택</option>
						<option value="category"
							<c:if test="${type eq 'category' }">selected="selected"</c:if>>
							카테고리</option>
						<option value="tags"
							<c:if test="${type eq 'tags' }">selected="selected"</c:if>>태그명</option>
					</select>
				</div>
				<div class="col-8 col-md-8">
					<label for="search" class="form-label d-md-none">검색어</label> <input
						name="search" id="search" type="text" class="form-control"
						value="${search }">
				</div>
				<div class="col-8 col-md-1">
					<button type="submit" class="btn btn-primary">검색</button>
				</div>
			</div>
		</form:form>


		<div class="col">
			<div class="row m-5">
				<c:forEach items="${items.content }" var="lifestyle">
					<div class="col-lg-3 col-md-4 col-sm-6 p-2">
						<div class="card h-100">
							<img class="card-img-top" src="${lifestyle.thumbnail }" alt="thumbnail"
								onerror="this.onerror=null; this.src='/assets/images/noImage.png'">
							<div class="card-body">
								<h5 class="card-title">${lifestyle.subject }</h5>
								<div class="card-text">
									${lifestyle.content }
								</div>
								
							</div>
							<div class="card_footer">
							<a href="/lifestyle/detail/${lifestyle.id }">더보기</a>
							</div>
						</div>
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
								href="/lifestyle?page=${currentPage-1 }&type=${type}&search=${search}"
								class="page-link">이전</a></li>
						</c:if>

						<c:forEach var="page" begin="${start }" end="${end }">
							<li class="page-item"><a
								href="/lifestyle?page=${page }&type=${type}&search=${search}"
								class="page-link <c:if test="${page eq currentPage }">active</c:if>">${page }</a>
							</li>
						</c:forEach>

						<c:if test="${currentPage lt totalPages }">
							<li class="page-item"><a
								href="/lifestyle?page=${currentPage-1 }&type=${type}&search=${search}"
								class="page-link">다음</a></li>
						</c:if>

					</ul>
				</div>
			</c:if>
		</div>

		<div class="row m-5">
			<div class="col-6 d-flex justify-content-start">
				<a class="btn btn-primary" href="/lifestyle/register">등록신청</a>
			</div>
			<div class="col-6 d-flex justify-content-end">
				<a class="btn btn-primary" href="/">이전으로</a>
			</div>
		</div>

	</main>
	<jsp:include page="../../_layouts/public/scripts.jsp" />
</body>
</html>