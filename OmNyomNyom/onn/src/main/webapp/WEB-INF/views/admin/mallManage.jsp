<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:requestEncoding value="utf-8"/>
<jsp:include page="/WEB-INF/views/common/header.jsp"> 
	<jsp:param value="" name="pageTitle"/>
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
					<jsp:param value="예약목록" name="sidanav"/>
				</jsp:include>
                <div class="col-10">
                    <h4 class="border_bottom">판매목록</h4>
                    <br>
                    <table class="table">
                        <thead>
                            <tr>
                                <th> </th>
                                <th>주문번호</th>
                                <th>구매자(닉네임)</th>
                                <th>결제금액</th>
                                <th>결제일</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr class="user-select-area">
                                <th scope="row">1</th>
                                <td class="order-num">202048658</td>
                                <td>1종원</td>
                                <td>2020원</td>
                                <td>2020.03.20 15:34</td>
                            </tr>
                            <tr class="user-select-area">
                                <th scope="row">1</th>
                                <td class="order-num">202048658</td>
                                <td>닉네임</td>
                                <td>2020원</td>
                                <td>2020.03.20 15:34</td>
                            </tr>
                            <tr class="user-select-area">
                                <th scope="row">1</th>
                                <td class="order-num">202048658</td>
                                <td>2종원</td>
                                <td>2020원</td>
                                <td>2020.03.20 15:34</td>
                            </tr>
                            <tr class="user-select-area">
                                <th scope="row">1</th>
                                <td class="order-num">202048658</td>
                                <td>1종원</td>
                                <td>2020원</td>
                                <td>2020.03.20 15:34</td>
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
