<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:requestEncoding value="utf-8"/>
<jsp:include page="/WEB-INF/views/common/header.jsp"> 
	<jsp:param value="판매목록" name="pageTitle"/>
</jsp:include>
	<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/mypage/chef-list.css"/>


<!-- 아이디, 비밀번호, 닉네임, 이름,연락처, 이메일, 주소(선택) , 생년월일  -->
<div class="container">
	<div class="section">
		<div class="row">
			<jsp:include page="/WEB-INF/views/common/adminSidenav.jsp">
				<jsp:param value="판매목록" name="sidenav"/>
			</jsp:include>
			<div class="col-10">
				<h4 class="border_bottom">판매목록</h4>
				<br>
				<div class="row"> 
					<c:forEach items="${buyHisotyList}" var="buyHisoty">
					<div class="col-10 ">
					
					<!-- 주문번호별 분류 -->
						<div class="row font-17 th_border">
							<div class="col"><p>주문번호 : ${buyHisoty.buyNo }</p></div>
                               <div class="col">${buyHisoty.buyRegdate}</div>
									<span class="align-middle">${buyHisoty.buyMemberName}</span>
							<div class="col floatRight">
								<span>
								총 결제 금액 : 
								<fmt:formatNumber value="${buyHisoty.totalPrice}" pattern="#,###" />
								</span>	
							</div>
						</div>
						<!-- 주문갯수/배송상태 -->
						<c:forEach items="${buyHisoty.ingMallList}" var="ingMall">
							<div class="row">
								<div class="col-10 row">
									<div class="col-10 row">
										<div class="col-2">
										<a href="${pageContext.request.contextPath }/mall/productDetail?ingMallNo=${ingMall.ingMallNo}"><img class="p-img" src="${pageContext.request.contextPath }/resources/images/ingredient/${ingMall.mallEngPrCategory }/${ingMall.mallEngCdCategory }/${ingMall.prevImg }" alt=""></a>
										</div>
									<div class="col">${ingMall.ingMallName}</div>
									</div>
								</div>
								<div class="col-2">
									<span class="align-middle"> 
									<fmt:formatNumber value="${ingMall.price}" pattern="#,###" />원
									<br />
									${ingMall.stock}개 (<fmt:formatNumber value="${ingMall.price/ingMall.stock}" pattern="#,###" />원)
									</span>
								</div>
							</div>
							<hr>
						</c:forEach>
						<br>
					</div>
					</c:forEach>
				</div>
				<c:if test="${paging != null }">
					${paging}
				</c:if>	
			</div>
		</div>
	</div>
</div>

<script>
	$(function(){
		$(".side_nav").children().click(function(){
			// console.log($(this).html());
			location.href=$(this).html()+".html";
		});
	});
</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
