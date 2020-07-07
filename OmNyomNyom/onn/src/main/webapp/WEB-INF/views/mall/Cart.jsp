<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:requestEncoding value="utf-8" />
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="장바구니" name="pageTitle" />
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
				<a class="current badge-inverse"><span class="badge">01</span>장바구니</a>
				<a><span class="badge">02</span> 선택된 상품 리스트</a><a><span class="badge ">03</span>결제
					정보</a> <a><span class="badge ">04</span>결제 완료</a>
			</div>
			</div>



		</div>
		<!-- 장바구니 시작 -->
		<div class="container col-md-12 basket">
			<div class="container">

				<div class="row border_bottom">
					<h4>장바구니</h4>
				</div>
				<br>

				<div class="row">
					<div class="col-md-12 ">
						<!--  -->
						<div class="row">
							<div class="container">
								<div class="row title">
									<div class="col-md-1">
										<input class="ckbox" type="checkbox" name="" id="" checked>
									</div>
									<div class="col-md-9">상품정보</div>
									<div class="col-md-2">상품금액</div>

								</div>
								<hr>
								<c:forEach items="${cartList }" var="cart">
									<div class="row sb-area">
										<div class="ckbox col-md-1">
											<input class="chbox-obj" type="checkbox" name="" id="" checked>
										</div>
										<div class="col-md-2">
											<img class="p-img"
												src="${pageContext.request.contextPath }/resources/images/ingredient/${cart.mallEngPrCategory }/${cart.mallEngCdCategory }/${cart.prevImg }"
												alt="">
										</div>
										<div class="col-md-7">
											<div class="inner-col pline">
												<span class="p-name">${cart.ingMallName }</span> <span class="p-info">(${cart.minUnit }당, <span class="price"><fmt:formatNumber value="${cart.price }" pattern="#,###" /></span>원)</span>
											</div>
											<div class="inner-col">
													<i class="fa fa-minus btns"></i> 
													<input type="hidden" name="ingNo" value="${cart.sbIngNo }">
													<input type="number" name="stock" class="qty count" title="구매수량" value="${cart.sbStock}"  /> 
													<i class="fa fa-plus btns"></i>
											</div>
										</div>
										<div class="col-md-2 md-total-price">
										<span class="sum-price">
										<fmt:formatNumber value="${cart.price * cart.sbStock }" pattern="#,###" /></span>원
											 <i class="fa fa-trash" onclick="delproduct(${cart.sbIngNo},this);"></i>
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
								<button type="button"
									class="btn btn-primary mvToSelectedIngMall">선택 상품 주문하기</button>
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
	    cursors();
	    totalPrice();
	})
	
	//	체크박스
	$(document).on("click",".ckbox",function(){
			    	$box = $(this).children();
			    	$box.attr('checked',!$box.prop("checked"));
			    	totalPrice();
				})
    //	수량 Input 
    		   .on("keyup",".count",function(){
  					changePrice($(this),$(this).val());
   				})
    		   .on("click",".p-img",function(){
    			   $(this).parents(".sb-area").find(".chbox-obj").trigger("click");
    		    })
    		   
    		   
    
    // 장바구니 상품 삭제
    function delproduct(ingMallNo,target){
		$.ajax({
			url: localUrl+"/mall/cart/del/"+ingMallNo,
	    	type : "DELETE",
	    	success : function(){
		    	console.log('삭제성공');
		    	$(target).parents(".sb-area").remove();
		    	totalPrice();
	    	}
		})
	}
    
    // 수량 +/- 버튼
	function cursors() {
	    $(".btns").css("cursor", "pointer").on("click", function (e) {
	        let $nowcl = $(this).attr('class');
			let $input = $(this);
	        
	        if ($nowcl.includes('fa-plus')) {
	        	$input = $(this).prev();
	            let $qty = parseInt($input.val());
	            $input.val($qty+1);
	        } else if ($nowcl.includes('fa-minus')) {
	        	$input = $(this).next();
	            let $qty = parseInt($input.val());
	            $input.val($qty-1);
	        }
	        changePrice($input,$input.val());
	    });
	}
	
	function changePrice($obj,count){
    	if(count<=0){
    		$obj.val(1);
    		count='1';
    	}

		let price = $obj.parents(".sb-area").find(".price").text();
    	price = price.replace(/\,/g,"");
		count = count.replace(/\,/g,"");
		let sumPrice = Number(count)*Number(price);
		let $minTotal = $obj.parents(".sb-area").find(".sum-price");
		$minTotal.text(String(sumPrice).replace(/\B(?=(\d{3})+(?!\d))/g, ","));
		totalPrice();
	}
	function totalPrice(){
		let totalPrice = 0;
		$(".sb-area").find(".chbox-obj").each(function(index,item){
			if($(item).is(":checked")){
				let price = $(item).parents(".sb-area").find(".sum-price").text();
		    	price = price.replace(/\,/g,"");
				totalPrice += Number(price);
			}
		})
		$("#total_price").text(String(totalPrice).replace(/\B(?=(\d{3})+(?!\d))/g, ",")); 
	}
	$(".mvToSelectedIngMall").click(function(){
		let buyList = new Array();
		let i = 0;
		console.log($(this));
		$(".chbox-obj").each(function(index,item){
			if($(item).is(":checked")){
				let ingNo = $(item).parents(".sb-area").find("[name='ingNo']").val();
				let stock = $(item).parents(".sb-area").find("[name='stock']").val();
				buyList[i++] = {'ingNo':ingNo,
								'stock':stock};
			}
		})
		/* console.log(buyList); */
		buyList = JSON.stringify(buyList);
		$.ajax({
			url  : localUrl+"/mall/selectedIngMallList.ajax",
			type : "GET",
			data : {'buyList':buyList},
			success : function(str){
				console.log("성공");
				$(location).attr('href',localUrl+str);
			},
			error : (x,s,e)=>{
				console.log(x);
				console.log(s);
				console.log(e);
				console.log("실패");
			}
			
			
		})
	});
</script>




<jsp:include page="/WEB-INF/views/common/footer.jsp" />