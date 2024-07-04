<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri='http://java.sun.com/jsp/jstl/core' prefix='c'%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <jsp:include page="../../_layouts/public/meta.jsp"/>
    <jsp:include page="../../_layouts/public/link.jsp"/>
    <title>Blue sky Wellness</title>
</head>
<body>
<div id="wrapper" class="container-fluid">
    <div class="row">
        <jsp:include page="../../_layouts/public/sidebar.jsp"/>
        <div id="page-content--sub" class="col-12 col-lg-9 col-xxl-10 offset-lg-3 offset-xxl-2 p-3">
            <header class="page-subject">
                <h2>장소</h2>
            </header>
            <div class="row">
				<div class="col">
						<div class="row m-5">
							<c:forEach items="${items.content }" var="location">
								<div class="col-lg-3 col-md-4 col-sm-6 p-2">
									<div class="card h-100">
										<div class="card-body">
											<h5 class="card-title">${location.title }</h5>
											<div class="card-text">${location.address }</div>
										</div>
										<div class="card_footer">
											<a href="/location/detail/${location.id }">더보기</a>
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
											href="/location/list?page=${currentPage-1 }&type=${type}&search=${search}"
											class="page-link">이전</a></li>
									</c:if>

									<c:forEach var="page" begin="${start }" end="${end }">
										<li class="page-item"><a
											href="/location/list?page=${page }&type=${type}&search=${search}"
											class="page-link <c:if test="${page eq currentPage }">active</c:if>">${page }</a>
										</li>
									</c:forEach>

									<c:if test="${currentPage lt totalPages }">
										<li class="page-item"><a
											href="/location/list?page=${currentPage-1 }&type=${type}&search=${search}"
											class="page-link">다음</a></li>
									</c:if>

								</ul>
							</div>
						</c:if>
					</div>
            </div>
        </div>
    </div>
</div>
<jsp:include page="../../_layouts/public/scripts.jsp"/>
</body>
</html>
