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
					<h2>라이프스타일 등록</h2>
					<p>${error}</p>
				</header>
				<div class="row">
					<div class="m-5">
						<form:form method="post"
							action="/lifestyle/modify/${editRequest.lifestyle.id}"
							modelAttribute="lifestyle" enctype="multipart/form-data">
							<div class="my-3">
								<form:label path="subject" cssClass="form-label">제목</form:label>
								<form:input path="subject"
									cssClass="form-control form-control-lg" />
								<form:errors path="subject" cssClass="invalid-feedback d-block" />
							</div>
							<div class="my-10">
								<form:label path="content" cssClass="form-label">원본 내용</form:label>
								<form:textarea path="content"
									cssClass="form-control form-control-lg mytextarea" />
								<form:errors path="content" cssClass="invalid-feedback d-block" />
							</div>
							<div class="my-10">
								<label for="editRequest" class="form-label">${action}요청
									내용</label>
								<textarea id="editRequest"
									class="form-control form-control-lg mytextarea">
									<p>${editRequest.name} 님 요청</p>
									<hr>
									<p>${action}사유 : ${editRequest.reason}</p>
									<hr>
									<p>${action}내용</p>
									${editRequest.content }
								</textarea>
							</div>
							<div class="my-3">
								<form:label path="tags" cssClass="form-label">해시태그</form:label>
								<form:input path="tags" cssClass="form-control form-control-lg" />
								<form:errors path="tags" cssClass="invalid-feedback d-block" />
							</div>
							<div class="my-3">
								<form:label path="category" cssClass="form-label">카테고리</form:label>
								<form:input path="category"
									cssClass="form-control form-control-lg" />
								<form:errors path="category" cssClass="invalid-feedback d-block" />
							</div>
							<div class="my-3">
								<input type="hidden" id="thumbnail" name="thumbnail"
									class="form-control form-control-lg" value="${thumbnail }" />
							</div>
							<hr />
							<div class="my-3">
								<button type="submit" class="btn btn-lg btn-dark">라이프스타일 ${action}</button>
								<button id="previousBtn" class="btn btn-lg btn-primary me-1">이전으로</button>
							</div>
						</form:form>
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
</body>
</html>
