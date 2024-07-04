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
					<h2>${actionName }요청</h2>
					<p>${error}</p>
				</header>
				<div class="row">
					<div class="m-5">
						<form:form method="post" action="${action }${lifestyleId }"
							modelAttribute="editRequest" enctype="multipart/form-data">
							<div class="my-3">
								<form:label path="subject" cssClass="form-label">제목</form:label>
								<form:input path="subject"
									cssClass="form-control form-control-lg" />
								<form:errors path="subject" cssClass="invalid-feedback d-block" />
							</div>
							<div class="my-3">
								<form:label path="name" cssClass="form-label">작성자명</form:label>
								<form:input path="name" cssClass="form-control form-control-lg" />
								<form:errors path="name" cssClass="invalid-feedback d-block" />
							</div>
							<div class="my-10">
								<form:label path="content" cssClass="form-label">내용</form:label>
								<form:textarea path="content"
									cssClass="form-control form-control-lg mytextarea" />
								<form:errors path="content" cssClass="invalid-feedback d-block" />
							</div>
							<div class="my-10">
								<label class="form-label my-2">${actionName }사유</label>
								<input name="reason" class="form-control form-control-lg"
									placeholder="${actionName } 요청 이유를 입력해 주십시오." />
							</div>
							<hr />
							<div class="my-3">
								<button type="submit" class="btn btn-lg btn-dark">${actionName }요청</button>
								<a href="/lifestyle/detail/${lifestyleId }" class="btn btn-lg btn-primary me-1">이전으로</a>
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
