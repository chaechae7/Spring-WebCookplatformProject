<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:requestEncoding value="utf-8"/>
<jsp:include page="/WEB-INF/views/common/header.jsp"> 
<jsp:param value="안녕 옴뇸뇸!" name="pageTitle"/>
</jsp:include>
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/class_reservation.css" />

 <!-- Event Details Section -->
    <section class="event-details-section spad overflow-hidden">
        <div class="tm-section-2">
            <div class="container">
                <div class="row">
                    <div class="col text-center">
                        <h2 class="tm-section-title">뇸뇸몰</h2>
                        <p class="tm-color-white tm-section-subtitle">신선한 식재료만을 추구합니다. </p>
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
                            <h3>결제가 완료되었습니다.</h3><br>뇸뇸몰을 이용해 주셔서 감사합니다.</h3>
                            <!-- 이동버튼  -->
                            <br>
                            <a href="index.html" class=" tm-btn-white-bordered">메인화면</a>
                            <a href="" class=" tm-btn-white-bordered">예약현황</a>
                        </article>

                    </div>
                </form>
            </div>
        </div>

    </section>
    <!-- Event Details Section end -->

<jsp:include page="/WEB-INF/views/common/footer.jsp" />
