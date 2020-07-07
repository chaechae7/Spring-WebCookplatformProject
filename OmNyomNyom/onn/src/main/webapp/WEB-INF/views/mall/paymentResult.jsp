<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:requestEncoding value="utf-8" />
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="구매정보 확인" name="pageTitle" />
</jsp:include>

<!-- Event Details Section -->
<link rel="stylesheet" 	href="${pageContext.request.contextPath }/resources/css/mall_delivery_info.css" />
<link rel="stylesheet" 	href="${pageContext.request.contextPath }/resources/css/class_reservation.css" />
<section class="event-details-section spad overflow-hidden">
	<div class="tm-section-2">
		<div class="container">
			<div class="row">
				<div class="col text-center">
					<h2 class="tm-section-title">뇸뇸몰</h2>
					<p class="tm-color-white tm-section-subtitle">신선한 식재료만을 추구합니다<span class=""></span></p>
				</div>
			</div>
		</div>
	</div>


	<div class="tm-section tm-position-relative">
		<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"
			preserveAspectRatio="none" class="tm-section-down-arrow">
                    <polygon fill="#4949e7" points="0,0  100,0  50,60"></polygon>
                </svg>
		<div class="container tm-pt-5 tm-pb-4">
			<div class="wizard">
              	<a><span class="badge">01</span>장바구니</a> 
              	<a><span class="badge">02</span> 선택된 상품 리스트</a> 
				<a><span class="badge">03</span>결제 정보</a> 
				<a class="current badge-inverse"><span class="badge ">04</span>결제 완료</a>
            </div>
		</div>


		<!-- 결제 결과화면-->
		<div class="container col-md-12 ">
                <div class="row text-center ">
                    <article class=" col-xl-12 ">
                        <h3>결제가 완료되었습니다.</h3><br>뇸뇸몰을 이용해 주셔서 감사합니다.</h3>
                        <!-- 이동버튼  -->
                        <br>
                        <br>
                        <a href="${pageContext.request.contextPath }" class=" tm-btn-white-bordered">메인화면</a>
                        &nbsp;&nbsp;&nbsp;&nbsp;
                        <a href="${pageContext.request.contextPath }/mypage/buyList" class=" tm-btn-white-bordered">결제목록</a>
                    </article>
			</div>
        </div>	
		<!-- 결제 결과화면-->
</section>
<!-- Event Details Section end -->

<script>
	var localUrl = "${pageContext.request.contextPath}"; 
	$(function () {
	    totalPrice();
	})
	
	
	function totalPrice(){
		let totalPrice = 0;
		$(".sb-area").find(".sum-price").each(function(index,item){
			let price = $(this).text();
	    	price = price.replace(/\,/g,"");
			totalPrice += Number(price);
		})
		$("#total_price").text(String(totalPrice).replace(/\B(?=(\d{3})+(?!\d))/g, ",")); 
	}
</script>




<jsp:include page="/WEB-INF/views/common/footer.jsp" />