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
			        	<h1 class="h2">상품 ${actionName}</h1>
			        </div>
			        <div class="row">
			        	<div class="col-12">
			        		<form:form method="post" action="${action}" modelAttribute="product">
				        		<div class="row">
				        			<div class="col-12 mb-4">
				        				<form:label path="subject" cssClass="form-label">상품명</form:label>
				        				<form:input path="subject" cssClass="form-control form-control-lg rounded-0"/>
				        				<form:errors path="subject" cssClass="invalid-feedback d-block"/>
				        			</div>
			        			</div>
			        			<div class="row">
				        			<div class="col-4 mb-4">
				        				<form:label path="price" cssClass="form-label">가격</form:label>
				        				<form:input path="price" cssClass="form-control form-control-lg rounded-0"/>
				        				<form:errors path="price" cssClass="invalid-feedback d-block"/>
				        			</div>
				        			<div class="col-4 mb-4">
				        				<form:label path="tags" cssClass="form-label">태그(콤마로 구분)</form:label>
				        				<form:input path="tags" cssClass="form-control form-control-lg rounded-0"/>
				        				<form:errors path="tags" cssClass="invalid-feedback d-block"/>
				        			</div>
				        			<div class="col-4 mb-4">
				        				<form:label path="category" cssClass="form-label">카테고리</form:label>
				        				<form:input path="category" cssClass="form-control form-control-lg rounded-0"/>
				        				<form:errors path="category" cssClass="invalid-feedback d-block"/>
				        			</div>
			        			</div>
			        			<div class="row">
				        			<div class="col-12 mb-4">
				        				<form:label path="link" cssClass="form-label">구매 링크</form:label>
				        				<form:input path="link" cssClass="form-control form-control-lg rounded-0"/>
				        				<form:errors path="link" cssClass="invalid-feedback d-block"/>
				        			</div>
			        			</div>
			        			<div class="row">
				        			<div class="mb-4">
				        				<form:label path="content" cssClass="form-label">소개 및 내용</form:label>
				        				<form:textarea path="content"/>
				        				<form:errors path="content" cssClass="invalid-feedback d-block"/>
				        			</div>
			        			</div>
			        			<div class="row">
				        			<div class="my-4">
				        				<button type="submit" class="btn btn-dark rounded-0">상품 ${actionName}</button>
				        			</div>
				        		</div>
			        		</form:form>
			        	</div>
			        </div>
				</main>
		    </div>
	    </div>
    </div>
    <jsp:include page="../../../_layouts/admin/scripts.jsp"/>
    <script type="text/javascript" src="${pageContext.request.contextPath}/vendors/tinymce/js/tinymce/tinymce.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/assets/scripts/modules.js"></script>
    <script type="text/javascript">
		tinymce.init({
			selector: 'textarea#content',
		  	license_key: 'gpl',
		  	images_upload_url: '/uploader',
		  	plugins: 'image',
		  	statusbar: false,
		  	promotion: false,
		  	automatic_uploads: true,
		  	menu: {
		    	edit: { title: 'Edit', items: 'undo, redo, selectall, image' }
		  	},
		  	images_upload_handler: editor_imageUploader
		});
    </script>
</body>
</html>
