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
                   	<a class="current badge-inverse"><span class="badge">02</span> 선택된 상품 리스트</a> 
					<a><span class="badge ">03</span>결제 정보</a> 
					<a><span class="badge ">04</span>결제 완료</a>
            </div>



		</div>
		<!-- 장바구니 시작 -->
		<div class="container col-md-12 basket">
			<div class="container">

				<div class="row border_bottom">
					<h4>결제할 상품</h4>
				</div>
				<br>

				<div class="row">
					<div class="col-md-12 ">
						<!--  -->
						<div class="row">
							<div class="container">
								<div class="row title">
									<div class="col-md-1">
									</div>
									<div class="col-md-9">상품정보</div>
									<div class="col-md-2">상품금액</div>

								</div>
								<hr>
								<c:forEach items="${paymentList }" var="ingMall">
									<div class="row sb-area">
										<div class="ckbox col-md-1">
										</div>
										<div class="col-md-2">
											<img class="p-img"
												src="${pageContext.request.contextPath }/resources/images/ingredient/${ingMall.mallEngPrCategory }/${ingMall.mallEngCdCategory }/${ingMall.prevImg }"
												alt="">
										</div>
										<div class="col-md-7">
											<div class="inner-col pline">
												<span class="p-name">${ingMall.ingMallName }</span> <span class="p-info">(${ingMall.minUnit }당, <span class="price"><fmt:formatNumber value="${ingMall.price }" pattern="#,###" /></span>원)</span>
											</div>
											<div class="inner-col">
												수량 : <span class="p-name">${ingMall.stock } </span>
											</div>
										</div>
										<div class="col-md-2 md-total-price">
										<span class="sum-price p-name">
										<fmt:formatNumber value="${ingMall.price * ingMall.stock }" pattern="#,###" /></span>원
										</div>
									</div>
								</c:forEach>
							</div>

						</div>
						<!--  -->
						<div class="row font-17 lline">
							<div class="col total-price">
								<div>
									전체 상품 가격 <span id="total_price">  </span>원
								</div>
							</div>
							<div class="col order">
								<a href="${pageContext.request.contextPath }/mall/paymentInfo">
								<button type="button" class="btn btn-primary mvToSelectedIngMall">다음</button>
								</a>
							</div>
						</div>

					</div>
				</div>
			</div>
		</div>
		<!-- 장바구니 끝  -->
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