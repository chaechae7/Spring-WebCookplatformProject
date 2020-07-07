<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:requestEncoding value="utf-8"/>
<jsp:include page="/WEB-INF/views/common/header.jsp"> 
<jsp:param value="안녕 옴뇸뇸!" name="pageTitle"/>
</jsp:include>
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/oneday_submenu_food.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/datepicker.min.css" />
    <script src="${pageContext.request.contextPath}/resources/js/datepicker.kr.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/datepicker.min.js"></script>
<style>
.classinfo h4{
	padding: 0 5px;
	overflow: hidden;
	text-overflow: ellipsis;
	white-space: nowrap;
}
</style>


<!-- Page top Section start -->
    <section class="page-top-section page-sp set-bg" data-setbg="">
        <div class="container">
            <div class="row">
                <div class="col-lg-7 m-auto text-white">
                    <h2>원데이 클래스</h2>
                    <p>여러분들이 원하는 클래스를 찾아보세요.</p>
                </div>
            </div>
        </div>
    </section>
    <!-- Page top Section end -->
    
    <div class="container">
        <div class="event-filter-warp">
            <div class="row">
                <!-- <div class="col-xl-2">
                    <p>원데이클래스 검색</p>
                </div> -->
                <div class="col-xl-12">
                    <form class="event-filter-form serach" method="post" action="${pageContext.request.contextPath }/oneday/oneday_search">
                  
                    <select class="ef-item circle-select" id="menuList" name="menuList">
                            <option value="">분류</option>
                            <option value="한식">한식</option>
                            <option value="양식">양식</option>
                            <option value="일식">일식</option>
                            <option value="중식">중식</option>
                            <option value="밀식">밀식</option>
                            <option value="기타식">기타식</option>
                        </select>
				
                        <div class="ef-item">
                            <i class="material-icons">event_available</i>
                           <!--  <input type="text" id="onedayTimeDate" name="onedayTimeDate" placeholder="날짜로 검색" class="event-date"> -->
							<input
									class="input__field input__field--yoshiko datepicker-here"
									type="text" id="input-date" name="onedayTimeDate" data-language='kr' data-date-format='yyyy/mm/dd'
									data-timepicker="false" autocomplete="off" />
                        </div>
                        <div class="ef-item">
                            <i class="material-icons">map</i>
                            <input type="text" id="detailedAddr" name="detailedAddr" placeholder="위치로 검색">
                        </div>
                        <div class="ef-item">
                            <i class="material-icons">search</i>
                            <input type="text" id="onedayName" name="onedayName" placeholder="검색어를 입력하세요">
                        </div>
                        <input class="site-btn sb-gradient" type="submit" value="클래스 검색">
                    </form>
                </div>
            </div>
        </div>
    </div>

    <!-- Events Section -->
    <section class="events-page-section spad">
        <div class="container">
            
            <!-- 클래스 목록들 start -->
            <div class="row">
            <c:forEach items="${selectAllList }" var="oneday" varStatus="vs">
                                
                <div class="col-md-3">
                    <div class="classes-item-warp">
                        <div class="classes-item item_rate">
                            <div class="ci-img">
                            <c:if test="${oneday.onedayImg != null}">
                                <img src="${pageContext.request.contextPath }/resources/upload/onedayclass/${oneday.onedayImg}" alt="클래스 사진">
                            </c:if>
                            <c:if test="${oneday.onedayImg == null }">
                            	 <img src="${pageContext.request.contextPath }/resources/images/onedayclassdefualtImg.PNG" alt="클래스 사진">
                            </c:if>
                            </div>
                            <div class="ci-text classinfo">
                                <h4>${oneday.onedayName}</h4>
                                <c:if test="${not empty oneday.onedayTimeList}">
                                <c:forEach items="${oneday.onedayTimeList }" var="tl">
                                <div class="ci-metas">
                                 <c:if test="${tl.onedayNoo eq oneday.onedayclassNo}">
                                    <div class="ci-meta"><i class="material-icons">event_available</i>${tl.onedayTimeDate }</div>
                                    <%-- <div class="ci-meta"><i class="material-icons">${tl.onedayNoo}</i></div> --%>
                                </c:if>
                                </div>
                                </c:forEach>
                                </c:if>
                                <p>${oneday.onedayclassNo}</p>
                            </div>
                            <div class="ci-bottom">
                                <div class="ci-author">
                                <c:forEach items="${chefList }" var="chef">
                                <c:if test="${oneday.memberId eq chef.chefId }">
                                	<c:if test="${chef.chefProfile != null}">
                                    <img src="${pageContext.request.contextPath }/resources/upload/profile/${chef.chefProfile}" alt="셰프 사진">
                               		</c:if>
                               		<c:if test="${chef.chefProfile == null }">
                               		<img src="${pageContext.request.contextPath }/resources/images/classes/author/1.jpg" alt="셰프 사진">
                               		</c:if>
                               	</c:if>	
                                </c:forEach>
                                    <div class="author-text">
                                    <c:forEach items="${memberList  }" var="member">
                                    <c:if test="${member.memberId eq oneday.memberId }">
                                        <h6>${member.memberNick }</h6>
                                    </c:if> 
                                    </c:forEach>   
                                        <p>${oneday.memberId }</p>
                                    </div>
                                </div>
                                <a href= "${pageContext.request.contextPath }/oneday/oneday_detail?onedayclassNo=${oneday.onedayclassNo}" class="site-btn sb-gradient">예약하기</a>
                            </div>
                        </div>
                    </div>
                </div>
                            
            </c:forEach>
            </div>
            <c:if test="${paging != null }">
						${paging}
			</c:if>
        </div>
    </section>
    <!-- Events Section end -->
    
<jsp:include page="/WEB-INF/views/common/footer.jsp" />
