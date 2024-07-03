<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib uri='http://java.sun.com/jsp/jstl/core' prefix='c'%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <jsp:include page="../../_layouts/admin/meta.jsp"/>
    <jsp:include page="../../_layouts/admin/link.jsp"/>
    <title>Admin for Blue sky Wellness</title>
</head>
<body>
    <jsp:include page="../../_layouts/admin/partials/header.jsp"/>
    <div class="container-fluid">
	  	<div class="row">
			<div class="sidebar border border-right col-md-3 col-lg-2 p-0 bg-body-tertiary">
		    	<jsp:include page="../../_layouts/admin/partials/offcanvas.jsp"/>
			    <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4">
			    	<div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
			        	<h1 class="h2">Dashboard</h1>
			        </div>
				</main>
		    </div>
	    </div>
    </div>
    <jsp:include page="../../_layouts/admin/scripts.jsp"/>
</body>
</html>
