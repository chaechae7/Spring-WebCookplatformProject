<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:requestEncoding value="utf-8"/>
<jsp:include page="/WEB-INF/views/common/header.jsp"> 
	<jsp:param value="안녕 옴뇸뇸!" name="pageTitle"/>
</jsp:include>
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/style.css" />
<style>
.toprecipe>h6{
	width: 180px;
	padding: 0 5px;
	overflow: hidden;
	text-overflow: ellipsis;
	white-space: nowrap;
	
}
.onedaycard h4{
	width: 340px;
	padding: 0 5px;
	overflow: hidden;
	text-overflow: ellipsis;
	white-space: nowrap;
}
.trainer-item .ti-img img{
	margin-top: -177px;
}
.onedayContentst{
	padding: 0 5px;
	overflow: hidden;
	text-overflow: ellipsis;
	white-space: nowrap;
	height: 90px;
}
.review{
	padding: 0 5px;
	overflow: hidden;
	text-overflow: ellipsis;
	white-space: nowrap;
	height: 90px;
}
</style>
 <!-- 로그인 메뉴 -->
    <!-- main.css, util.css추가 -->
    <!-- ${pageContext.request.contextPath }/resources/images/ui에 다수의 png 추가 -->

    <!-- 냉부해 슬라이드 -->
    <section class="hero-section">
        <div class="hero-social-warp">
            <div class="hero-social">
                <a href="#"><i class="fab fa-facebook-f"></i></a>
                <a href="#"><i class="fab fa-google"></i></a>
                <a href="#"><i class="fab fa-kickstarter-k"></i></a>
                <a href="#"><i class="fab fa-neos"></i></a>
            </div>
        </div>
        <div class="arrow-buttom">
            <img src="${pageContext.request.contextPath }/resources/images/icons/arrows-buttom.png" alt="">
        </div>
        <div class="hero-slider owl-carousel">
            <div class="hs-item">
                <div class="hs-style-1 text-center">
                    <img src="${pageContext.request.contextPath }/resources/images/hero-slider/main2.jpg" alt="">
                </div>
            </div>
            <div class="hs-item">
                <div class="hs-style-2">
                    <div class="container-fluid h-100">
                        <div class="row h-100">
                            <div class="col-lg-6 h-100 d-none d-lg-flex align-items-xl-end align-items-lg-center">
                                <div class="hs-img">
                                    <img src="${pageContext.request.contextPath }/resources/images/hero-slider/main4.jpg" alt="">
                                </div>
                            </div>
                            <div class="col-lg-6 d-flex align-items-center">
                                <div class="hs-text-warp">
                                    <div class="hs-text">
                                        <h2>냉장고를 부탁해</h2>
                                        <p>요리와 썸 타고 있는 당신을 위해 <br/>냉장고 속 재료들로 완벽한 한끼 식사를 추천해 드립니다. </p>
                                        <a class="site-btn sb-white" href="${pageContext.request.contextPath }/recipe/ingredientsSelection">냉장고 털어가기</a>
                                    	
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="hs-item">
                <div class="hs-style-3 text-center">
                    <div class="container">
                        <div class="hs-text">
                            <h2>레시피 속 재료</h2>
                            <p>레시피 영상 속 재료, 쿠킹박스, 주방도구가 확인 하고 원 클릭으로 내 집 앞으로 올 수 있게 실현해 보세요.
                                </p>
                                    <a class="site-btn sb-white" href="${pageContext.request.contextPath }/mall/main">구매하러 가기</a>
                        </div>
                    </div>
                    <div class="hs-img">
                        <img src="${pageContext.request.contextPath }/resources/images/hero-slider/food.png" alt="">
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- 냉부해 슬라이드 end -->


    <!-- 레시피 인기영상 Top6Section -->
    <section class="trainer-section overflow-hidden spad">
        <div class="container">
            <div class="section-title text-center">
                <h2>TODAY RECIPE</h2>
                <p>오늘 인기 있는 셔프 레시피 영상 TOP5!<br/>최근 인기 셰프 및 레시피 TOP6 입니다. 영상 속 레시피를 완벽한 한끼를 준비해 보세요.</p>
            </div>
            <div class="trainer-slider owl-carousel">
            <c:if test="${not empty popRecipe}">
            <c:forEach items="${popRecipe}" var="rec">
                <div class="ts-item">
                    <div class="trainer-item">
                        <div class="ti-img">
                            <a
							href="${pageContext.request.contextPath }/recipe/recipe-details?recipeNo=${rec.recipeNo }"><img
							src="https://img.youtube.com/vi/${rec.videoLink }/mqdefault.jpg" alt=""
							class="chef-Thumbnail"></a>
                        </div>
                        <div class="ti-text toprecipe">
                            <h6 style="color: black;">${rec.videoTitle }</h6>
                            <h6>조회수 : ${rec.viewCount }</h6>
                        </div>
                    </div>
                </div>
            </c:forEach>
            </c:if>    
            </div>
        </div>
    </section>
    <!-- 레시피 인기영상 Top6 Section end -->

    <!-- 원데이 클래스 Section -->
    <section class="classes-section spad">
    
        <div class="container">
            <div class="section-title text-center">
                <h2>ONEDAY CLASSES</h2>
                <p>영상에서 부족했던 부분을 오프라인에서 해결해 보세요. 인기있는 셰프님과의 만남을 가져보세요.</p>
            </div>
                        <div class="classes-slider owl-carousel">
    		<c:forEach items="${popList }" var="oneday" end="6">
                <div class="classes-item">
                    <div class="ci-img">
                         <img src="${pageContext.request.contextPath }/resources/upload/onedayclass/${oneday.onedayImg}" alt="클래스 사진">
                    </div>
                    <div class="ci-text onedaycard">
                        <h4><a href="classes-details.html">${oneday.onedayName }</a></h4>
                        <c:if test="${not empty oneday.onedayTimeList}">
                                <c:forEach items="${oneday.onedayTimeList }" var="tl">
                                <div class="ci-metas">
                                 <c:if test="${tl.onedayNoo eq oneday.onedayclassNo}">
                                    <div class="ci-meta" style="display: none;"><i class="material-icons">event_available</i>${tl.onedayTimeDate }</div>
                                    <%-- <div class="ci-meta"><i class="material-icons">${tl.onedayNoo}</i></div> --%>
                                </c:if>
                                </div>
                                </c:forEach>
                         </c:if>
                        <div class="onedayContentst">
                        <p>${oneday.onedayContent}</p>
                        </div> 
                    </div>
                    <div class="ci-bottom">
                        <div class="ci-author">
                        <c:forEach items="${chefList }" var="chef">
                        <c:if test="${oneday.memberId eq chef.chefId }">
                            <img src="${pageContext.request.contextPath }/resources/upload/profile/${chef.chefProfile}" alt="셰프 사진">
                        </c:if>
                        </c:forEach>
                            <div class="author-text classinfo">
                                <h6>${oneday.menuList }</h6>
                                <p>${oneday.memberId }</p>
                            </div>
                        </div>
						<a href= "${pageContext.request.contextPath }/oneday/oneday_detail?onedayclassNo=${oneday.onedayclassNo}" class="site-btn sb-gradient">예약하기</a>                    
                    </div>
  	              </div>
     		</c:forEach>   
            </div>
        </div>
    </section>
    <!-- 원데이 클래스 end -->
    <!-- Review Section -->
    <section class="review-section spad set-bg" data-setbg="${pageContext.request.contextPath }/resources/images/review-bg.jpg">
        <div class="container">
            <div class="row">
                <div class="col-lg-8 m-auto">
                    <div class="review-slider owl-carousel">
                        <c:forEach items="${reviewList }" var="review">
                        <div class="review-item">
                            <div class="ri-img">
                                <img src="${pageContext.request.contextPath }/resources/images/classes/author/1.jpg" alt="">
                            </div>
                            <div class="ri-text text-white">
				                <h6>${review.memberId }</h6>
				          <c:forEach items="${AllList }" var="oneday">
				          		<c:if test="${review.onedayclassNo eq oneday.onedayclassNo}">      
				                <h4>${oneday.onedayName }</h4>
				                </c:if>
				          </c:forEach>
				          <div class="review">     
				                <p>${review.reviewContent }</p>
				          </div>      
				              </div>
                        </div>
                        </c:forEach>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- Review Section end -->



<jsp:include page="/WEB-INF/views/common/footer.jsp" />
