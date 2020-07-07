<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:requestEncoding value="utf-8"/>
<jsp:include page="/WEB-INF/views/common/header.jsp"> 
	<jsp:param value="스크랩 목록" name="pageTitle"/>
</jsp:include>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/mypage/user-list.css"/>

<!-- 아이디, 비밀번호, 닉네임, 이름,연락처, 이메일, 주소(선택) , 생년월일  -->
	<div class="container">
		<div class="section">
			<div class="row">
				<div class="col side_nav">
					<a href="${pageContext.request.contextPath}/mypage/main"><p class="nav_text">내 정보보기</p></a>
					<a href="${pageContext.request.contextPath}/mypage/onedayList"><p class="nav_text ">예약확인</p></a>
					<a href="${pageContext.request.contextPath}/mypage/buyList"><p class="nav_text ">구매목록</p></a>
					<a href="${pageContext.request.contextPath}/chat/msg/sdmin"><p class="nav_text ">문의내역</p></a>
					<a href="${pageContext.request.contextPath}/mypage/scrapList"><p class="nav_text selected_nav">스크랩 목록</p></a>
					<a href="${pageContext.request.contextPath}/chef/chefInsert"><p class="nav_text">셰프신청</p></a>
					<a href="${pageContext.request.contextPath}/mypage/dingdongList"><p class="nav_text">알림목록</p></a>
				</div>
				<div class="col-10">
					<h4 class="border_bottom">스크랩 목록</h4>
					<br>
					<table class="table">
						<thead>
						  <tr class="row">
							<th class="col-4">레시피</th>
							<th class="col-2">셰프</th>
							<th class="col-2">스크랩 날짜</th>
							<th class="col-2">스크랩 메모</th>
							<td class="col"></td>
						  </tr>
						</thead>
						<tbody>
							<c:forEach var="scrap" varStatus="vs" items="${list }">
							      <tr class="user-select-area row">
										<td class="col-4 user-id">${scrap.videoTitle}</td>
										<td class="col-2">${scrap.chefNick }</td>
										<td class="col-2">${scrap.regDate }</td>
										<td class="col-2"><input type="text" value="${scrap.meMo }" id="scrapMemo${vs.count }"/></td>
				    					<td class="col"><button type="submit" class=" btn btn-primary"  onclick="updateScrap(${scrap.recipeNo},'scrapMemo${vs.count }');">수정</button></td>
				    					<td class="col"><button type="button" class="btn btn-danger" onclick="deleteScrap(${scrap.recipeNo});">삭제</button></td>
								  </tr>
							 </c:forEach>
						</tbody>
					  </table>
					  <!-- <div class="site-pagination pt-3.5">
						<a href="#" class="active">1</a>
						<a href="#">2</a>
						<a href="#"><i class="material-icons">keyboard_arrow_right</i></a>
					</div> -->

				</div>
			</div>
		</div>
	</div>
<script>
	function deleteScrap(recipeNo){
		location.href = "${pageContext.request.contextPath}/mypage/deleteScrap?recipeNo="+recipeNo;
	}
	function updateScrap(recipeNo, scrapMemo){
		console.log("여기는 updateScrap이야");
		console.log($("#"+scrapMemo).val());
		location.href = "${pageContext.request.contextPath}/mypage/updateScrap?recipeNo="+recipeNo+"&meMo="+$("#"+scrapMemo).val();
	}
 
</script>


<jsp:include page="/WEB-INF/views/common/footer.jsp"/>