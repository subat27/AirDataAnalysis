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
					<h2>라이프스타일 수정</h2>
					<p>${error}</p>
				</header>
				<div class="row">
					<div class="m-5">
						<form:form method="post" modelAttribute="lifestyle"
							enctype="multipart/form-data" id="modifyForm">
							<div class="my-3">
								<form:label path="subject" cssClass="form-label">제목</form:label>
								<form:input path="subject"
									cssClass="form-control form-control-lg" />
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
								<form:input path="category"
									cssClass="form-control form-control-lg" />
								<form:errors path="category" cssClass="invalid-feedback d-block" />
							</div>
							<div class="my-3">
								<img src="${thumbnail }" onerror="" alt="thumbnail"> <input
									type="hidden" id="thumbnail" name="thumbnail"
									value="${thumbnail }" />
							</div>
						</form:form>
						<div class="my-3">
							<form id="imageUpload" action="/uploader"
								enctype="multipart/form-data" method="post">
								<label for="image" class="form-label">썸네일</label> <input
									type="file" name="file" id="image"
									class="form-control form-control-lg" value=${thumbnail } />
							</form>
						</div>
						<hr />
						<div class="my-3">
							<button type="submit" form="modifyForm"
								class="btn btn-lg btn-dark">라이프스타일 수정</button>
							<button id="previousBtn" class="btn btn-lg btn-primary me-1">이전으로</button>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<jsp:include page="../../_layouts/public/scripts.jsp" />
	<script>
		tinymce.init({
			selector : '.mytextarea', // TinyMCE를 적용할 textarea요소의 선택자 지정
			plugins: 'image code',
			toolbar: "undo redo | link image | code",
			image_title: true,
			automatic_uploads: true,
			file_picker_types: 'file image media',
			file_picker_callback: (cb, value, meta) => {
				const input = document.createElement('input');
			    input.setAttribute('type', 'file');
			    input.setAttribute('accept', 'image/*');
		
			    input.addEventListener('change', (e) => {
			      const file = e.target.files[0];
		
			      const reader = new FileReader();
			      reader.addEventListener('load', () => {
			        /*
			          Note: Now we need to register the blob in TinyMCEs image blob
			          registry. In the next release this part hopefully won't be
			          necessary, as we are looking to handle it internally.
			        */
			        const id = 'blobid' + (new Date()).getTime();
			        const blobCache =  tinymce.activeEditor.editorUpload.blobCache;
			        const base64 = reader.result.split(',')[1];
			        const blobInfo = blobCache.create(id, file, base64);
			        blobCache.add(blobInfo);
		
			        /* call the callback and populate the Title field with the file name */
			        cb(blobInfo.blobUri(), { title: file.name });
			      });
			      reader.readAsDataURL(file);
			    });
		
			    input.click();
			  },
			  content_style: 'body { font-family:Helvetica,Arial,sans-serif; font-size:16px }'		
		});	
	</script>
	<script>
		$(document).ready(function(){
			$("#image").change(function(){
				let imgForm = document.getElementById("imageUpload");
				let formData = new FormData(imgForm);
				
				let token = $("meta[name='_csrf']").attr("content");
				let header = $("meta[name='_csrf_header']").attr("content");
				
				let uri = '/uploader';
				console.log(uri);
				
				$.ajax({
					type: "post",
					url: uri,
					dataType: "json",
					data: formData,
					processData: false,
					contentType: false,
					beforeSend : function(xhr) {
						xhr.setRequestHeader(header, token);
					},
					success: function(result){
						$("#thumbnail").attr("value", result.location);
					},
					error: function() {
						console.log('통신실패');
					},
					complete: function() {
						console.log("끝");
					}
				});
			});
		});
	
	</script>
</body>
</html>
