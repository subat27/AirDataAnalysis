<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div id="navigation-wrapper" class="d-flex flex-column p-5">
    <section class="brand">
        <h1 class="brand">
            <a href="${pageContext.request.contextPath}" class="logo-default">the Blue sky wellness</a>
        </h1>
    </section>
    <section class="navigation">
        <nav>
            <ul>
                <li class="nav-item my-2">
                    <a href="${pageContext.request.contextPath}/">처음으로</a>
                </li>
                <li class="nav-item my-2">
                    <a href="${pageContext.request.contextPath}/information">미세먼지 예보</a>
                </li>
                <li class="nav-item my-2">
                    <a href="${pageContext.request.contextPath}/lifestyle">라이프 스타일</a>
                </li>
                <li class="nav-item my-2">
                    <a href="${pageContext.request.contextPath}/products">추천 상품</a>
                </li>
            </ul>
        </nav>
    </section>
    <section class="footer">
        <p class="m-0 fs-9">
            Copyright&copy;2024 네잎클로버 데이터랩.
            All rights reserved.
        </p>
    </section>
    <section class="banner">
        <div class="banner-250p">
            <a href="#">
                <img src="${pageContext.request.contextPath}/assets/images/banner_250p.jpg" alt="banner-240p"/>
            </a>
        </div>
    </section>
</div>