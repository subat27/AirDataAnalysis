<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <jsp:include page="../_layouts/public/meta.jsp"/>
    <jsp:include page="../_layouts/public/link.jsp"/>
    <title>Blue sky Wellness</title>
</head>
<body>
    <div id="page-public">
        <jsp:include page="../_layouts/public/navigation.jsp"/>
        <main id="public-content" class="public-content">
            <section id="public-main--brand" class="content-section section-padding mobile--brand">
                <h1 class="logo">
                    <a href="${pageContext.request.contextPath}/">
                        Blue sky wellness
                    </a>
                </h1>
            </section>
            
            <section id="public-main--intro" class="content-section public-main--intro">
                <div class="text">
                    <p>
                        <span class="sub-title">
                            Blue sky wellness
                        </span>
                        <span class="main-title">
                            <strong>먼지 때문에 흔들리는 일상은 그만.</strong><br/>
                            나만의 똑부러지는 라이프스타일, 블루스카이 웰니스.
                        </span>
                    </p>
                    <p>
                        블루스카이 웰니스는 미세먼지 예보를 기반으로
                        맞춤형 라이프스타일을 추천해 드립니다.
                        실시간 공기질 정보를 제공하여 건강한 일상을 유지할 수 있도록
                        도와드립니다. <br/>
                        똑부러지는 라이프스타일,
                        이제 블루스카이 웰니스와 함께하세요.
                    </p>
                </div>
                <div class="image">
                    <img src="${pageContext.request.contextPath}/assets/images/main_intro.jpg" alt="블루스카이 웰니스에 오신 것을 환영합니다."/>
                </div>
            </section>
            <section id="public-main--map" class="content-section public-main--map">
                	<div id="map-view"></div>
            	</section>
            <section id="public-main--dust" class="content-section section-padding public-main--dust">
                <jsp:include page="../_layouts/public/pm_avg.jsp">
			    	<jsp:param value="${averagePmValues}" name="averagePmValues"/>
			    </jsp:include>
            </section>
            <section id="public-main--product" class="content-section section-padding public-main--lifestyle">
                <div class="subject">
                    <strong>이런 상품은 어떠세요?</strong>
                </div>
                <ul class="row m-0 p-0 list-unstyled">
                    <li class="col-12 col-md-6 col-xl-4">
                       <div class="card border-light-subtle">
                           <div class="card-body overflow-hidden">
                               <img src="${pageContext.request.contextPath}/assets/images/no_image.jpg" alt=""/>
                           </div>
                           <div class="card-footer border-light-subtle">
                               <span class="category">카테고리명</span>
                               <strong class="product-name">상품명</strong>
                               <span class="price">
                                   <strong>1,234,567</strong>
                                   <small>원</small>
                               </span>
                               <a href="#" class="nav-link">구매하러 가기 +</a>
                           </div>
                       </div>
                    </li>
                    <li class="col-12 col-md-6 col-xl-4">
                        <div class="card border-light-subtle">
                            <div class="card-body overflow-hidden">
                                <img src="${pageContext.request.contextPath}/assets/images/no_image.jpg" alt=""/>
                            </div>
                            <div class="card-footer border-light-subtle">
                                <span class="category">카테고리명</span>
                                <strong class="product-name">상품명</strong>
                                <span class="price">
                                   <strong>1,234,567</strong>
                                   <small>원</small>
                               </span>
                                <a href="#" class="nav-link">구매하러 가기 +</a>
                            </div>
                        </div>
                    </li>
                    <li class="col-12 col-md-6 col-xl-4">
                        <div class="card border-light-subtle">
                            <div class="card-body overflow-hidden">
                                <img src="${pageContext.request.contextPath}/assets/images/no_image.jpg" alt=""/>
                            </div>
                            <div class="card-footer border-light-subtle">
                                <span class="category">카테고리명</span>
                                <strong class="product-name">상품명</strong>
                                <span class="price">
                                   <strong>1,234,567</strong>
                                   <small>원</small>
                               </span>
                                <a href="#" class="nav-link">구매하러 가기 +</a>
                            </div>
                        </div>
                    </li>
                    <li class="col-12 col-md-6 col-xl-4">
                        <div class="card border-light-subtle">
                            <div class="card-body overflow-hidden">
                                <img src="${pageContext.request.contextPath}/assets/images/no_image.jpg" alt=""/>
                            </div>
                            <div class="card-footer border-light-subtle">
                                <span class="category">카테고리명</span>
                                <strong class="product-name">상품명</strong>
                                <span class="price">
                                   <strong>1,234,567</strong>
                                   <small>원</small>
                               </span>
                                <a href="#" class="nav-link">구매하러 가기 +</a>
                            </div>
                        </div>
                    </li>
                    <li class="col-12 col-md-6 col-xl-4">
                        <div class="card border-light-subtle">
                            <div class="card-body overflow-hidden">
                                <img src="${pageContext.request.contextPath}/assets/images/no_image.jpg" alt=""/>
                            </div>
                            <div class="card-footer border-light-subtle">
                                <span class="category">카테고리명</span>
                                <strong class="product-name">상품명</strong>
                                <span class="price">
                                   <strong>1,234,567</strong>
                                   <small>원</small>
                               </span>
                                <a href="#" class="nav-link">구매하러 가기 +</a>
                            </div>
                        </div>
                    </li>
                    <li class="col-12 col-md-6 col-xl-4">
                        <div class="card border-light-subtle">
                            <div class="card-body overflow-hidden">
                                <img src="${pageContext.request.contextPath}/assets/images/no_image.jpg" alt=""/>
                            </div>
                            <div class="card-footer border-light-subtle">
                                <span class="category">카테고리명</span>
                                <strong class="product-name">상품명</strong>
                                <span class="price">
                                   <strong>1,234,567</strong>
                                   <small>원</small>
                               </span>
                                <a href="#" class="nav-link">구매하러 가기 +</a>
                            </div>
                        </div>
                    </li>
                </ul>
            </section>
            <section id="public-main--place" class="content-section section-padding public-main--lifestyle">
                <div class="subject">
                    <strong>오늘같은 날 추천하는 장소에요.</strong>
                </div>
                <ul class="row m-0 p-0 list-unstyled">
                    <li class="col-12 col-md-6 col-xl-4">
                        <div class="card border-light-subtle">
                            <div class="card-body overflow-hidden">
                                <img src="${pageContext.request.contextPath}/assets/images/no_image.jpg" alt=""/>
                            </div>
                            <div class="card-footer border-light-subtle">
                                <span class="category">카테고리명</span>
                                <strong class="product-name">상품명</strong>
                                <span class="price">
                                   <strong>1,234,567</strong>
                                   <small>원</small>
                               </span>
                                <a href="#" class="nav-link">구매하러 가기 +</a>
                            </div>
                        </div>
                    </li>
                    <li class="col-12 col-md-6 col-xl-4">
                        <div class="card border-light-subtle">
                            <div class="card-body overflow-hidden">
                                <img src="${pageContext.request.contextPath}/assets/images/no_image.jpg" alt=""/>
                            </div>
                            <div class="card-footer border-light-subtle">
                                <span class="category">카테고리명</span>
                                <strong class="product-name">상품명</strong>
                                <span class="price">
                                   <strong>1,234,567</strong>
                                   <small>원</small>
                               </span>
                                <a href="#" class="nav-link">구매하러 가기 +</a>
                            </div>
                        </div>
                    </li>
                    <li class="col-12 col-md-6 col-xl-4">
                        <div class="card border-light-subtle">
                            <div class="card-body overflow-hidden">
                                <img src="${pageContext.request.contextPath}/assets/images/no_image.jpg" alt=""/>
                            </div>
                            <div class="card-footer border-light-subtle">
                                <span class="category">카테고리명</span>
                                <strong class="product-name">상품명</strong>
                                <span class="price">
                                   <strong>1,234,567</strong>
                                   <small>원</small>
                               </span>
                                <a href="#" class="nav-link">구매하러 가기 +</a>
                            </div>
                        </div>
                    </li>
                    <li class="col-12 col-md-6 col-xl-4">
                        <div class="card border-light-subtle">
                            <div class="card-body overflow-hidden">
                                <img src="${pageContext.request.contextPath}/assets/images/no_image.jpg" alt=""/>
                            </div>
                            <div class="card-footer border-light-subtle">
                                <span class="category">카테고리명</span>
                                <strong class="product-name">상품명</strong>
                                <span class="price">
                                   <strong>1,234,567</strong>
                                   <small>원</small>
                               </span>
                                <a href="#" class="nav-link">구매하러 가기 +</a>
                            </div>
                        </div>
                    </li>
                    <li class="col-12 col-md-6 col-xl-4">
                        <div class="card border-light-subtle">
                            <div class="card-body overflow-hidden">
                                <img src="${pageContext.request.contextPath}/assets/images/no_image.jpg" alt=""/>
                            </div>
                            <div class="card-footer border-light-subtle">
                                <span class="category">카테고리명</span>
                                <strong class="product-name">상품명</strong>
                                <span class="price">
                                   <strong>1,234,567</strong>
                                   <small>원</small>
                               </span>
                                <a href="#" class="nav-link">구매하러 가기 +</a>
                            </div>
                        </div>
                    </li>
                    <li class="col-12 col-md-6 col-xl-4">
                        <div class="card border-light-subtle">
                            <div class="card-body overflow-hidden">
                                <img src="${pageContext.request.contextPath}/assets/images/no_image.jpg" alt=""/>
                            </div>
                            <div class="card-footer border-light-subtle">
                                <span class="category">카테고리명</span>
                                <strong class="product-name">상품명</strong>
                                <span class="price">
                                   <strong>1,234,567</strong>
                                   <small>원</small>
                               </span>
                                <a href="#" class="nav-link">구매하러 가기 +</a>
                            </div>
                        </div>
                    </li>
                </ul>
            </section>
            <section id="public-main--lifestyle" class="content-section section-padding public-main--lifestyle">
                <div class="subject">
                    <strong>오늘은 이걸 해 보세요!</strong>
                </div>
                <ul class="row m-0 p-0 list-unstyled">
                    <li class="col-12 col-md-6 col-xl-4">
                        <div class="card border-light-subtle">
                            <div class="card-body overflow-hidden">
                                <img src="${pageContext.request.contextPath}/assets/images/no_image.jpg" alt=""/>
                            </div>
                            <div class="card-footer border-light-subtle">
                                <span class="category">카테고리명</span>
                                <strong class="product-name">상품명</strong>
                                <span class="price">
                                   <strong>1,234,567</strong>
                                   <small>원</small>
                               </span>
                                <a href="#" class="nav-link">구매하러 가기 +</a>
                            </div>
                        </div>
                    </li>
                    <li class="col-12 col-md-6 col-xl-4">
                        <div class="card border-light-subtle">
                            <div class="card-body overflow-hidden">
                                <img src="${pageContext.request.contextPath}/assets/images/no_image.jpg" alt=""/>
                            </div>
                            <div class="card-footer border-light-subtle">
                                <span class="category">카테고리명</span>
                                <strong class="product-name">상품명</strong>
                                <span class="price">
                                   <strong>1,234,567</strong>
                                   <small>원</small>
                               </span>
                                <a href="#" class="nav-link">구매하러 가기 +</a>
                            </div>
                        </div>
                    </li>
                    <li class="col-12 col-md-6 col-xl-4">
                        <div class="card border-light-subtle">
                            <div class="card-body overflow-hidden">
                                <img src="${pageContext.request.contextPath}/assets/images/no_image.jpg" alt=""/>
                            </div>
                            <div class="card-footer border-light-subtle">
                                <span class="category">카테고리명</span>
                                <strong class="product-name">상품명</strong>
                                <span class="price">
                                   <strong>1,234,567</strong>
                                   <small>원</small>
                               </span>
                                <a href="#" class="nav-link">구매하러 가기 +</a>
                            </div>
                        </div>
                    </li>
                    <li class="col-12 col-md-6 col-xl-4">
                        <div class="card border-light-subtle">
                            <div class="card-body overflow-hidden">
                                <img src="${pageContext.request.contextPath}/assets/images/no_image.jpg" alt=""/>
                            </div>
                            <div class="card-footer border-light-subtle">
                                <span class="category">카테고리명</span>
                                <strong class="product-name">상품명</strong>
                                <span class="price">
                                   <strong>1,234,567</strong>
                                   <small>원</small>
                               </span>
                                <a href="#" class="nav-link">구매하러 가기 +</a>
                            </div>
                        </div>
                    </li>
                    <li class="col-12 col-md-6 col-xl-4">
                        <div class="card border-light-subtle">
                            <div class="card-body overflow-hidden">
                                <img src="${pageContext.request.contextPath}/assets/images/no_image.jpg" alt=""/>
                            </div>
                            <div class="card-footer border-light-subtle">
                                <span class="category">카테고리명</span>
                                <strong class="product-name">상품명</strong>
                                <span class="price">
                                   <strong>1,234,567</strong>
                                   <small>원</small>
                               </span>
                                <a href="#" class="nav-link">구매하러 가기 +</a>
                            </div>
                        </div>
                    </li>
                    <li class="col-12 col-md-6 col-xl-4">
                        <div class="card border-light-subtle">
                            <div class="card-body overflow-hidden">
                                <img src="${pageContext.request.contextPath}/assets/images/no_image.jpg" alt=""/>
                            </div>
                            <div class="card-footer border-light-subtle">
                                <span class="category">카테고리명</span>
                                <strong class="product-name">상품명</strong>
                                <span class="price">
                                   <strong>1,234,567</strong>
                                   <small>원</small>
                               </span>
                                <a href="#" class="nav-link">구매하러 가기 +</a>
                            </div>
                        </div>
                    </li>
                </ul>
            </section>
        </main>
    </div>
    <jsp:include page="../_layouts/public/scripts.jsp"/>
</body>
</html>
