<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <jsp:include page="../_layouts/public/meta.jsp"/>
    <jsp:include page="../_layouts/public/link.jsp"/>
    <title>Blue sky Wellness</title>
</head>
<body>
    <div id="page-public--main">
    	<aside>
    	
    	</aside>
    	<main>
	    	<section class="intro">
	    		<div class="slogan">
	    			<div class="brand">
	    				<h1 class="logo-default--simple">
	    					<a href="${pageContext.request.contextPath}/">
	    						Blue sky wellness
	    					</a>
	    				</h1>
	    			</div>
	    			<p class="slogan">
	    				<span class="subject">
		    				하늘은 먼지가 가득,<br>
		    				그러나 내 마음은 깨끗한 하늘!<br>
		    				<strong>블루스카이 웰니스</strong>
	    				</span>
	    				<span class="comment">
	    					더 이상 미세먼지 같은 불청객에 시달리지 마세요.<br/>
	    					스마트한 미세먼지 예보 기반으로 라이프스타일을 추천합니다!
	    				</span>
	    			</p>
	    			<div class="detail">
	    				<a href="/information">
	    					<span class="text">
	    						자세히 보러가기
	    					</span>
	    					<span class="icon">
	    						<i class="bi bi-forward-fill"></i>
	    					</span>
	    				</a>
	    			</div>
	    		</div>
	    		<div class="banner-image">
	    			<img src="${pageContext.request.contextPath}/assets/images/main_intro.jpg" alt=""/>
	    		</div>
	    	</section>
    	</main>
    </div>
    <jsp:include page="../_layouts/public/scripts.jsp"/>
    <jsp:include page="../_layouts/public/map_main.jsp"/>
</body>
</html>
