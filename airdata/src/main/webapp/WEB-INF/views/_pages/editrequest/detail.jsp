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
		<h2>${action }요청 확인</h2>
		<p>${error}</p>
	</header>
	<main>
		<hr>
		<div class="m-5">
			<h3>${editRequest.subject }</h3>
			<h5>${editRequest.name } 님 요청</h5>
			<div> ${action }사유 : ${editRequest.reason }</div>
			<textarea readonly="readonly" class="mytextarea">
				${editRequest.content }
			</textarea>
			<a href="/edit/modify/${editRequest.id}" class="btn btn-primary">${action }하러가기</a>
			<a href="/edit/delete/${editRequest.id}" class="btn btn-primary">삭제</a>
			
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
</body>
</html>
