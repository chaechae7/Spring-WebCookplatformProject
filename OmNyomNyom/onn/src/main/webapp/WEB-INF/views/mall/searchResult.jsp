<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%
	String keyword = request.getParameter("keyword");
%>
<fmt:requestEncoding value="utf-8"/>
<jsp:include page="/WEB-INF/views/common/header.jsp"> 
	<jsp:param value="${keyword }- 검색결과" name="pageTitle"/>
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
                    <form id="search-ing" class="event-filter-form row" action="${pageContext.request.contextPath }/mall/search" onsubmit="return search-ingMall();">
                    	<div class="col"></div>
                        <div class="ef-item col-5">
                            <i class="material-icons">search</i>
                            <input id="search-input" type="text" name="keyword" placeholder="" value="${key }">
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
                        <c:if test="${not empty list}">
                        <c:forEach items="${list }" var="ingMall"> 
							<div class="col-lg-2 row product_container">
	                            <a href="${pageContext.request.contextPath}/mall/productDetail?ingMallNo=${ingMall.ingMallNo}">
	                            	<img src="${pageContext.request.contextPath }/resources/images/ingredient/<c:if test="${ingMall.prevImg eq 'Ingredient_default.png'}">${ingMall.prevImg }</c:if><c:if test="${ingMall.prevImg ne 'Ingredient_default.png' }">${ingMall.mallEngPrCategory}/${ingMall.mallEngCdCategory}/${ingMall.prevImg}</c:if>" alt="" class="col-12 border-rai">
	                            </a>
	                            <div class="col">
	                                <p class="mini-font">${ingMall.ingMallName }(${ingMall.minUnit })</p>
	                            </div>
	                            <div class="col-4">
	                                <p class="mini-font price-font"><fmt:formatNumber value="${ingMall.price }" pattern="#,###" /></p>
	                            </div>
	                        </div>                        
                        </c:forEach>
                        </c:if>
                    </div>
                </div>
            </div>    
        </div>

    </section>
<script>
function search-ingMall(){
	let keyword = $("#search-input").val();
	if(keyword.length >= 1)
		return false;
	return true;
}
</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp" />
