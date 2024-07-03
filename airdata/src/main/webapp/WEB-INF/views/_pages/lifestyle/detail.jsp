<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri='http://java.sun.com/jsp/jstl/core'%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

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
        <jsp:include page="../../_layouts/public/sidebar.jsp"/>
        <div id="page-content--sub" class="col-12 col-lg-9 col-xxl-10 offset-lg-3 offset-xxl-2 p-3">
            <header class="page-subject">
				<h2>라이프스타일 상세</h2>
				<p>${error}</p>
			</header>
            <div class="row">
				<div class="my-3">
					<h2 class="">${lifestyle.subject }</h2>
				</div>
				<div class="my-3">
					<h6 style="color: grey;">${lifestyle.category } | ${lifestyle.tags }</h6>
				</div>
				<div class="my-3">
					<img src="${lifestyle.thumbnail }" style="object-fit:cover;" onerror="" alt="thumbnail">
				</div>
				<div class="my-10">
					<textarea id="content" class="form-control form-control-lg mytextarea"
							readonly="readonly">${lifestyle.content }</textarea>
				</div>
				
				<div class="row">
					<div class="col-4">
						<a href="/lifestyle" class="btn btn-primary me-1">목록으로</a>
						<sec:authorize access="isAuthenticated()">
							<a href="/admin/lifestyle/modify/${lifestyle.id}" class="btn btn-primary me-1">수정하기</a>
							<a href="/admin/lifestyle/delete/${lifestyle.id}" class="btn btn-primary me-1">삭제</a>
						</sec:authorize>
						<sec:authorize access="!isAuthenticated()">
							<a href="/edit/register/${lifestyle.id}" class="btn btn-primary me-1">수정요청</a>
							<a href="/edit/register" class="btn btn-primary me-1">등록신청</a>
						</sec:authorize>
					</div>
					<div class="col-4"></div>
					<div class="col-4 d-flex justify-content-end">
						<button id="previousBtn" class="btn btn-primary me-1">이전으로</button>
					</div>
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
