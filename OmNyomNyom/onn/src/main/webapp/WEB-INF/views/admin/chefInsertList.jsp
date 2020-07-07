<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:requestEncoding value="utf-8"/>
<jsp:include page="/WEB-INF/views/common/header.jsp"> 
	<jsp:param value="" name="pageTitle"/>
</jsp:include>
	<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/mypage/chef-list.css"/>


<!-- 아이디, 비밀번호, 닉네임, 이름,연락처, 이메일, 주소(선택) , 생년월일  -->
	<div class="container">
		<div class="section">
			<div class="row">
				<div class="col side_nav">
					<a href="${pageContext.request.contextPath}/admin/adminMain"><p class="nav_text ">내 정보보기</p></a>
					<a href="${pageContext.request.contextPath}/admin/sellList"><p class="nav_text ">판매목록</p></a>
					<a href="${pageContext.request.contextPath}/admin/adminQnaMsg"><p class="nav_text ">1:1 문의</p></a>
					<a href="${pageContext.request.contextPath}/admin/chefInsertList"><p class="nav_text selected_nav">셰프신청목록</p></a>
					<a href="${pageContext.request.contextPath}/admin/sendDingdong"><p class="nav_text">알림보내기</p></a>
				</div>
				<div class="col-10">
					<h4 class="border_bottom">판매목록</h4>
					<br>

					<div class="row"> 
						<div class="col-10 ">
							
						<!-- 주문번호별 분류 -->
							<div class="row font-17 th_border">
                                <div class="col">2020.02.20</div>
								<div class="col floatRight">
									<span>
										346,000 원
									</span>	
								</div>
							</div>
							<!-- 주문갯수/배송상태 -->
							<div class="row">
								<div class="col-10 row">
									<div class="col-10 row">
										<div class="col-2"><img src="프로젝트용 소스/육류/돼지고기/구이용.png" alt=""></div>
									<div class="col">고기고기꼬기 / 7개<br> 49,000원(7,000원)</div>
									</div>
									<div class="col-10 row">
										<div class="col-2"><img src="프로젝트용 소스/채소과일/열매채소/단호박.jfif" alt=""></div>
										<div class="col">단호박 / 1개<br> 10,000원(10,000원)</div>
									</div>
									<div class="col-10 row">
										<div class="col-2"><img src="프로젝트용 소스/채소과일/과일/라즈베리.jfif" alt=""></div>
										<div class="col">라즈베리 / 2개 <br> 4,000원(2,000원)</div>
									</div>
								</div>
								<div class="col-2">
									<span class="align-middle">middle</span>
								</div>
							</div>
							<hr>
							<br>
							<div class="row font-17 th_border">
                                <div class="col">2020.02.20</div>
								<div class="col floatRight">
									<span>
										346,000 원
									</span>	
								</div>
							</div>
							<!-- 주문갯수/배송상태 -->
							<div class="row">
								<div class="col-10 row">
									<div class="col-10 row">
										<div class="col-2"><img src="프로젝트용 소스/육류/돼지고기/구이용.png" alt=""></div>
									<div class="col">고기고기꼬기 / 7개<br> 49,000원(7,000원)</div>
									</div>
									<div class="col-10 row">
										<div class="col-2"><img src="프로젝트용 소스/채소과일/열매채소/단호박.jfif" alt=""></div>
										<div class="col">단호박 / 1개<br> 10,000원(10,000원)</div>
									</div>
									<div class="col-10 row">
										<div class="col-2"><img src="프로젝트용 소스/채소과일/과일/라즈베리.jfif" alt=""></div>
										<div class="col">라즈베리 / 2개 <br> 4,000원(2,000원)</div>
									</div>
								</div>
								<div class="col-2">
									<span class="align-middle">middle</span>
								</div>
							</div>
							<hr>
							
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
