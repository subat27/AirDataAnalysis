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
	<div id="wrapper" class="container-fluid">
		<div class="row">
			<jsp:include page="../../_layouts/public/sidebar.jsp" />
			<div id="page-content--sub"
				class="col-12 col-lg-9 col-xxl-10 offset-lg-3 offset-xxl-2 p-3">
				<header class="page-subject">
					<h2>장소 등록</h2>
					<p>${error}</p>
				</header>
				<div class="row">
					<div class="m-5">
						<form method="post" action="/admin/location/insert" enctype="multipart/form-data" id="registerForm">
							<div class="my-3">
								<label for="name" class="form-label">장소명</label>
								<input id="name" class="form-control form-control-lg" />
							</div>
							<div class="my-3">
								<label for="address" class="form-label">주소</label>
								<input id="address" class="form-control form-control-lg" />
							</div>
							<div class="my-3">
								<label for="tags" class="form-label">태그</label>
								<input id="tags" class="form-control form-control-lg" />
							</div>
							<div class="my-3">
								<label for="category" class="form-label">카테고리</label>
								<input id="category" class="form-control form-control-lg" />
							</div>
							<div class="my-3">
								<label for="thumbnail" class="form-label">썸네일</label>
								<input id="thumbnail" class="form-control form-control-lg" />
							</div>
						</form>
						<hr />
						<div class="my-3">
							<button type="submit" form="registerForm"
								class="btn btn-lg btn-dark">장소 등록</button>
							<button id="previousBtn" class="btn btn-lg btn-primary me-1">이전으로</button>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<jsp:include page="../../_layouts/public/scripts.jsp" />

	<script type="text/javascript"
		src="${pageContext.request.contextPath}/assets/scripts/modules.js"></script>
	<script>
		tinymce.init({
			selector : '.mytextarea', // TinyMCE를 적용할 textarea요소의 선택자 지정
			license_key : 'gpl',
			images_upload_url : '/uploader',
			plugins : 'image',
			statusbar : false,
			promotion : false,
			automatic_uploads : true,
			menu : {
				edit : {
					title : 'Edit',
					items : 'undo, redo, selectall, image'
				}
			},
			images_upload_handler : editor_imageUploader
		});
	</script>
	<script>
		$(document).ready(function() {
			$("#image").change(function() {
				let imgForm = document.getElementById("imageUpload");
				let formData = new FormData(imgForm);

				let token = $("meta[name='_csrf']").attr("content");
				let header = $("meta[name='_csrf_header']").attr("content");

				let uri = '/uploader';
				console.log(uri);

				$.ajax({
					type : "post",
					url : uri,
					dataType : "json",
					data : formData,
					processData : false,
					contentType : false,
					beforeSend : function(xhr) {
						xhr.setRequestHeader(header, token);
					},
					success : function(result) {
						$("#thumbnail").attr("value", result.location);
					},
					error : function() {
						console.log('통신실패');
					},
					complete : function() {
						console.log("끝");
					}
				});
			});
		});
	</script>
</body>
</html>
