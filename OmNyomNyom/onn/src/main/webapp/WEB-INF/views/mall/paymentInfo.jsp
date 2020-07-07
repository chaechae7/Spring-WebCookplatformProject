<%@page import="com.soda.onn.member.model.vo.Member"%>
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
<!-- 아임포트 결제 관련 스크립트-->
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
 <!-- 결제정보 js -->
    <script>
        let paymentResult = false;
        
        console.log("스크립트로딩시작부");
        
    	$(document).ready(function() {
            
    		//카카오페이 클릭 시 
       	    $('.paymentbtn').click(function() {
       	      var IMP = window.IMP; // 생략가능
       	      IMP.init('imp62410752');  // 가맹점 식별 코드
       	      	console.log("결제모듈 로딩");
       	       	IMP.request_pay({
      	        		pg : 'kakaopay', // 결제방식
      		            pay_method : 'card',	// 결제 수단
      		            popup : true,
      		            merchant_uid : 'merchant_' + new Date().getTime(),
      		           	name : '선택상품 주문 결제',	// order 테이블에 들어갈 주문명 혹은 주문 번호
      		            amount : tPrice,	// 결제 금액 
      		            buyer_email : '${memberLoggedIn.email}',	// 구매자 email
      		           	buyer_name :  '${memberLoggedIn.memberName}',	// 구매자 이름
      		            buyer_tel :  '${memberLoggedIn.phone}',	// 구매자 전화번호
      		            buyer_addr :  '${memberLoggedIn.address}',	// 구매자 주소
      		            buyer_postcode :  '',	// 구매자 우편번호
      		        }, function(rsp) {
      		          if ( rsp.success ) {
      		        	  
      		        	var msg = '결제가 완료되었습니다.';
	        			msg += ',결제 금액 : ' + rsp.paid_amount;
	        			msg += ',확인 버튼을 눌러 예약 확인페이지로 이동해주세요';
  		        		paymentResult = true;
	        			alert(msg);
	        			updatePaidData();
	        			
      		        } else {
      		            var msg = '결제에 실패하였습니다.';
      		            msg += '에러내용 : ' + rsp.error_msg;
      		            
      		            alert(msg);
      		    			     paymentResult = false;
      		        }
      		       
      	 		}); //아임포트 끝 
	        
       	    }); //click
		
           
           function updatePaidData(){
 	           let delMemo = $("#deliveryMemo").val();
 	           console.log(delMemo);
 	           
	           let sendData ={"tPrice" : tPrice, "delMemo" : delMemo};
	           
   	    		console.log("Tb_BuyLsit, TB_BuyNo, TB_dingdong 인서트, Tb_shoppingbasket delete");
      	      	$.ajax({
       	      	url: "${pageContext.request.contextPath }/mall/updatePaidData",
				method : "Post",
				data : sendData,	
				success : data =>{
					alert("결제 확인 페이지로 이동합니다.");
        			location.href = "${pageContext.request.contextPath }/mall/result";
				},
				error : (x,s,e) =>{
					console.log(x,s,e);
				}
      	      	});
       	   
           }
        }); //ready
        
   
   	console.log("스크립트로딩엔딩부");
    </script>
    
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
                   	<a ><span class="badge">02</span> 선택된 상품 리스트</a> 
					<a class="current badge-inverse"><span class="badge ">03</span>결제 정보</a> 
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
							<%-- 	<a href="${pageContext.request.contextPath }/mall/delivery"> --%>
								<!-- <button type="button" class="btn btn-primary mvToSelectedIngMall paymentbtn">집으로 주문하기</button>
								</a> -->
							</div>
						</div>
						<div class="row">
						<br />
						<br />
						<br />
						<br />
						<div class="col">
						</div>
                            <span class="input input--yoshiko"> 
							<!-- 클래스명 input --> 
								<input class="input__field input__field--yoshiko" type="text" id="input-class-name" name="name" value="${memberLoggedIn.memberName }" readonly/> 
								<!-- 클래스명 라벨 --> 
								<label class="input__label input__label--yoshiko" for="input-class-name"> 
									<span class="input__label-content input__label-content--yoshiko" data-content="수령자">수령자</span>
								</label>
							</span>
                            <!-- 배송지 주소 -->
                            <span class="input input--yoshiko">
                                <input class="input__field input__field--yoshiko" type="text" id="address" name="shipping_address" value="${memberLoggedIn.address }" readonly/>
                                <label class="input__label input__label--yoshiko" for="input-10">
                                    <span class="input__label-content input__label-content--yoshiko" data-content="배송지 주소">배송지 주소</span>
                                </label>
                            </span>
                            <!-- 연락처 -->
                            <span class="input input--yoshiko">
                                <input class="input__field input__field--yoshiko" type="text" id="phone" value="${memberLoggedIn.phone }" readonly/>
                                <label class="input__label input__label--yoshiko" for="input-10">
                                    <span class="input__label-content input__label-content--yoshiko" data-content="연락처">연락처</span>
                                </label>
                            </span>
                            <!-- 배송메모 -->
                            <span class="input input--yoshiko">
                                <input class="input__field input__field--yoshiko deliveryMemo" type="text" id="input-10 deliveryMemo" />
                                <label class="input__label input__label--yoshiko" for="input-10">
                                    <span class="input__label-content input__label-content--yoshiko" data-content="배송 메모">배송 메모</span>
                                </label>
                            </span>
						 	
						</div>
							<div class="col order">
							<%-- 	<a href="${pageContext.request.contextPath }/mall/delivery"> --%>
								<button type="button" class="btn btn-primary mvToSelectedIngMall paymentbtn">주문하기</button>
								</a>
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
	
	var tPrice = Number;
	function totalPrice(){
		let totalPrice = 0;
		$(".sb-area").find(".sum-price").each(function(index,item){
			let price = $(this).text();
	    	price = price.replace(/\,/g,"");
			totalPrice += Number(price);
		})
		tPrice = totalPrice;
		$("#total_price").text(String(totalPrice).replace(/\B(?=(\d{3})+(?!\d))/g, ",")); 
	}
</script>
<script src="${pageContext.request.contextPath }/resources/js/classie.js"></script>
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
          [].slice.call(document.querySelectorAll('input.input__field')).forEach(function(inputEl) {
              // in case the input is already filled..
              if (inputEl.value.trim() !== '') {
                  classie.add(inputEl.parentNode, 'input--filled');
              }
              // events:
              inputEl.addEventListener('focus', onInputFocus);
              inputEl.addEventListener('blur', onInputBlur);
          });

          function onInputFocus(ev) {
              classie.add(ev.target.parentNode, 'input--filled');
          }

          function onInputBlur(ev) {
              if (ev.target.value.trim() === '') {
                  classie.remove(ev.target.parentNode, 'input--filled');
              }
          }
      })();
  </script>



<jsp:include page="/WEB-INF/views/common/footer.jsp" />