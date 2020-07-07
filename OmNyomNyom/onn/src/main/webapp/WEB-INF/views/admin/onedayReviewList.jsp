<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:requestEncoding value="utf-8"/>
<jsp:include page="/WEB-INF/views/common/header.jsp"> 
	<jsp:param value="후기목록" name="pageTitle"/>
</jsp:include>
    <link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/mypage/user-list.css" />
    <script>
        $(function() {
            $(".user-select-area").on("click", function() {
                let userid = $(this).find(".order-num").val();
                location.href = "링크" + userid;
            });
        });
    </script>

    <!-- 아이디, 비밀번호, 닉네임, 이름,연락처, 이메일, 주소(선택) , 생년월일  -->
    <div class="container">
        <div class="section">
            <div class="row">
				<jsp:include page="/WEB-INF/views/common/adminSidenav.jsp">
					<jsp:param value="후기목록" name="sidenav"/>
				</jsp:include>
                <div class="col-10">
                    <h4 class="border_bottom">후기목록</h4>
                    <br>
                    <table class="table">
                        <thead>
                            <tr class="row">
                                <th class="col-2">원데이 클래스</th>
                                <th class="col-8">후기내용</th>
                                <th class="col-2">작성자<br>날짜</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr class="user-select-area row">
                                <td class="order-num col-2">흣차흣차</td>
                                <td class="col-8">Lorem ipsum dolor sit amet consectetur adipisicing elit. Amet voluptas autem iusto nisi in asperiores ab, consequuntur quia. Quae molestiae quibusdam illo reprehenderit iusto provident nisi corrupti, necessitatibus sit
                                    amet?
                                </td>
                                <td class="col-2">2020.03.20<br>15:34</td>
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
