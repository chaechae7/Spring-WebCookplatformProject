<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:requestEncoding value="utf-8"/>
<jsp:include page="/WEB-INF/views/common/header.jsp"> 
	<jsp:param value="회원목록" name="pageTitle"/>
</jsp:include>
    <link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/mypage/user-list.css" />

    <script>
        $(function() {
            $(".user-select-area").on("click", function() {
                let userid = $(this).find(".user-id").val();
                location.href = "링크" + userid;
            });
        });
    </script>
    <!-- 아이디, 비밀번호, 닉네임, 이름,연락처, 이메일, 주소(선택) , 생년월일  -->
    <div class="container">
        <div class="section">
            <div class="row">
				<jsp:include page="/WEB-INF/views/common/adminSidenav.jsp">
					<jsp:param value="회원목록" name="sidenav"/>
				</jsp:include>
                <div class="col-10">
                    <h4 class="border_bottom">회원목록</h4>
                    <br>
                    <table class="table">
                        <thead>
                            <tr>
                                <th>아이디</th>
                                <th>닉네임</th>
                                <th>이메일</th>
                                <th>가입일</th>
                            </tr>
                        </thead>
                        <tbody>
                        	<c:if test="${memberList != null }">
                        	<c:forEach items="${memberList}" var="member" >
	                            <tr class="user-select-area">
	                                <td class="user-id">${member.memberId }</td>
	                                <td>${member.memberNick }</td>
	                                <td>${member.email }</td>
	                                <td scope="row">${member.regDate}</td>
	                            </tr>
                            </c:forEach>
							</c:if>
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
