<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:requestEncoding value="utf-8"/>
<jsp:include page="/WEB-INF/views/common/header.jsp"> 
	<jsp:param value="구매목록" name="pageTitle"/>
</jsp:include>
	<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/mypage/chef-list.css"/>


<!-- 아이디, 비밀번호, 닉네임, 이름,연락처, 이메일, 주소(선택) , 생년월일  -->
	<div class="container">
		<div class="section">
			<div class="row">
				<div class="col side_nav">
					<a href="${pageContext.request.contextPath}/chef/main"><p class="nav_text">내 정보보기</p></a>
					<a href="${pageContext.request.contextPath}/chef/onedayList"><p class="nav_text ">예약확인</p></a>
					<a href="${pageContext.request.contextPath}/chef/reservationStatus"><p class="nav_text ">예약현황</p></a>
					<a href="${pageContext.request.contextPath}/chef/chefbuyList"><p class="nav_text selected_nav">구매목록</p></a>
					<a href="${pageContext.request.contextPath}/chef/qnaMsg"><p class="nav_text ">문의내역</p></a>
					<a href="${pageContext.request.contextPath}/chef/chefscrapList"><p class="nav_text">스크랩 목록</p></a>
					<a href="${pageContext.request.contextPath}/chef/chefDingdongList"><p class="nav_text">알림목록</p></a>
					<%-- <a href="${pageContext.request.contextPath}/chef/sendDingdongList"><p class="nav_text">알림 보내기</p></a> --%>
				</div>
				<div class="col-10">
					<h4 class="border_bottom">구매목록</h4>
					<br>

					<div class="row"> 
						<div class="col-10 ">
							<div class="row font-17 th_border">
								
								<div class="col-3">상품명</div>
								<div class="col-3">결제일</div>
								<div class="col-2">구매갯수</div>
								<div class="col-2">총 가격</div>
								<div class="col-2">상태</div>

							</div>
						<!-- 주문번호별 분류 -->
							<c:forEach var="BuyHistory" items="${buyList }">
							<div class="row font-17 th_border">
                                <div class="col-3">${BuyHistory.buyMemberId }</div>
                                <div class="col-3">${BuyHistory.buyRegdate }</div>
                                <div class="col-2">${BuyHistory.buyStock }</div>
								<div class="col-2 floatRight">
									<span>
										${BuyHistory.totalPrice }원
									</span>	
								</div>
								<div class="col-2 floatRight">
									<span>
										${BuyHistory.buyStatus }
									</span>	
								</div>
							</div>
							<hr>
							<br>
						</c:forEach>	
					</div>
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
