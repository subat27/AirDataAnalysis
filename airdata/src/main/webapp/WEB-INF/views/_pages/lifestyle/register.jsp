<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib uri='http://java.sun.com/jsp/jstl/core' prefix='c'%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<jsp:include page="../../_layouts/public/meta.jsp" />
<meta name="_csrf" content="${_csrf.token}" />
<meta name="_csrf_header" content="${_csrf.headerName}" />
<jsp:include page="../../_layouts/public/link.jsp" />
<title>Blue sky Wellness</title>
</head>
<body>
	<header>
		<h2>라이프스타일 등록</h2>
		<p>${error}</p>
	</header>
	<main>
		<div class="m-5">
			<form:form method="post" action="/lifestyle/register"
				modelAttribute="lifestyle" enctype="multipart/form-data" id="registerForm">
				<div class="my-3">
					<form:label path="subject" cssClass="form-label">제목</form:label>
					<form:input path="subject" cssClass="form-control form-control-lg" />
					<form:errors path="subject" cssClass="invalid-feedback d-block" />
				</div>
				<div class="my-10">
					<form:label path="content" cssClass="form-label">내용</form:label>
					<form:textarea path="content"
						cssClass="form-control form-control-lg mytextarea" />
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
					<input type="hidden" id="thumbnail" name="thumbnail"
							class="form-control form-control-lg"/>
				</div>
			</form:form>
			<form id="imageUpload" action="/uploader" enctype="multipart/form-data" method="post">
				<div class="my-3">
					<label for="image" class="form-label">썸네일</label>
					<input type="file" name="file" id="image" class="form-control form-control-lg"
						onchange="thumbnailUpload()"/>
				</div>
			</form>
			<hr />
			<div class="my-3">
				<button type="submit" form="registerForm" class="btn btn-lg btn-dark">라이프스타일 등록</button>
			</div>
		</div>
	</main>
	<jsp:include page="../../_layouts/public/scripts.jsp" />
	
	<script type="text/javascript" src="${pageContext.request.contextPath}/assets/scripts/modules.js"></script>
	<script>
		tinymce.init({
			selector : '.mytextarea', // TinyMCE를 적용할 textarea요소의 선택자 지정
			license_key : 'gpl',
			images_upload_url: '/uploader',
			plugins: 'image',
			statusbar: false,
			promotion: false,
			automatic_uploads: true,
			menu: {
				edit: {title: 'Edit', items: 'undo, redo, selectall, image'}
			},
			images_upload_handler: editor_imageUploader
		});	
	</script>
	<script>
		function thumbnailUpload() {
			let imgForm = document.getElementById("imageUpload");
			let formData = new FormData(imgForm);
			
			let uri = '/uploader';
			console.log(uri);
			
			$.ajax({
				type: 'POST',
				url: uri,
				dataType: "text",
				data: formData,				
				processData: false,
				contentType: false,
				success: function(result){
					console.log(result["test"]);
					console.log(result.test);
				},
				error: function() {
					console.log('통신실패');
				},
				complete: function() {
					console.log("끝");
				}
			});
		}
	
	</script>
</body>
</html>
