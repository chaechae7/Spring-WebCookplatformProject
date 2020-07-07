<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:requestEncoding value="utf-8"/>
<jsp:include page="/WEB-INF/views/common/header.jsp"> 
	<jsp:param value="셰프신청" name="pageTitle"/>
</jsp:include>
	<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/mypage/chef-list.css"/>


<!-- 아이디, 비밀번호, 닉네임, 이름,연락처, 이메일, 주소(선택) , 생년월일  -->
	<div class="container">
		<div class="section">
			<div class="row">
				<div class="col side_nav">
					<p class="nav_text ">내 정보보기</p>
					<p class="nav_text ">예약확인</p>
					<p class="nav_text ">구매목록</p>
					<p class="nav_text ">문의내역</p>
					<p class="nav_text selected_nav">셰프신청</p>
				</div>
				<div class="col-10">
					<h4 class="border_bottom">셰프신청</h4>
					<br>

					<div class="row"> 
						<div class="col-10 ">
								
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
