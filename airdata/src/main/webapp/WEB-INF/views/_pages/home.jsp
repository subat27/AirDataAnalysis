<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <jsp:include page="../_layouts/public/meta.jsp"/>
    <jsp:include page="../_layouts/public/link.jsp"/>
    <title>Blue sky Wellness</title>
</head>
<body>
    <div id="wrapper" class="container-fluid">
        <div class="row">
            <jsp:include page="../_layouts/public/sidebar.jsp"/>
            <div class="col-12 col-lg-9 col-xxl-10 offset-lg-3 offset-xxl-2 p-0">
                <main id="page-content--main" class="page-content">
                    <section id="map" class="map"></section>
                </main>
            </div>
        </div>
    </div>
    <jsp:include page="../_layouts/public/scripts.jsp"/>
    <jsp:include page="../_layouts/public/map_main.jsp"/>
</body>
</html>
