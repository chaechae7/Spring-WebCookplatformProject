<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:requestEncoding value="utf-8"/>
<jsp:include page="/WEB-INF/views/common/header.jsp"> 
	<jsp:param value="" name="pageTitle"/>
</jsp:include>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/mypage/user-list.css"/>

<!-- 아이디, 비밀번호, 닉네임, 이름,연락처, 이메일, 주소(선택) , 생년월일  -->
	<div class="container">
		<div class="section">
			<div class="row">
				<div class="col side_nav">
					<a href="${pageContext.request.contextPath}/admin/adminMain"><p class="nav_text ">내 정보보기</p></a>
					<a href="${pageContext.request.contextPath}/admin/sellList"><p class="nav_text ">판매목록</p></a>
					<a href="${pageContext.request.contextPath}/admin/adminQnaMsg"><p class="nav_text ">1:1 문의</p></a>
					<a href="${pageContext.request.contextPath}/admin/chefInsertList"><p class="nav_text">셰프신청목록</p></a>
					<a href="${pageContext.request.contextPath}/admin/sendDingdong"><p class="selected_nav">알림보내기</p></a>
				</div>
				<div class="col-10">
					<h4 class="border_bottom">알림 목록</h4>
					<br>
					<table class="table">
						<thead>
						  <tr>
							<th>번호 </th>
							<th>알림 메모</th>
						  </tr>
						</thead>
						<tbody>
							<c:forEach var="dingdong" items="${list }">
							      <tr class="user-select-area">
										<th scope="row">${dingdong.dingdongNo }</th>
										<td class="user-id">${dingdong.dingdongContent}</td>
								  </tr>
							 </c:forEach>
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
