
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:requestEncoding value="utf-8"/>
<jsp:include page="/WEB-INF/views/common/header.jsp"> 
	<jsp:param value="안녕 옴뇸뇸!" name="pageTitle"/>
</jsp:include>
<style>
.onedaycc h4{
	padding: 0 5px;
	overflow: hidden;
	text-overflow: ellipsis;
	white-space: nowrap;
}
</style>

	<link href="${pageContext.request.contextPath }/resources/css/class-manager.css" rel="stylesheet" type="text/css">
    <!-- 원데이 클래스 관리 -->
        
    <section class="page-top-section page-sp set-bg" data-setbg="">
        <div class="container">
            <div class="row">
                <div class="col-lg-7 m-auto text-white">

                    <h2>${chef.chefNickName}CHEF CHANNAL</h2>
					<p>환영합니다~ 요리와 썸타보실래요?</p>
                </div>
            </div>
        </div>
            <div class="container">
       
    </div>
    </section>
    <section class="classes-details-section spad overflow-hidden">
        <!-- 컨테이너 시작 -->
        <div class="container">
            <!-- 버튼 부분 -->
            <div class="row">
                <div class="col clearfix">
                    <button type="button" class="btn btn-outline-danger float-right" id="classdel" name="classdel">클래스 삭제</button>
                    <button type="button" class="btn btn-outline-danger float-right" id="classupdate" name="classupdate">클래스 수정</button>
                </div>
            </div>
            <!-- 클래스 리스트 시작 -->
            <form role="form" method="post">
            <div class="row">
                <div class="row">
                         <c:forEach items="${onedayList }" var="oneday" varStatus="vs">
			                <div class="col-md-3">
			                    <div class="classes-item-warp">
			                        <div class="classes-item item_rate">
			                			<input type="checkbox" id="onedayclassNo" name="onedayclassNo" value="${oneday.onedayclassNo}"/>
			                             <div class="ci-img">
				                            <c:if test="${oneday.onedayImg != null}">
				                                <img src="${pageContext.request.contextPath }/resources/upload/onedayclass/${oneday.onedayImg}" alt="클래스 사진">
				                            </c:if>
				                            <c:if test="${oneday.onedayImg == null }">
				                            	 <img src="${pageContext.request.contextPath }/resources/images/onedayclassdefualtImg.PNG" alt="클래스 사진">
				                            </c:if>
				                          </div>
			                            <div class="ci-text onedaycc">
			                                <h4>${oneday.onedayName}</h4>
			                                <c:if test="${not empty oneday.onedayTimeList}">
			                                <c:forEach items="${oneday.onedayTimeList }" var="tl">
			                                <div class="ci-metas">
			                                 <c:if test="${tl.onedayNoo eq oneday.onedayclassNo}">
			                                    <div class="ci-meta"><i class="material-icons">event_available</i>${tl.onedayTimeDate }</div>
			                                    <%-- <div class="ci-meta"><i class="material-icons">${tl.onedayNoo}</i></div> --%>
			                                </c:if>
			                                </div>
			                                </c:forEach>
			                                </c:if>
			                                <p>${oneday.onedayclassNo}</p>
			                            </div>
			                            <div class="ci-bottom">
			                                <div class="ci-author">
			                                    <img src="${pageContext.request.contextPath }/resources/upload/profile/${chef.chefProfile}" alt="셰프 사진">
			                                    <div class="author-text">
			                                        <h6>${chef.chefNickName}</h6>
			                                        <p>${oneday.memberId }</p>
			                                    </div>
			                                </div>
			                                <!--  -->
			                                <a href= "${pageContext.request.contextPath }/oneday/oneday_update?onedayclassNo=${oneday.onedayclassNo}" class="site-btn sb-gradient">예약하기</a>
			                            </div>
			                        </div>
			                    </div>
			                </div>
			            </c:forEach>
                        </div>
                        </form>
                        <script>
                        var formObj = $("form[role='form']")
                        
                        $(document).ready(function(){
                   	
                        	$('#classdel').on('click', function(){
                        		
                        		var result = confirm("해당 클래스를 삭제하시겠습니까?");
                        		
                        		if(result){
                        		formObj.attr("action", "class_delete");
                        	/* 	formObj.attr("method", "post"); */
                        		formObj.submit();
                        		
                        		var onedayclassNo = $("#onedayclassNo").val();
                        			                        			
                        		}
                        		else{
                        			location.replace('${pageContext.request.contextPath}/oneday/class_manager');
                        			
                        		}
                        		
                        		
                        	});
                        	
                        	$('#classupdate').on('click', function(){
                        		var update = confirm("해당 클래스를 수정하시겠습니까?");
                        		
                        		if(update){
                        			formObj.attr("action", "oneday_update");
                        			formObj.submit();
                        			
                        			var onedayclassNo = $("#onedayclassNo").val();
                        		}
                        		else{
                        			location.replace('${pageContext.request.contextPath}/oneday/class_manager');
                        		}

                        	});	

                        });
                      </script>  
                <!-- 페이지 바 -->
                <div class="container">
                    <div class="row">
                        <div class="col-lg-12">
                            <div class="site-pagination pt-3.5">
                                <a href="#" class="active">1</a>
                                <a href="#">2</a>
                                <a href="#"><i class="material-icons">keyboard_arrow_right</i></a>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- 페이지바 끝 -->
            </div>
            <!-- 클래스 리스트 끝 -->
        </div>
        <!-- 컨테이너 끝 -->
    </section>
    <!-- 원데이 클래스 관리 Section End -->


<jsp:include page="/WEB-INF/views/common/footer.jsp" />