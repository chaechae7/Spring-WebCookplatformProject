<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:requestEncoding value="utf-8"/>
<jsp:include page="/WEB-INF/views/common/header.jsp"> 
<jsp:param value="상품 - ${ingMall.ingMallName } " name="pageTitle"/>
</jsp:include>
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/mall_common.css" />
<style>
#total_price{
	font-weight: bold;
    font-size: 28px;
    line-height: 30px;
    letter-spacing: -0.5px;
    word-break: break-all;
    color: rgb(73, 73, 231)
}
</style>

 <!--  Section start -->
    <section class="classes-details-section spad overflow-hidden">
        <div class="container">
            <div class="row">
                <div class="col-lg-7">
                    <div class="recipe-details">
                        <div class="section_view">

                            <div id="sectionView">
                                <div class="inner_view">
                                    <div class="thumb" style="background-image: url(&quot;https://img-cf.kurly.com/shop/data/goods/158519696333y0.jpg&quot;);">
		                            	<img src="${pageContext.request.contextPath }/resources/images/ingredient/<c:if test="${ingMall.prevImg eq 'Ingredient_default.png'}">${ingMall.prevImg }</c:if><c:if test="${ingMall.prevImg ne 'Ingredient_default.png' }">${ingMall.mallEngPrCategory}/${ingMall.mallEngCdCategory}/${ingMall.prevImg}</c:if>" alt="${ingMall.ingMallName }의 이미지" class="bg">
                                    </div>
                                    
                                    <p class="goods_name"><span class="btn_share"></span> <strong class="name">${ingMall.ingMallName}</strong></p>
                                    <p class="goods_price">
                                        <span class="position">
                                            <span class="dc">
                                                    <span class="dc_price" id="price"><fmt:formatNumber value="${ingMall.price }" pattern="#,###" />
                                        </span>
                                                    <span class="won">원</span>
                                        </span>
                                        </span>


                                    </p>
                                    <div class="goods_info">
                                        <dl class="list"><dt class="tit">판매단위/중량/용량</dt>
                                            <dd class="desc">${ingMall.minUnit }</dd>
                                        </dl>
                                        <dl class="list"><dt class="tit">배송구분</dt>
                                            <dd class="desc">채성택배</dd>
                                        </dl>
                                        <dl class="list"><dt class="tit">원산지</dt>
                                            <dd class="desc">${ingMall.ingOrigin }</dd>
                                        </dl>
                                        <dl class="list"><dt class="tit">유통기한</dt>
                                            <dd class="desc">${ingMall.shelfLife }일</dd>
                                        </dl>
                                        <dl class="list"><dt class="tit">포장타입</dt>
                                            <dd class="desc"> 상온/종이포장
                                                <strong class="emph">택배배송은 에코포장이 스티로폼으로 대체됩니다.</strong>
                                            </dd>
                                        </dl>
                                    </div>
                                </div>
                            </div>

                            <div id="cartPut">
                                <div class="cart_option cart_type2">
                                    <div class="inner_option">
                                        <strong class="tit_cart">${ingMall.ingMallName}</strong>
                                        <div class="in_option">
                                            <div class="list_goods">
                                                <ul class="list list_nopackage">
                                                    <li class="on"><span class="btn_position"><button type="button" class="btn_del"><span class="txt">삭제하기</span></button>
                                                        </span> <span class="name">${ingMall.ingMallName}</span> <span class="tit_item">구매수량</span>
                                                        <div class="option">
                                                            <span class="count">
	                                                            <button type="button" class="btn down" id="countdown">수량내리기</button> 
	                                                            <input type="number" class="inp" id="count" value="1" min="1" name="stock"> 
	                                                			<input type="hidden" name="ingNo" value="${ingMall.ingMallNo }">
	                                                            <button type="button" class="btn up" id="countup">수량올리기</button>
                                                            </span>
                                                        </div>
                                                    </li>
                                                </ul>
                                            </div>
                                            <div class="total">
                                                <div class="price">
                                                    <strong class="tit" >총 상품금액 : </strong><span class="dc_price" id="total_price"><fmt:formatNumber value="${ingMall.price }" pattern="#,###" /></span>
                                                    <span class="sum">
                                                         <span class="num"></span>
                                                    <span class="won">원</span>
                                                    </span>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="group_btn off">

                                            <div class="view_function">
                                                <button type="button" class="btn btn_save">구매하기</button>
                                                <button type="button" class="btn btn_alarm off">1:1문의</button>
                                            </div>
                                            <span class="btn_type1">
                                                <input type="button" class="txt_type" value="장바구니 담기" id="add-shoppingBasket">
                                            </span>
                                        </div>

                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div clss="row">
                        <hr style="margin:auto; position: relative; left:25%;">
                        <h3 class="product_title">상품상세</h3>
                        <p class="product_sub_title">자세한 정보를 확인해 주세요.</p>
                        <hr style="margin:auto; position: relative; left:25%;">
                        <div class="col-lg-12 m-auto">
                            <img src="${pageContext.request.contextPath }/resources/images/mall/${ingMall.ingInfo}" class="mall_detail_img">
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!--  Section end -->
    <script>
    var localUrl = "${pageContext.request.contextPath}";
    $(function(){
	    $("#add-shoppingBasket").on("click",function(){
	    	shoppingBasket();
	    });
	    
	    function countChange(b){
	    	$count = $("#count");
	    	let cnum = Number($count.val())+Number(b);
	    	if(cnum<=0){
				$count.text(1);
				cnum = 1;
	    	}
	    	$count.val(cnum);
	    	let price = $("#price").text()
	    	price = price.replace(/\,/g,"");
	    	let ppap = Number(price)*cnum;
	    	$("#total_price").text(String(ppap).replace(/\B(?=(\d{3})+(?!\d))/g, ","));

/* 	    	$("#total_price").text(Number(price)*cnum); */

	    }
	    
	    $("#countup").on("click",function(){
	    	countChange(1);
	    });
	    $("#countdown").on("click",function(){
	    	countChange(-1);
	    });
	    $("#count").on("keyup",function(){
	    	countChange(0);
	    });
	    
	    function shoppingBasket(){
	    	let ingMall = {"ingMallNo":"${ingMall.ingMallNo}",
	    			       "stock":$("#count").val()}	 
	    	$.ajax({
		    	url: localUrl+"/mall/cart/add",
		    	data : ingMall,
		    	dataType : 'text',
		    	method : "POST",
		    	success : data =>{
		    	/* 재료목록 교체작업 */
		    		alert(data);
			    	console.log(data)
		    	},
		    	error : (x,s,e) =>{
		    		alert(data);
		    	}
			});
	    };
	    
	    $(".btn_save").click(function(){
	    	
			let buyList = new Array();
			
			let ingNo = $("[name='ingNo']").val();
			let stock = $("[name='stock']").val();
			
			buyList[0] = {'ingNo':ingNo,
							'stock':stock};
				
			
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
    });
    </script>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />
