<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:requestEncoding value="utf-8"/>
<jsp:include page="/WEB-INF/views/common/header.jsp"> 
	<jsp:param value="예약목록" name="pageTitle"/>
</jsp:include>
	<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/mypage/user-list.css"/>
	<script>
		/* $(function(){
			$(".user-select-area").on("click",function(){
				let userid = $(this).find(".order-num").val();
				location.href = "링크"+userid;
			});
		}); */

	</script>
<!-- 아이디, 비밀번호, 닉네임, 이름,연락처, 이메일, 주소(선택) , 생년월일  -->
	<div class="container">
		<div class="section">
			<div class="row">
			<jsp:include page="/WEB-INF/views/common/adminSidenav.jsp">
				<jsp:param value="예약목록" name="sidenav"/>
			</jsp:include>
				<div class="col-10">
					<h4 class="border_bottom">예약목록</h4>
					<br>
					<table class="table">
						<thead>
						  <tr class="row">
						  </tr>
						</thead>
						<tbody>
						  <tr class="user-select-area row">
							<td class="col-2 text-ag">예약번호</td>
							<td class="order-num col-2 text-ag">클래스</td>
							<td class="col-2 text-ag">진행일</td>
							<td	class="col-2 text-ag">신청인</td>
							<td class="col-2 text-ag">인원<br>(금액)</td>
							<td class="col-2 text-ag">결제금액<br>결제일</td>
						  </tr>
						  <c:forEach items="${reservationList}" var="reser">
						  <tr class="user-select-area row">
							  <td class="col-2 text-ag">${reser.reservationNo }<br></td>
							  <td class="col-2">${reser.onedayClassName }</td>
							  <td class="col-2 text-ag">${reser.onedayTime }<br></td>
							  <td class="col-2 text-ag">${reser.memberName}</td>
							  <td class="col-2 text-ag">${reser.personnel }인<br>(
							  <fmt:formatNumber value="${reser.totalPrice/reser.personnel}" pattern="#,###" />원)</td>
							  <td class="col-2 text-ag">
							  <fmt:formatNumber value="${reser.totalPrice}" pattern="#,###" />
							  <br>${reser.onedayTime }</td>
						  </tr>
						  </c:forEach>
						</tbody>
					  </table>
	  				<c:if test="${paging != null }">
						${paging}
					</c:if>	
				</div>
			</div>
		</div>
	</div>




<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
