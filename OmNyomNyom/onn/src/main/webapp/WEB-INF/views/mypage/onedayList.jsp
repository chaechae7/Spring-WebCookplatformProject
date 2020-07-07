<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:requestEncoding value="utf-8"/>
<jsp:include page="/WEB-INF/views/common/header.jsp"> 
	<jsp:param value="예약확인" name="pageTitle"/>
</jsp:include>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/mypage/chef-list.css"/>
<!-- 아이디, 비밀번호, 닉네임, 이름,연락처, 이메일, 주소(선택) , 생년월일  -->
	<div class="container">
		<div class="section">
			<div class="row">
				<div class="col side_nav">
					<a href="${pageContext.request.contextPath}/mypage/main"><p class="nav_text">내 정보보기</p></a>
					<a href="${pageContext.request.contextPath}/mypage/onedayList"><p class="nav_text selected_nav">예약확인</p></a>
					<a href="${pageContext.request.contextPath}/mypage/buyList"><p class="nav_text ">구매목록</p></a>
					<a href="${pageContext.request.contextPath}/chat/msg/sdmin"><p class="nav_text ">문의내역</p></a>
					<a href="${pageContext.request.contextPath}/mypage/scrapList"><p class="nav_text">스크랩 목록</p></a>
					<a href="${pageContext.request.contextPath}/chef/chefInsert"><p class="nav_text">셰프신청</p></a>
				</div>
				<div class="col-10">
					<h4 class="border_bottom">예약확인</h4>
					<br>
					<div class="row">
						<div class="col-10">
							<div class="row font-17 th_border">
								
								<div class="col-1">예약 번호</div>
								<div class="col-3">클래스 이름</div>
								<div class="col-1">인원</div>
								<div class="col-2">금액</div>
								<div class="col-2">예약 상태</div>
								<!-- <div class="col-3">시간</div> -->
							</div>
							<br>
							<c:forEach var="ReservationRequest" items="${reservationList }">
								<div class="row">
 									<div class="col-1">${ReservationRequest.reservationNo }</div>
 									<div class="col-3">${ReservationRequest.onedayClassName }</div>
									<div class="col-1">${ReservationRequest.personnel }</div>
									<div class="col-2">${ReservationRequest.totalPrice}원<br>(인당 6000원)</div>
									
								<c:if test="${ReservationRequest.cancel == 'N' }">
									<div class="col-2"><p>진행중</p></div>
								</c:if>
									
								<c:if test="${ReservationRequest.cancel == 'Y' }">
									<div class="col-2"><p>취소중</p></div>
								</c:if>
 									<%-- <div class="col-3">${ReservationRequest.regDate } --%>
									
								</div>
							<hr>
							</c:forEach>
							
						</div>
						<div class="col"></div>
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