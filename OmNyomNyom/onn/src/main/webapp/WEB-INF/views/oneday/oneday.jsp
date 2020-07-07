<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:requestEncoding value="utf-8"/>

<jsp:include page="/WEB-INF/views/common/header.jsp"> 
	<jsp:param value="안녕 옴뇸뇸!" name="pageTitle"/>
</jsp:include>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/chefList.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/datepicker.min.css" />	
<style>
.onedaycard p, h4 {
	padding: 0 5px;
	overflow: hidden;
	text-overflow: ellipsis;
	white-space: nowrap;
}
.classinfo h6{
	padding: 0 5px;
	overflow: hidden;
	text-overflow: ellipsis;
	white-space: nowrap;
}
.onedaycard .onedayContentst{
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


<!-- 원데이 클래스 검색 -->
<script>
function oneday_search(){
	location.href="${pageContext.request.contextPath }/oneday/oneday_search";
}
</script>

    <section class="page-top-section page-sp set-bg" data-setbg="">
        <div class="container">
            <div class="row">
                <div class="col-lg-7 m-auto text-white">
                    <h2>원데이 클래스</h2>
                </div>
            </div>
        </div>
    </section>

    <div class="container">
        <div class="event-filter-warp">
            <div class="row">
                
                <div class="col-xl-12">
                    <form class="event-filter-form viewGo" method="get" action="${pageContext.request.contextPath }/oneday/oneday_All" style="text-align: center;">
                        
                        <input class="site-btn sb-gradient" type="submit" value="원데이 클래스 자세히보기">
                    </form>
                </div>
            </div>
        </div>
    </div>
    <!-- Page top Section -->
    <!-- 원데이 클래스 Section -->
    <section class="classes-section spad">
    
        <div class="container">
            <div class="section-title text-center">
                <h2>인기 클래스</h2>
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
    <section class="review-section spad set-bg" data-setbg="img/review-bg.jpg">
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

    <!-- 원데이 클래스 Section -->
    <section class="classes-section spad">
        <div class="container">
            <div class="section-title text-center">
                <h2>신규 클래스</h2>
                <p>영상에서 부족했던 부분을 오프라인에서 해결해 보세요. 인기있는 셰프님과의 만남을 가져보세요.</p>
            </div>
            
            <div class="classes-slider owl-carousel">
           <c:forEach items="${AllList }" var="oneday" end="5">
      
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
    
    <script src="${pageContext.request.contextPath}/resources/js/datepicker.kr.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/datepicker.min.js"></script>
 <script>
		(function() {
			// trim polyfill : https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/String/Trim
			if (!String.prototype.trim) {
				(function() {
					// Make sure we trim BOM and NBSP
					var rtrim = /^[\s\uFEFF\xA0]+|[\s\uFEFF\xA0]+$/g;
					String.prototype.trim = function() {
						return this.replace(rtrim, '');
					};
				})();
			}
			[].slice.call( document.querySelectorAll( 'input.input__field' ) ).forEach( function( inputEl ) {
				// in case the input is already filled..
				if( inputEl.value.trim() !== '' ) {
					classie.add( inputEl.parentNode, 'input--filled' );
				}
				// events:
				inputEl.addEventListener( 'focus', onInputFocus );
				inputEl.addEventListener( 'blur', onInputBlur );
			} );
			function onInputFocus( ev ) {
				classie.add( ev.target.parentNode, 'input--filled' );
			}
			function onInputBlur( ev ) {
				if( ev.target.value.trim() === '' ) {
					classie.remove( ev.target.parentNode, 'input--filled' );
				}
			}
		})();
	</script>

   

<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
