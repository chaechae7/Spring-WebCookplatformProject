<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:requestEncoding value="utf-8"/>
<jsp:include page="/WEB-INF/views/common/header.jsp"> 
<jsp:param value="뇸뇸몰" name="pageTitle"/>
</jsp:include>

<style>
.search-bar-header{
	margin-top: 45px;
}
.product_container{
	margin: 5px;  
}
</style>

<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/mall_delivery_info.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/mall_main.css" />
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
        <div class="container">
        <div class="event-filter-warp search-bar-header">
            <div class="row">
                <div class="col-12">
                    <form id="search-ing" class="event-filter-form row" action="${pageContext.request.contextPath }/mall/search" onsubmit="return searchIngMall();">
                    	<div class="col"></div>
                        <div class="ef-item col-5">
                            <i class="material-icons">search</i>
                            <input type="text" placeholder="" name="keyword">
                        </div>
                        <button class="site-btn sb-gradient col-2">메뉴 검색</button>
                    	<div class="col"></div>
                    </form>
                </div>
		         </div>
		     </div>
	 	</div>	     
        <div class="container">
            <div class="row ">
                <div class="col-1"></div>
                <div class="col-10">
                    <div class="row ingre-list"> 
                        <div class="col-11">
                            <div class="container">
                                <ul class="main-ctg-menu catch-click-event">
                                    <li>
                                        <p class="active">채소/과일</p>
                                    </li>
                                    <li>
                                        <p>육류</p>
                                    </li>
                                    <li>
                                        <p>수산물</p>
                                    </li>
                                    <li>
                                        <p>곡물/견과류</p>
                                    </li>
                                    <li>
                                        <p>양념/소스</p>
                                    </li>
                                    <li>
                                        <p>가공/유제품</p>
                                    </li>
                                    <li>
                                        <p>기타</p>
                                    </li>
                                </ul>
                            </div>
                            <div class="row sub-container">
                                <div class="bx container ">
                                    <div class="container">
                                        <ul class="sub-ctg-menu catch-click-event">
                                        </ul>
                                    </div>
                                </div>
                            </div>                    
                        </div>
<!--------------------------------재료가 추가되는 영역 ------------------------------>
                        
                    </div>
                </div>
            </div>    
        </div>

    </section>

<script>
	function ingredient_list(e){
		let subCtg = {'subCtg' : $(e).text()};
		$.ajax({
	    	url:"${pageContext.request.contextPath}/mall/seachList.ajax",
	    	dataType : 'json',
	    	method : "GET",
	    	data : subCtg,
	    	success : data =>{
	    	/* 재료목록 교체작업 */
		        $(e).addClass("active");
		        $(e).parent().siblings().find("p").removeClass("active");
		        $(".product_container").remove();
		    	$.each(data,function(index, item){
		    		let ingMall = '';
		    		ingMall = "<div class='col-lg-2 row product_container' >"
	                       +"<a href='${pageContext.request.contextPath}/mall/productDetail?ingMallNo="+item.ingMallNo+"'><img src='${pageContext.request.contextPath }/resources/images/ingredient/"+item.mallEngPrCategory+"/"+item.mallEngCdCategory+"/"+item.prevImg+"' alt='' class='col-12 border-rai'></a>"
	                       +"<div class='col'>"
	                       +"<p class='mini-font'>"+item.ingMallName+"("+item.minUnit+")</p>"
	                       +"</div>"
	                       +"<div class='col-4'>"
	                       +"<p class='mini-font price-font'>"+item.price+"</p>"
	                       +"</div>"
	                       +"</div>";
			    	$(".ingre-list").append(ingMall);
			    	price_comma();
		    	});
	    	},
	    	error : (x,s,e) =>{
	    		console.log(x,s,e);
	    	}
		});
	}
	function price_comma(){
		$(".price-font").each(function(index,item){
			$(item).text($(item).text().replace(/\B(?=(\d{3})+(?!\d))/g, ","));
		})
	}
	
    function cd_category(e){
    	let mainCtg = {'mainCtg':$(e).html()};
    	$.ajax({
	    	url:"${pageContext.request.contextPath}/recipe/getSubCtg",
	    	dataType: "json",
	    	method : "GET",
	    	data: mainCtg,
	    	success : data =>{
	    	/* 서브 카테고리 교체작업 */
		    	let subCtgList = ' ';
		    	$.each(data,function(index, item){
			    	if(index == 0){
			    		subCtgList += '<li> <p class="active">'+item+'</p> </li>';
			    	}else{
				    	subCtgList += '<li> <p>'+item+'</p> </li>';
			    	}
		    	});
		    	$(".sub-ctg-menu").html(subCtgList);
	    	},
	    	error : (x,s,e) =>{
	    		console.log(x,s,e);
	    	}
    	});
   	}
	$(document).on("click",".sub-ctg-menu p",function(){
    	ingredient_list($(this));
    	
	});
    $(function(){
	    $(".catch-click-event").find("p").on("click",function(){
	        $(this).addClass("active");
	        $(this).parent().siblings().find("p").removeClass("active");
	        console.log($(this).text());
	    });
		
	    $(".product_container").on("click",function(){
	    	location.href = "${pageContext.request.contextPath }/mall/productDetail.do";
	    });
	    $(".main-ctg-menu").find("p").on("click",function(){
	    	cd_category($(this));
	    });
    	$(".active").trigger("click");
  /*   	$(".active").click(); */
		/* $(".main-ctg-menu").find("p")[0].trigger("click"); */
    	
    });
    function searchIngMall(){
    	let keyword = $("#search-input").val();
    	if(keyword.length >= 1)
    		return false;
    	return true;
    }


</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp" />
