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
		<h2>수정요청 확인</h2>
		<p>${error}</p>
	</header>
	<main>
		<hr>
		<div class="m-5">
			<h3>${editRequest.subject }</h3>
			<h5>${editRequest.name } 님 요청</h5>
			<div> 수정사유 : ${editRequest.reason }</div>
			<textarea readonly="readonly" class="mytextarea">
				${editRequest.content }
			</textarea>
			<a href="/lifestyle/modify/${editRequest.id}" class="btn btn-primary">수정하러가기</a>
			<a href="/edit/delete/${editRequest.id}" class="btn btn-primary">삭제</a>
			
		</div>
	</main>

	<jsp:include page="../../_layouts/public/scripts.jsp" />
	<script src="https://cdn.tiny.cloud/1/${tinymce }/tinymce/7/tinymce.min.js" referrerpolicy="origin"></script>
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
</body>
</html>
