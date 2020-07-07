<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:requestEncoding value="utf-8"/>
<jsp:include page="/WEB-INF/views/common/header.jsp"> 
	<jsp:param value="내정보보기" name="pageTitle"/>
</jsp:include>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/mypage/chef-list.css"/>

<!-- 아이디, 비밀번호, 닉네임, 이름,연락처, 이메일, 주소(선택) , 생년월일  -->
	<div class="container">
		<div class="section">
			<div class="row">
				<div class="col side_nav">
					<a href="${pageContext.request.contextPath}/mypage/main"><p class="nav_text selected_nav">내 정보보기</p></a>
					<a href="${pageContext.request.contextPath}/mypage/onedayList"><p class="nav_text ">예약목록</p></a>
					<a href="${pageContext.request.contextPath}/mypage/buyList"><p class="nav_text ">구매목록</p></a>
					<a href="${pageContext.request.contextPath}/chat/msg/sdmin"><p class="nav_text ">문의내역</p></a>
					<a href="${pageContext.request.contextPath}/mypage/scrapList"><p class="nav_text">스크랩 목록</p></a>
					<a href="${pageContext.request.contextPath}/chef/chefInsert"><p class="nav_text">셰프신청</p></a>
					<a href="${pageContext.request.contextPath}/mypage/dingdongList"><p class="nav_text">알림목록</p></a>
				</div>
				
				
				<div class="col-10">
					<form action="<%=request.getContextPath()%>/mypage/updateinfo "id="form1" method="get">
						<h4 class="border_bottom">내 정보보기</h4>
						<br>
							<table class="table">
								<tr class="row">
									<td class="col-3">이름</td>
									<td class="col-9">${memberLoggedIn.memberName }</td>
								</tr>
								<tr class="row">
									<td class="col-3">생년월일</td>
									<td class="col-9">${memberLoggedIn.ssn }</td>
								</tr>
								<tr class="row">
									<td class="col-3">연락처</td>
									<td class="col-9"><input type="text" class="update-input-box" value="${memberLoggedIn.phone }" name="phone"/></td>
								</tr>
								<tr class="row">
									<td class="col-3">이메일</td>
									<td class="col-9"><input type="email" class="update-input-box" value="${memberLoggedIn.email }" name="email"/></td>
								</tr>
								<tr class="row">
									<td class="col-3">주소(배송지)</td>
									<td class="col-9"><input type="text" class="update-input-box" value="${memberLoggedIn.address }" name="address"/></td>
								</tr>
							</table>
						<div class="div-update-button">
							<input type="submit" id="update-button"class="update-button" value="수정"/>	
						</div>
					</form>
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
