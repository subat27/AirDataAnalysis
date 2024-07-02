<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<nav id="public-navigation" class="public-navigation">
    <div class="brand">
        <h1 class="logo">
            <a href="${pageContext.request.contextPath}/">
                Blue sky wellness
            </a>
        </h1>
    </div>
    <ul class="nav list-unstyled m-0 p-0">
        <li class="nav-item my-2">
            <a href="${pageContext.request.contextPath}/information">
                <i class="bi bi-cloud-haze2"></i>
                <span>미세먼지 예보</span>
            </a>
        </li>
        <li class="nav-item my-2">
            <a href="${pageContext.request.contextPath}/lifestyle">
                <i class="bi bi-cup-hot"></i>
                <span>라이프 스타일</span>
            </a>
        </li>
        <li class="nav-item my-2">
            <a href="${pageContext.request.contextPath}/products">
                <i class="bi bi-cart4"></i>
                <span>추천 상품</span>
            </a>
        </li>
    </ul>
    <div class="footer">
        <a href="${pageContext.request.contextPath}/">
            <img src="${pageContext.request.contextPath}/assets/images/banner_250p.jpg" alt=""/>
        </a>
        <p>
            Copyright &copy; 2024 네잎클로버 데이터랩.<br/>
            All rights reserved.
        </p>
    </div>
</nav>