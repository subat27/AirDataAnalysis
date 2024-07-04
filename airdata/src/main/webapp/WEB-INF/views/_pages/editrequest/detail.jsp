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
					<h2>${action }요청확인</h2>
					<p>${error}</p>
				</header>
				<div class="row">
					<hr>
					<div class="m-5">
						<h3>${editRequest.subject }</h3>
						<h5>${editRequest.name }님요청</h5>
						<div>${action }사유: ${editRequest.reason }</div>
						<textarea readonly="readonly" class="mytextarea">
							${editRequest.content }
						</textarea>
						<a href="/admin/edit/modify/${editRequest.id}" class="btn btn-primary">${action }하러가기</a>
						<a href="/admin/edit/delete/${editRequest.id}" class="btn btn-primary">삭제</a>
						<button id="previousBtn" class="btn btn-primary me-1">이전으로</button>
					</div>
				</div>
			</div>
		</div>
	</div>


	<jsp:include page="../../_layouts/public/scripts.jsp" />
	<script type="text/javascript" src="${pageContext.request.contextPath}/assets/scripts/modules.js"></script>
	<script>
		tinymce.init({
			selector : '.mytextarea', // TinyMCE를 적용할 textarea요소의 선택자 지정
			license_key : 'gpl',
			statusbar : false,
			promotion : false,
			automatic_uploads : true,
			menu : {
				edit : {
					title : 'Edit',
					items : 'undo, redo, selectall, image'
				}
			},
			readonly: true,
			toolbar: false,
			menubar: false
		});
	</script>
</body>
</html>
