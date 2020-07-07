<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:requestEncoding value="utf-8"/>
<jsp:include page="/WEB-INF/views/common/header.jsp"> 
<jsp:param value="안녕 옴뇸뇸!" name="pageTitle"/>
</jsp:include>
<!-- 해당 페이지 css -->
 <link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/class_reservation.css" />
<!--  -->
    <!-- Event Details Section -->
    <section class="event-details-section spad overflow-hidden">
        <div class="tm-section-2">
            <div class="container">
                <div class="row">
                    <div class="col text-center">
                        <h2 class="tm-section-title">원데이클래스</h2>
                        <p class="tm-color-white tm-section-subtitle">당신만의 특별한 경험을 응원합니다. </p>
                    </div>
                </div>
            </div>

        </div>

        <div class="tm-section tm-position-relative">
            <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100" preserveAspectRatio="none" class="tm-section-down-arrow">
                <polygon fill="#4949e7" points="0,0  100,0  50,60"></polygon>
            </svg>
            <div class="container tm-pt-5 tm-pb-4">


                <form action="" id="" method="POST">
                    <div class="row text-center ">
                        <article class=" col-xl-12 ">
                            <h3>원데이 클래스를 이용해 주셔서 감사합니다.</h3>
                            <div class="ticket">
                                <div class="stub">
                                    <div class="invite">${chefNick.memberNick}</div>
                                </div>
                                <div class="check">
                                    <div class="big">${oneday.onedayName }</div>
                                    <div class="number">${oneday.onedayclassNo }</div>
                                    <div class="info">
                                        <section>
                                            <div class="title">예약일</div>
                                            <div>${reservationrequest.regDate }</div>
                                        </section>
                                        <section>
                                            <div class="title">위치</div>
                                            <div>${oneday.addr}, ${oneday.detailedAddr } </div>
                                        </section>
                                        <section>
                                            <div class="title">셰프 문의처</div>
                                            <div>${chefNick.phone }</div>
                                        </section>
                                    </div>
                                </div>
                            </div>
                            <!-- 이동버튼  -->

                            <a href="${pageContext.request.contextPath }" class=" tm-btn-white-bordered">메인화면</a>
                            <a href="${pageContext.request.contextPath }/mypage/onedayList" class=" tm-btn-white-bordered">예약현황</a>
                        </article>

                    </div>
                </form>
            </div>
        </div>

    </section>
    <!-- Event Details Section end -->
<jsp:include page="/WEB-INF/views/common/footer.jsp" />
