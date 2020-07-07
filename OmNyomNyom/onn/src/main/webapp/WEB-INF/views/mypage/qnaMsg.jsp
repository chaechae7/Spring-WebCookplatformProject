<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:requestEncoding value="utf-8"/>
<jsp:include page="/WEB-INF/views/common/header.jsp"> 
	<jsp:param value="문의내역" name="pageTitle"/>
</jsp:include>

	<link rel="stylesheet" href="css/user-list.css"/>
	<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/mypage/chef-list.css"/>


	<script>
		$(function(){
			$(".user-select-area").on("click",function(){
				let userid = $(this).find(".user-id").val();
				location.href = "링크"+userid;
			});
		});

	</script>
<!-- 아이디, 비밀번호, 닉네임, 이름,연락처, 이메일, 주소(선택) , 생년월일  -->
	<div class="container">
		<div class="section">
			<div class="row">
				<div class="col side_nav">
					<a href="${pageContext.request.contextPath}/mypage/main"><p class="nav_text">내 정보보기</p></a>
					<a href="${pageContext.request.contextPath}/mypage/onedayList"><p class="nav_text">예약목록</p></a>
					<a href="${pageContext.request.contextPath}/mypage/buyList"><p class="nav_text">구매목록</p></a>
					<a href="${pageContext.request.contextPath}/mypage/qnaMsg"><p class="nav_text selected_nav">문의내역</p></a>
					<a href="${pageContext.request.contextPath}/mypage/scrapList"><p class="nav_text">스크랩 목록</p></a>
					<a href="${pageContext.request.contextPath}/chef/chefInsert"><p class="nav_text">셰프신청</p></a>
					<a href="${pageContext.request.contextPath}/mypage/dingdongList"><p class="nav_text">알림목록</p></a>
				</div>
				<div class="col-10">
					<h4 class="border_bottom">문의목록</h4>
					<br>
					<table class="table">
						<thead>
						  <tr>
							<th> </th>
							<th>내용</th>
							<th>날짜</th>
						  </tr>
						</thead>
						<tbody>
						  <tr class="user-select-area">
							<th scope="row" class="wait-ment">답변 대기중</th>
							<td class="user-id">레시피 이름</td>
							<td>2020.02.20</td>
						  </tr>
						  <tr class="user-select-area">
							<th scope="row">답변 완료</th>
							<td class="user-id">죠리퐁 우유 부어먹기</td>
							<td>2020.02.20</td>
						  </tr>
						  <tr class="user-select-area">
							<th scope="row">답변 완료</th>
							<td class="user-id">우유 죠리퐁 부어먹기</td>
							<td>2020.02.20</td>
						  </tr>
						  <tr class="user-select-area">
							<th scope="row" class="wait-ment">답변 대기중</th>
							<td class="user-id">우유 죠리퐁 부어먹기</td>
							<td>2020.02.20</td>
						  </tr>
						</tbody>
					  </table>
					  <div class="site-pagination pt-3.5">
						<a href="#" class="active">1</a>
						<a href="#">2</a>
						<a href="#"><i class="material-icons">keyboard_arrow_right</i></a>
					</div>

				</div>
			</div>
		</div>
	</div>


<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
