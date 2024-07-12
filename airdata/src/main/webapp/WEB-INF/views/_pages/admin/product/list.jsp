<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib uri='http://java.sun.com/jsp/jstl/core' prefix='c'%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <jsp:include page="../../../_layouts/admin/meta.jsp"/>
    <jsp:include page="../../../_layouts/admin/link.jsp"/>
    <title>Admin for Blue sky Wellness</title>
</head>
<body>
    <jsp:include page="../../../_layouts/admin/partials/header.jsp"/>
    <div class="container-fluid">
	  	<div class="row">
			<div class="sidebar border border-right col-md-3 col-lg-2 p-0 bg-body-tertiary">
			
		    	<jsp:include page="../../../_layouts/admin/partials/offcanvas.jsp"/>
			    <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4">
			    	<div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
			        	<h1 class="h2">상품 목록</h1>
			        </div>
			        <form:form method="get" action="/admin/product/list">
				        <div class="row">
				        	<div class="col-12 col-md-3 my-1">
				        		<select id="t" name="t" class="form-select">
				        			<option value="">검색유형</option>
				        			<option value="subject">제목</option>
				        			<option value="content">내용</option>
				        		</select>
				        	</div>
				        	<div class="col-12 col-md-7 my-1">
				        		<input type="text" name="s" id="s" class="form-control">
				        	</div>
				        	<div class="col-12 col-md-2 my-1">
				        		<button type="submit" class="btn btn-dark w-100">검색</button>
				        	</div>	
				        </div>
			        </form:form>
			        <div class="row">
			        	<div class="col-12">
			        		<div class="table-responsive">
					        	<table class="table">
									<thead class="table-dark">
								    	<tr>
								    		<th>번호</th>
								    		<th>상품명</th>
								    		<th>가격</th>
								    		<th>등록일시</th>
								    		<th>작업</th>
								    	</tr>
								  	</thead>
								  	<tbody>
								    	<c:choose>
							        		<c:when test="${not empty items.content}">
							        			<c:forEach var="item" items="${items.content}">
								        			<tr>
								        				<td>${item.id}</td>
								        				<td>${item.subject}</td>
								        				<td>${item.price}</td>
								        				<td>${item.created}</td>
								        				<td>
								        					<a href="${pageContext.request.contextPath}/admin/product/${item.id}" class="btn btn-sm btn-dark">수정</a>
								        					<a href="${pageContext.request.contextPath}/admin/product/${item.id}" class="btn btn-sm btn-danger">삭제</a>
								        				</td>
								        			</tr>
							        			</c:forEach>
							        		</c:when>
							        		<c:otherwise>
							        			<tr>
							        				<td colspan="5">등록된 상품이 없습니다.</td>
							        			</tr>
							        		</c:otherwise>
							        	</c:choose>
								  	</tbody>
								</table>
							</div>
			        	</div>
			        </div>
			        <div class="row">
			        	<div class="col-12 py-3 border-t border-b d-flex justify-between">
			        		<a href="${pageContext.request.contextPath}/admin/product/add" class="btn btn-dark">상품 등록</a>
			        	</div>
			        </div>
			        <div class="row">
			        	<div class="col-12">
			        		<c:if test="${not empty items}">
		                        <div>
		                            <ul class="pagination justify-content-center">
		                                <c:if test="${currentPage gt 1}">
		                                    <li class="page-item">
		                                        <a href="<c:url value="${pageContext.request.contextPath}/admin/product?p=${currentPage - 1}&s=${search}&t=${type}"/>" class="page-link">이전</a>
		                                    </li>
		                                </c:if>
		                                <c:forEach var="page" begin="${start}" end="${end}">
		                                    <li class="page-item">
		                                        <a href="<c:url value="${pageContext.request.contextPath}/admin/product?p=${page}&s=${search}&t=${type}"/>" class="page-link <c:if test="${page eq currentPage}"> active </c:if>">${page}</a>
		                                    </li>
		                                </c:forEach>
		                                <c:if test="${currentPage lt totalPages}">
		                                    <li class="page-item">
		                                        <a href="<c:url value="${pageContext.request.contextPath}/admin/product?p=${currentPage + 1}&s=${search}&t=${type}"/>" class="page-link">다음</a>
		                                    </li>
		                                </c:if>
		                            </ul>
		                        </div>
		                    </c:if>
			        	</div>
			        </div>
			    </main>
			</div>
		</div>
	</div>
</body>
</html>