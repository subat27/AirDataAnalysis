<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<script src="${pageContext.request.contextPath}/vendors/bootstrap-5.3.3-dist/js/bootstrap.bundle.min.js"></script>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="${pageContext.request.contextPath}/vendors/tinymce/js/tinymce/tinymce.min.js"></script>
<script>
	$(document).ready(function() {
		$("#previousBtn").click(function(){
			history.go(-1);
		})
	});
</script>