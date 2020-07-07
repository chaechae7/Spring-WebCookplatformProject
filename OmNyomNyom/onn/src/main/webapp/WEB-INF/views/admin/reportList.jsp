<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:requestEncoding value="utf-8"/>
<jsp:include page="/WEB-INF/views/common/header.jsp"> 
	<jsp:param value="신고현황" name="pageTitle"/>
</jsp:include>
	<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/mypage/user-list.css"/>

<!-- 아이디, 비밀번호, 닉네임, 이름,연락처, 이메일, 주소(선택) , 생년월일  -->
	<div class="container">
		<div class="section">
			<div class="row">
			<jsp:include page="/WEB-INF/views/common/adminSidenav.jsp">
				<jsp:param value="신고현황" name="sidenav"/>
			</jsp:include>

				<div class="col-10">
					<h4 class="border_bottom">신고현황</h4>
					<br>
					<table class="table">
						<thead>
						  <tr>
							<th>신고자</th>
							<th>댓글</th>
							<th>신고일</th>
						  </tr>
						</thead>
						<tbody>
						<c:forEach var="Report" items="${list }">
						  <tr>
							<td>${Report.repMemberId }</td>
							<td>${Report.reportReason }</td>
							<td>${Report.reportDate }</td>
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
