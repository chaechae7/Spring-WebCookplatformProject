<%@page import="com.soda.onn.member.model.vo.Member"%>
<%@page import="com.soda.onn.chef.model.vo.Chef"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:requestEncoding value="utf-8"/>
<jsp:include page="/WEB-INF/views/common/header.jsp"> 
	<jsp:param value="셰프목록" name="pageTitle"/>
</jsp:include>
	<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/mypage/chef-request.css"/>

    <script>
        $(document).ready(function() {
            $(".chef-content").find("img").click(function() {
                location.href = "${pageContext.request.contextPath}/chef/chefpage/"+$(this).val();
            });
        });
    </script>
    <!-- 아이디, 비밀번호, 닉네임, 이름,연락처, 이메일, 주소(선택) , 생년월일  -->
    <div class="container">
        <div class="section">
            <div class="row">
				<jsp:include page="/WEB-INF/views/common/adminSidenav.jsp">
					<jsp:param value="셰프목록" name="sidenav"/>
				</jsp:include>
                <div class="col-10">
                    <h4 class="border_bottom">셰프목록</h4>
                    <br>

                    <br>
                    <div class="row">
                    
                    <c:forEach items="${chefList }" var="chef">
                    
                    
	                    <div class="col-6 row chef-content">
	                        <div class="col-6">
	                            <a href="${pageContext.request.contextPath }/chef/${chef.chefNickName}/chefPage"><img src="${pageContext.request.contextPath}/resources/upload/profile/${chef.chefProfile}" 
	                            alt="" class="chef_list_img"></a>
	                        </div>
	                        <div class="col-4 che-list-p">
	                            <p>${chef.chefNickName}</p>
	                            <p>${chef.chefEmail }</p>
	                            <p><jstr>${chef.chefCategory }</jstr></p>
	                        </div>
	                        <div class="col-2"></div>
	                    </div>
                    </c:forEach>
	

	                </div>
                </div>
            </div>
        </div>
    </div>

<script>
$("jstr").each(function(index,jstr){
	$(this).text($(this).text().replace(/\{|\}|\[|\]|\"|:|value/g,""));
});
</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
