<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <jsp:include page="../../_layouts/public/meta.jsp"/>
    <jsp:include page="../../_layouts/public/link.jsp"/>
    <title>Blue sky Wellness</title>
</head>
<body>
<div id="wrapper" class="container-fluid">
    <div class="row">
        <jsp:include page="../../_layouts/public/sidebar.jsp"/>
        <div id="page-content--sub" class="col-12 col-lg-9 col-xxl-10 offset-lg-3 offset-xxl-2 p-3">
            <header class="page-subject">
                <h2>장소</h2>
            </header>
            <div class="row">
            	<div class="my-3">
					<h2 class="">${location.name }</h2>
				</div>
				<div class="my-3">
					<h6 style="color: grey;">${location.category } | ${location.tags }</h6>
				</div>
				
				<div class="my-3">
					<img src="${location.thumbnail }" style="width:100%; height:auto; object-fit:cover;" onerror="" alt="thumbnail">
				</div>
				<div class="my-3">
					<p>${location.address }</p>
				</div>
				
				<div class="row">
					<div class="col-4">
						<a href="/location" class="btn btn-primary me-1">목록으로</a>
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
<jsp:include page="../../_layouts/public/scripts.jsp"/>
</body>
</html>
