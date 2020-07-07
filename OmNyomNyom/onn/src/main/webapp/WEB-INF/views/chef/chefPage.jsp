<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:requestEncoding value="utf-8"/> <!-- 인코딩설정 안해주면 한글 깨짐  -->
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="채널가기" name="pageTitle"/>
</jsp:include>
<!--  -->
    <link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/chefpage.css">
<style>
.onedaycc h4{
	padding: 0 5px;
	overflow: hidden;
	text-overflow: ellipsis;
	white-space: nowrap;
}
</style>
    
    <script>
        var tag = document.createElement('script'); //이거 뭔지 모름
        tag.src = "https://www.youtube.com/iframe_api"; //api 주소
        var firstScriptTag = document.getElementsByTagName('script')[0]; //이거 뭔지 모름
        firstScriptTag.parentNode.insertBefore(tag, firstScriptTag); //이거 뭔지 모름
        var player; //유튜브 api 전역변수
        var setVideoId = "${chef.chefMainvideo}"; //유튜브영상 ID
        function onYouTubeIframeAPIReady() {
            player = new YT.Player('testPTag', {
                videoId: setVideoId,
            });
        }


        //유튜브 영상 redirect
        function hreflink(s) {
            player.loadVideoById(setVideoId, s);
        }
       
    </script>
    
    <script>
    
    function recipeUpload() {
		location.href="${pageContext.request.contextPath}/recipe/recipeUpload.do";
	};
    function recipeUpdate() {
    	location.href="${pageContext.request.contextPath}/recipe/recipeUpdate.do";
		
	};
	function classManage() {
		location.href="${pageContext.request.contextPath}/oneday/class_manager.do";
	};
	function classUpload(){
		location.href="${pageContext.request.contextPath}/oneday/class_insert.do";
	}
    
    </script>		
    <section class="page-top-section page-sp set-bg" data-setbg="">
        <div class="container">
            <div class="row">
                <div class="col-lg-7 m-auto text-white">

                    <h2>${chef.chefNickName}CHEF CHANNAL</h2>
					<p>환영합니다~ 요리와 썸타보실래요?</p>
                </div>
            </div>
        </div>
    </section>


    
    <section class="classes-details-section spad overflow-hidden">
        <div class="container">
            <!--  셰프채널 navbar -->
            <div class="row">
                <div class="col-lg-12">
                    <ul class="nav nav-pills nav-fill">
                        <li class="nav-item">
                            <a style=" font-weight:900; "class="nav-link" id="home-tab" data-toggle="tab" href="#home" role="tab" aria-controls="home" aria-selected="ture">홈</a>
                        </li>
                        <li class="nav-item">
                            <a  style=" font-weight:900; " class="nav-link" id="profile-tab" data-toggle="tab" href="#video" role="tab" aria-controls="profile" aria-selected="false">레시피</a>
                        </li>
                
                        <li class="nav-item">
                            <a  style="font-weight:900; " class="nav-link" id="contact-tab" data-toggle="tab" href="#notice" role="tab" aria-controls="contact" aria-selected="false">공지사항</a>
                        </li>
                        <li class="nav-item">
                            <a  style="font-weight:900; " class="nav-link" id="contact-tab" data-toggle="tab" href="#onedayclass" role="tab" aria-controls="contact" aria-selected="false">원데이 클래스</a>
                        </li>
                    </ul>
                </div>
               

                <div class="tab-content" id="myTabContent">
                    <div class="tab-pane fade show active" id="home" role="tabpanel" aria-labelledby="home-tab">
                        <div class="container">
                            <div class="row">
                                <!-- 셰프 대표영상 start  -->
                                <div class="col-lg-5">
                                    <div class="chef-home-details">
                                        <div class="classes-preview">
                                            <div id="youtubevideo">
                                                <div class="chef-home-video" id="testPTag"></div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <!-- 셰프 프로필 -->
                                <div class="col-lg-7">
                                    <div class="trainer-details infobox" id="chef-details">
                                        <div class="trainer-info">
                                            <div class=" col-lg-5 pull-left">
                                                <!-- 셰프프로필 사진  -->
                                                <img src="${pageContext.request.contextPath}/resources/upload/profile/${chef.chefProfile}" alt="">
                                                <!-- 셰프 sns옵션 -->
                                                 <div class="td-social " style="height:50px;">
                                                   <!--  <a href="#"><i class="fa fa-facebook"></i></a>
                                                    <a href="#"><i class="fa fa-instagram"></i></a>
                                                    <a href="#"><i class="fa fa-twitter"></i></a>
                                                    <a href="#"><i class="fa fa-linkedin"></i></a> -->
                                                </div> 
                                            </div>
                                            </div>
                                            <div class="td-right col-lg-7 chefinfo">
                                                <h3>${chef.chefNickName}</h3>
                                                <h6>${chef.chefId }</h6>
                                                <ul style="list-style:none;">
                                                    <li><strong>개설일</strong>
                                                        <p>${chef.chefRegDate }</p>
                                                    </li>
                                                    <li><strong>이메일</strong>
                                                        <p>${chef.chefEmail }</p>
                                                    </li>
                                                    <li><strong>사업장 정보</strong>
                                                        <p>${chef.businessInfo }</p>
                                                    </li>
                                                </ul>
                                            </div>
                                        </div>
                                    </div>
                                <!-- 쉐프 텍스트들어가는 부분 -->
                                <div class="container">
                                    <div class="row">
                                        <div class="trainer-details col-lg-12" id="chef-details" style="margin-top:-200px; ">
                                            <div class="chefContent" style="margin:10px; "> ${chef.chefContent}</div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                        </div>
                        <hr>
                        <!-- 홈-인기동영상 -->
                        <div class="container" id="fav-video">
                            <h6>인기 레시피</h6>
                            <div class="row">
                               <c:forEach items="${ popList}" var="recipe" end="3">
	                                <div class="col-lg-3 upload-video">
	                                <a href="${pageContext.request.contextPath }/recipe/recipe-details?recipeNo=${recipe.recipeNo}">
	                                    <img src="https://img.youtube.com/vi/${recipe.videoLink }/mqdefault.jpg" alt="" width="300" height="150">
	                                    <h6 style="margin-top:10px;">${recipe.videoTitle}</h6>
	                                    </a>
	                                    <li style="font-size: 13px; color:gray; margin-top:2px;">조회수 : ${recipe.viewCount}회</li>
	                                </div>
                              </c:forEach>
                            </div>
                        </div>
                        <hr>
                        <!-- 홈-업로드한 동영상 -->
                        <div class="container" id="upload-video">

                            <h6>업로드한 레시피 </h6>
                            
                            <div class="row">
                                 <c:forEach items="${recipeList}" var="recipe" end="3">
	                                <div class="col-lg-3 upload-video">
	                                <a href="${pageContext.request.contextPath }/recipe/recipe-details?recipeNo=${recipe.recipeNo}">
	                                    <img src="https://img.youtube.com/vi/${recipe.videoLink }/mqdefault.jpg" alt="" width="300" height="150">
	                                    <h6 style="margin-top:10px;">${recipe.videoTitle}</h6>
	                                    </a>
	                                    <li style="font-size: 13px; color:gray; margin-top:2px;">조회수 : ${recipe.viewCount}회</li>
	                                </div>
                              </c:forEach>
                            </div>
                        </div>
                    </div>
                    
 <!-- 레시피 탭 클릭시 나오는 모든 영상 (업로드 순) -->
                    <div class="tab-pane fade" id="video" role="tabpanel" aria-labelledby="profile-tab">
                        <div class="upvideo container" id="video-upload-video">
                           <h6>업로드한 레시피 </h6>
                           <c:if test="${memberLoggedIn.memberId eq chef.chefId}"> 
	                            <div class="row">
	                                <div class="col-lg-12">
	                                    <button type="button" class="btn btn-outline-danger" onclick="recipeUpdate();">레시피 관리</button>
	                                    <button type="button" class="btn btn-outline-danger" onclick="recipeUpload();">레시피 업로드</button>
	                                </div>
	                            </div>
								<script>
								function recipeUpload(){
									location.href ="${pageContext.request.contextPath }/recipe/recipeUpload";
								}
								function recipeUpdate(){
									location.href ="${pageContext.request.contextPath }/recipe/recipeUpdate?chefNickName=${chef.chefNickName}";
								}
								</script>
                            </c:if>
	                     	<div class="row">
	                            <c:forEach items="${recipeList}" var="recipe">
	                                <div class="col-lg-3 upload-video">
	                          			<a href="${pageContext.request.contextPath }/recipe/recipe-details?recipeNo=${recipe.recipeNo}">
	                                    <img src="https://img.youtube.com/vi/${recipe.videoLink }/mqdefault.jpg" alt="" width="300" height="150">
	                                    <h6 style="margin-top:10px;">${recipe.videoTitle}</h6>
	                                	</a>
	                                    <li style="font-size: 13px; color:gray; margin-top:2px;">조회수 : ${recipe.viewCount}회</li>
	                                </div>
	                              </c:forEach>
	                        </div>
                        </div>
                        
                        <!-- <div class="site-pagination pt-3.5">
                            <a href="#"><i class="material-icons">keyboard_arrow_left</i></a>
                            <div class="site-pagination pt-3.5">
                                <a href="#" class="active">1</a>
                                <a href="#">2</a>
                                <a href="#">3</a>
                            	<a href="#"><i class="material-icons">keyboard_arrow_right</i></a>
                            </div>
                        </div> -->

                    </div>

                  
                    <!-- 공지사항 탭을 누르면 나오는 게시판목록 -->
                    <div class="tab-pane fade" id="notice" role="tabpanel" aria-labelledby="contact-tab">
                        

                        <!-- 아코디언 게시판 -->
                        <div class="container">
                    
                         <c:if test="${memberLoggedIn.memberRoll eq 'C'}"> 
                        	 <div class="row">
                                <div class="col-lg-12 ">
                                    <a class="btn btn-default noticeWrite" href="${pageContext.request.contextPath}/chef/chefNotice">글쓰기</a>
                                </div>
                            </div>
                          </c:if> 
                          
                            <div class="row">
                                <div class="col-lg-12">
                                    <div class="accordion" id="accordionExample">
                                    <c:forEach items="${ noticeList}" var="notice">
		                                        <div class="card">
		                                            <div class="card-header notice_header" id="headingOne">
		                                                <h2 class="mb-0">
		                                                    <button class="btn btn-link notice_content" type="button" data-toggle="collapse" data-target="#collapseOne" aria-expanded="true" aria-controls="collapseOne">
		                                                <ul class="notice_content">
		                                                    <li>${notice.noticeCategory }</li>
		                                                    <li>${notice.noticeTitle }</li>
		                                                    <li style="float:right;">${notice.regDate}</li>
		                                                </ul>
		                                              </button>
		                                                </h2>
		                                            </div>
		
		                                            <div id="collapseOne" class="collapse" aria-labelledby="headingOne" data-parent="#accordionExample">
		                                                <div class="card-body">
		                                                 
		                                                  	${notice.noticeContent}
		                                                  	<c:if test="${memberLoggedIn.memberRoll eq 'C'}"> 
		                                                 		<a href="${pageContext.request.contextPath }/chef/noticeView?noticeNo=${notice.noticeNo }"> 상세보기 </a>
		                                                  	</c:if>
		                                                </div>
		                                            </div>
		                                        </div>
                                        </c:forEach>
                                    </div>
                                </div>
                            </div>
                           
                            <div class="site-pagination pt-3.5">
                                <a href="#"><i class="material-icons">keyboard_arrow_left</i></a>
                                <div class="site-pagination pt-3.5">
                                    <a href="#" class="active">1</a>
                                    <a href="#">2</a>
                                    <a href="#">3</a>
                                    <a href="#"><i class="material-icons">keyboard_arrow_right</i></a>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    
                    
                    
                 <!-- 클래스 목록들 start -->
                    <div class="tab-pane fade" id="onedayclass" role="tabpanel" aria-labelledby="contact-tab">
                       <div class="row" style="width:1100px; margin-top:40px;">
                            <div class="col-lg-6">
                                <h6 class="" >신규 클래스</h6>
                            </div>
                            <c:if test="${memberLoggedIn.memberRoll eq 'C' and memberLoggedIn.memberNick eq chef.chefNickName}"> 
	                            <div class="col-lg-6">
	                                <button type="button" class="btn btn-outline-danger" onclick="classManage();" style="width:200px; flaot:right;">클래스 관리</button>
	                                <button type="button" class="btn btn-outline-danger" onclick="classUpload();" style="width:200px; flaot:right;">클래스 업로드</button>
	                            </div>
                            </c:if>
                        </div>
                        <div class="row">
                         <c:forEach items="${onedayList }" var="oneday" varStatus="vs">
			                <div class="col-md-3">
			                    <div class="classes-item-warp">
			                        <div class="classes-item item_rate">
			                            <div class="ci-img">
			                                <img src="${pageContext.request.contextPath }/resources/upload/onedayclass/${oneday.onedayImg}" alt="클래스 사진">
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
			                                <a href= "${pageContext.request.contextPath }/oneday/oneday_detail?onedayclassNo=${oneday.onedayclassNo}" class="site-btn sb-gradient">예약하기</a>
			                            </div>
			                        </div>
			                    </div>
			                </div>                
			            </c:forEach>
                        </div>
                        </div>

                       
                          
    </section>








<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>