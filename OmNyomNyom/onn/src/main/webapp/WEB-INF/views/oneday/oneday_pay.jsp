<%@page import="com.soda.onn.oneday.model.vo.Oneday"%>
<%@page import="com.soda.onn.oneday.model.vo.Reservation"%>
<%@page import="com.soda.onn.oneday.model.vo.ReservationRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:requestEncoding value="utf-8"/>
<jsp:include page="/WEB-INF/views/common/header.jsp"> 
<jsp:param value="안녕 옴뇸뇸!" name="pageTitle"/>
</jsp:include>
<!--  원데이 pay  css -->
 <link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/class_reservation.css" />

<!-- 아임포트 결제 관련 스크립트-->
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
 <!-- 결제정보 js -->
    <script>
        let paymentResult = false;
        
        console.log("스크립트로딩시작부");
        
    	$(document).ready(function() {
            //현재HTML문서가 브라우저에 로딩이 끝났다면   
            $("div.select-pay").hide();
            
            //카카오페이 클릭 시 
       	    $('#card').click(function() {
       	      var IMP = window.IMP; // 생략가능
       	      IMP.init('imp62410752');  // 가맹점 식별 코드
       	      	console.log("인원체크")
       	     
       	      	let maxSeat = ${oneday.onedayMaxper };
       	      	let onedayNo= ${oneday.onedayclassNo};
       	      	let onedaytimeNo = ${reservationrequest.onedaytimeNo};
       	      	let ticketQty = ${reservationrequest.personnel};
       	      	let forwarding = {"onedayNo" : onedayNo, "onedaytimeNo" :onedaytimeNo};
       	      	console.log(forwarding, "===forwarding");
       	      //예약마감 체크하기 ajax로 실시간검사하여 return값 주기
       	      	$.ajax({
	       	      	url: "${pageContext.request.contextPath }/oneday/checkvacancy",
					dataType: "json",
					method : "get",
					data : forwarding,
					success : data =>{
						
					 if(data.reserved >= maxSeat ){
						 console.log(data.reserved, "이미 예약된 인원")
						 alert("잔여 좌석이 부족합니다. 다시 확인해주세요");
						 return;
					 }else if ( data.reserved+ticketQty > maxSeat){
						 console.log(data.reserve+ticketQty, "예약요청인원 ")
						 alert("잔여 좌석이 부족합니다. 다시 확인해주세요");
						 return;
					 }	
						 console.log(data.reserved, "이미 예약된 인원")
						 
						   
			       	      console.log("결제모듈 로딩");
			       	      	IMP.request_pay({
			      	        		pg : 'kakaopay', // 결제방식
			      		            pay_method : 'card',	// 결제 수단
			      		            popup : true,
			      		            merchant_uid : 'merchant_' + new Date().getTime(),
			      		           	name : '${oneday.onedayName} 예약결제',	// order 테이블에 들어갈 주문명 혹은 주문 번호
			      		            amount : '${reservationrequest.resPrice}',	// 결제 금액 
			      		            buyer_email : '${memberLoggedIn.email}',	// 구매자 email
			      		           	buyer_name :  '${memberLoggedIn.memberName}',	// 구매자 이름
			      		            buyer_tel :  '${memberLoggedIn.phone}',	// 구매자 전화번호
			      		            buyer_addr :  '${memberLoggedIn.address}',	// 구매자 주소
			      		            buyer_postcode :  '',	// 구매자 우편번호
			      		        }, function(rsp) {
			      		          if ( rsp.success ) {
			      		        	  
			      		        	var msg = '결제가 완료되었습니다.';
				        			msg += '  결제 금액 : ' + rsp.paid_amount;
				        			msg += ',  확인 버튼을 눌러 예약 확인페이지로 이동해주세요';
			  		        		paymentResult = true;
				        			alert(msg);
				        			insertReserv();
				        			
			      		        } else {
			      		            var msg = '결제에 실패하였습니다.';
			      		            msg += '에러내용 : ' + rsp.error_msg;
			      		            alert(msg);
			      		    			     paymentResult = false;
			      		        }
			      	 		}); //아임포트 끝 
					},
					error : (x,s,e) =>{
						console.log(x,s,e);
					}
       	      	});
       	      
       	    
	        	
           }); //click
		
           
           function insertReserv(){
   	    		console.log("인서트시작");
      	      	$.ajax({
       	      	url: "${pageContext.request.contextPath }/oneday/paycompletion",
				method : "Post",
				success : data =>{
			
        			//$(location).attr('href', "${pageContext.request.contextPath }/oneday/result");
        			location.href = "${pageContext.request.contextPath }/oneday/result";
				},
				error : (x,s,e) =>{
					console.log(x,s,e);
				}
      	      	});
        	   
           }
           $('#bank').click(function() {
               $("#bank-pay").show();
               $("#card-pay").hide();
               $("#bank").style.backgroundColor = "#4949e7";
           }); 
        }); //ready
        
   /*      function reservationEnd() {
            $("#reservationEndFrm").attr("action", "${pageContext.request.contextPath }/oneday/result.do").submit();
        }; */
        
   
   	console.log("스크립트로딩엔딩부");
    </script>
    
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
                <div class="wizard">
                    <a><span class="badge">01</span> 클래스 예약</a> <a><span class="badge">02</span>
                        예약 정보동의</a> <a  class="current badge-inverse"><span class="badge ">03</span>
                        예약 결제</a> <a><span class="badge">04</span>결제 완료</a>
                </div>
                <form action="/onn/oneday/result.do" method="POST" onsubmit="return payresultvalidation();">
                    <div class="row text-center">
                    <div class="col"></div>
                        <article class="col-lg-4 tm-article">
                            <h3 class="tm-color-primary tm-article-title-1">결제 상품 </h3>
                            <table class="ticket-tbl container">

		                        <tr>
                                    <td><b>${oneday.onedayName }</b></td>
                                </tr>
                                <tr>
                                    <td>${reservationrequest.regDate}</td>
                                </tr>
                                <tr>
                                    <td>${reservationrequest.personnel } 매</td>
                                </tr>
                            </table>
                        </article>
                        <article class=" col-lg-4 tm-article">
                            <h3 class="tm-color-primary tm-article-title-1">결제수단</h3>
                            <p class="box_subtitle">❖ 카카오페이 간편결제를 통해 결제하실 수 있습니다.</p>
                            <input type="button" class="pay-btn" id="card" name="payCard" value="카카오페이 결제">
                        </article>

                    <div class="col"></div>
                    </div>
                </form>
            </div>
        </div>
    </section>
    <!-- Event Details Section end -->
<jsp:include page="/WEB-INF/views/common/footer.jsp" />
