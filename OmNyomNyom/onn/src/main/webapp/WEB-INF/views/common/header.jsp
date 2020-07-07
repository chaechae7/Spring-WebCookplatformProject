<%@page import="java.util.Enumeration"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Map"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%
//RedirectAttributes 객체 조회 : session에 저장된 객체 열람
		Enumeration<String> attrNames = session.getAttributeNames();
		while(attrNames.hasMoreElements()) {
			String name = attrNames.nextElement();
			System.out.printf("%s= %s%n",name,session.getAttribute(name));
		}
%>
<!DOCTYPE html>
<html lang="utf-8">

<head>
<title>${param.pageTitle}</title>
<meta charset="UTF-8">
<meta name="description" content="Ahana Yoga HTML Template">
<meta name="keywords" content="yoga, html">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="icon" href="${pageContext.request.contextPath }/resources/images/onn_logo_rec.png" title="OmNyomNyom"/>
<!-- 로그인 모달창 라이브러리 -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.0.0/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-modal/0.9.1/jquery.modal.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-modal/0.9.1/jquery.modal.min.css" />
<!-- Stylesheets -->
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/bootstrap.min.css" />
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.0/css/all.min.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/owl.carousel.min.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/nice-select.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/magnific-popup.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/slicknav.min.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/animate.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/util.css" />

<!-- Main Stylesheets -->
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/style.css" />
<!-- login.css -->
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/login.css" />

<!-- [if lt IE 9]>
<script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
<script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
<![endif] -->
<script src="${pageContext.request.contextPath }/resources/js/jquery-3.2.1.min.js"></script>
<script src="${pageContext.request.contextPath }/resources/js/bootstrap.min.js"></script>
<script src="${pageContext.request.contextPath }/resources/js/jquery.slicknav.min.js"></script>
<script src="${pageContext.request.contextPath }/resources/js/owl.carousel.min.js"></script>
<script src="${pageContext.request.contextPath }/resources/js/jquery.nice-select.min.js"></script>
<script src="${pageContext.request.contextPath }/resources/js/jquery-ui.min.js"></script>
<script src="${pageContext.request.contextPath }/resources/js/jquery.magnific-popup.min.js"></script>

<script src="${pageContext.request.contextPath }/resources/js/main.js"></script>
<!-- 회원가입 js -->

<c:if test="${empty memberLoggedIn}">
<script src="${pageContext.request.contextPath }/resources/js/signup.js"></script>

<script>

//사용 가능한 아이디, 닉네임인지 확인 하는 스크립트
$(document).ready(function(){

	//memberId input창에서 아이디를 입력 할 경우
	$("#memberId").on("keyup", function(){
		memberId = $(this).val().trim();

		//회원가입 아이디 input창에 값이 없으면 문구 숨김
		if($("#memberId").val()==''){
			$(".guide.error").hide();
			$(".guide.ok").hide();
		} 	
		if(memberId.length < 4)
			return;
		signupFun(this);
	});

	//memberNick input창에서 닉네임을 입력 할 경우
	$("#memberNick").on("keyup", function(){
		console.log("memberNick keyup");
		memberNick = $(this).val().trim();

		console.log($(this).val());

		//회원가입 닉네임 input창에 값이 없으면 문구 숨김
		if($("#memberNick").val()==''){
			$(".nickGuide.error").hide();
			$(".nickGuide.ok").hide();
		}

		signupFun(this);
	});


	//ajax 실행 메소드
	function signupFun(e){
		$.ajax({
			url:"${pageContext.request.contextPath}/member/checkMember/"+$(e).attr('id')+"/"+$(e).val(),
			type: "GET",
			success: data => {
				console.log(data);			
				if($(e).attr('id') == "memberId"){	
					if(data.isUsable != "ok"){
						$(".guide.error").hide();
						$(".guide.ok").show();
						$("#idDuplicateCheck").val(1);
					}
					else{
						$(".guide.error").show();
						$(".guide.ok").hide();
						$("#idDuplicateCheck").val(0);
					}
				}

				if($(e).attr('id') == "memberNick"){
					if(data.isUsable != "ok"){
						$(".nickGuide.error").hide();
						$(".nickGuide.ok").show();
						$("#idDuplicateCheck").val(1);
					}
					else{
						$(".nickGuide.error").show();
						$(".nickGuide.ok").hide();
						$("#idDuplicateCheck").val(0);
					}
				}
			},
			error: (x,s,e) => {
				console.log(x,s,e);
			}
		});
	}
});				



</script>

</c:if>

  
</head>
<body>

    <c:if test="${not empty msg}">
	<script>
		$(function(){
			alert("${msg}");
		});
	</script>
	</c:if>
	<% session.removeAttribute("msg"); %>
	    
    <!-- Page Preloder -->
    <div id="preloder">
        <div class="loader"></div>
    </div>
    <!-- Header Section -->
    <header class="header-section">
        <div class="header-bottom">
            <a href="${pageContext.request.contextPath}" class="site-logo">
                <img src="${pageContext.request.contextPath }/resources/images/onn_logo_red.png" alt="" class="main_logo">
            </a>
            <div class="hb-right" style="z-index: 1000;">
               
                <!-- 로그인버튼 -->
	                <div class="hb-switch  ${memberLoggedIn ==''?'':'infor-switch' }" >
	                    <a href="#ex1" rel="modal:open" ><span class="material-icons"  style="color:red;">person</span></a>
	                </div>
           		<c:if test="${not empty memberLoggedIn}">
           		<div class="hb-switch">
           		<div style="width:20px; height:20px; background-color:gray; border-radius:50%; position: absolute; top: 28px;  text-align:center;">
           			<p style="color:white;" id="dingdongNum">1</p>
           		</div>
           		<span class="material-icons  ${memberLoggedIn ==''?'':'infor-switch' }"  style="color:red;"> local_post_office </span>
           		</div>
           		<div class="hb-switch">
           			<span class="material-icons"  onclick="logout();" style="color:red;">power_settings_new</span>
           		</div>
           		<script>
           		function logout(){
           			location.href = "${pageContext.request.contextPath}/member/logout";
           		}
           		</script>
           		</c:if>
           		
           		<c:if test="${empty memberLoggedIn}">
           		
                <!-- 로그인/회원가입 form start -->
                <div class="hb-switch" >
                    <div id="ex1" class="modal">
                        <div class="login_container" id="login_container">
                            <div class="form-container sign-up-container">
                                <form action="${pageContext.request.contextPath }/member/enroll" method="POST" onsubmit="return validate();">
                                    <h1>회원가입</h1>
                                    
                                    <input type="text" placeholder="아이디를 입력하세요" id="memberId" name="memberId" required/>
                                    <span class="guide ok">이 아이디는 사용가능합니다.</span>
									<span class="guide error">이 아이디는 사용할 수 없습니다.</span>
									<input type="hidden" name="idDuplicateCheck"
							   			   id="idDuplicateCheck" value="0" />
                                    <span class="error" id="errorId"></span>
                                 
                                    
                                    <input type="password" name="memberPwd" id="password" placeholder="Password"  required >
                                    <span class="error" id="errorPw"></span>
                                    
                                    <input type="password" id="password_2" placeholder="Confirm Password"  required>
                                    <span class="error" id="errorPwChk"></span>
                                    
                                    <input type="email" placeholder="Email" id="email" name="email"  required/>
                                    <span class="error" id="errorEmail"></span>
                                    
                                    <input type="text" name="memberName" id="memberName" placeholder="Name" required>
                                    <span class="error" id="errorName"></span>
                                   
                                  
                                    <input type="text" placeholder="닉네임을 입력하세요" id="memberNick" name="memberNick" required/>
                                    <span class="nickGuide ok">이 닉네임은 사용가능합니다.</span>
									<span class="nickGuide error">이 닉네임은 사용할 수 없습니다.</span>
									<input type="hidden" name="nickidDuplicateCheck"
							   			   id="nickDuplicateCheck" value="0" />
                                    <span class="error" id="errorId"></span>
                                
                                  
                                    
                                    
                                    <input type="tel" placeholder="Phone Number(-없이)" name="phone" id="phone" maxlength="11" required>
                                    <span class="error" id="errorPhone"></span>
                                    
                                    <input type="number" name="ssn" id="ssn" placeholder="ex)19991122"required>
                                   
                                    <input type="address" name="address" id="address" placeholder="주소를 입력하세요" required>
                                    <span class="error" id="errorName"></span>
                                    
                                    <button type="submit" >회원가입</button>
                                    <!-- <input type="button" id="enrollBtn" value="회원가입"> -->
                                </form>
                            </div>
                            <div class="form-container sign-in-container">
                                <form action="${pageContext.request.contextPath }/member/login" method="get">
                                    <h1>로그인</h1>
                                    <!-- <div class="social-container">
                                        
                                        </div> -->
                                    <input type="text" placeholder="아이디를 입력하세요" name="loginId" id="loginId" />
                                    <input type="password" placeholder="Password" name="loginPassword" id="loginPassword" />
                                    <p><input type="checkbox" style="float: left; width: 20px;" name="saveId" id="saveId">
                                        <label for="saveId" style="float: left; font-size: 15px; margin-top:5px;">아이디 저장</label> </p>
                                    <!-- 아이디/비밀번호 찾기 페이지 -->
                                    <a href="">아이디/비밀번호 찾기</a>
                                    <button type="submit">옴뇸뇸 로그인</button>
                                    <div class="td-social">
                                      <!--   <a href="#"><i class="fa fa-facebook"></i></a>
                                        <a href="#"><i class="fa fa-instagram"></i></a>
                                        <a href="#"><i class="fa fa-twitter"></i></a>
                                        <a href="#"><i class="fa fa-linkedin"></i></a> -->
                                    </div>
                                </form>
                            </div>
                            <div class="overlay-container">
                                <div class="overlay">
                                    <div class="overlay-panel overlay-left">
                                        <h1>OmNyomNyom 회원가입</h1>
                                        <p></p>
                                        <button class="ghost" id="signIn">로그인</button>
                                    </div>
                                    <div class="overlay-panel overlay-right">
                                        <h1>OmNyomNyom 오서오세요</h1>
                                        <p>옴뇸뇸에 오신 것을 환영합니다.</p>
                                        <button class="ghost" id="signUp">회원가입</button>
                                    </div>
                                </div>
                            </div>
                        </div>

                    </div>
                </div>
                <!-- 로그	인/회원가입 form end-->
              
               </c:if>
            </div>
            <div class="container">
                <ul class="main-menu">
                    <li><a href="${pageContext.request.contextPath }/recipe/recipe-menu-search" class="active">레시피</a>
                        <ul class="sub-menu">
                            <li><a href="${pageContext.request.contextPath }/recipe/recipe-menu-search">메뉴</a></li>
                            <li><a href="${pageContext.request.contextPath}/recipe/ingredientsSelection">냉장고 재료</a></li>
                        </ul>
                    </li>
                    <li><a href="${pageContext.request.contextPath}/mall/main">뇸뇸몰</a></li>
                    <li><a href="${pageContext.request.contextPath}/chef/chefList">셰프</a></li>
                    <li><a href="${pageContext.request.contextPath}/oneday/oneday">원데이 클래스</a></li>
                    <li><a href="contact.html">사이트 안내</a>
                        <ul class="sub-menu">
                            <li><a href="classes.html">사이트 소개</a></li>
                            <li><a href="classes-details.html">공지사항</a></li>
                            <li><a href="classes-details.html">FAQ</a></li>
                        </ul>
                    </li>
                </ul>
            </div>
        </div>
    </header>
    <!-- Header Section end -->
    
    	<!-- Main Stylesheets -->
	<c:if test="${not empty memberLoggedIn}">
	<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/info.css"/>
	<!-- Infor Model -->
	<div class="infor-model-warp">
		<div class="infor-model d-flex align-items-center">
			<div class="infor-close">
				<i class="material-icons">close</i>
			</div>
			<div class="infor-middle">
				<!-- 로그인 후 간단한 회원정보 출력해줌 -->
				<c:choose>
					<c:when test="${memberLoggedIn.memberRoll eq 'A' }">
						<p style="position : relative; margin-top:-50px;"><a href="${pageContext.request.contextPath }/admin/adminMain">${memberLoggedIn.memberNick }</a>, 오늘도 옴뇸뇸을 방문해 주셔서 감사합니다. <br/> 행복한 하루 되세요!</p>
					</c:when>
					<c:when test="${memberLoggedIn.memberRoll eq 'C' }">
						
						<p style="position : relative; margin-top:-50px;"><a href="${pageContext.request.contextPath }/chef/chefMain">${memberLoggedIn.memberNick }</a>, 오늘도 옴뇸뇸을 방문해 주셔서 감사합니다. <br/> 행복한 하루 되세요!</p>
					</c:when>
					<c:otherwise>
						
						<p style="position : relative; margin-top:-50px;"><a href="${pageContext.request.contextPath }/mypage/main">${memberLoggedIn.memberNick }</a>, 오늘도 옴뇸뇸을 방문해 주셔서 감사합니다. <br/> 행복한 하루 되세요!</p>	
					</c:otherwise>
				</c:choose>

				<!-- 바로가기기능 -->
				<div class="insta-imgs">
				<input type="hidden" value="${memberLoggedIn.memberId }" id="loggedMemberId">
							<!-- 유저 등급에 따른 리모컨 분기처리 -->
					<c:choose>
						<c:when test="${memberLoggedIn.memberRoll eq 'A' }">
							<div class="insta-item">
								<div class="insta-img">
									<img src="img/infor/back.PNG" alt="">
									<div class="insta-hover">
										<a href="${pageContext.request.contextPath }/admin/mallManage"> 
										<p>주문내역확인</p>
										</a>
									</div>
								</div>
							</div>
							<div class="insta-item">
								<div class="insta-img">
									<img src="img/infor/back.PNG" alt="">
									<div class="insta-hover">
										<a href="${pageContext.request.contextPath }/admin/ingredientList"> 
										<p>상품관리</p>
										</a>
									</div>
								</div>
							</div>
							<div class="insta-item">
								<div class="insta-img">
									<img src="img/infor/back.PNG" alt="">
									<div class="insta-hover">
										<a href="${pageContext.request.contextPath }/admin/chefRequestList"> 
										<p>셰프신청목록</p>
										</a>
									</div>
								</div>
							</div>
							<div class="insta-item">
								<div class="insta-img">
									<img src="img/infor/back.PNG" alt="">
									<div class="insta-hover">
										<a href="${pageContext.request.contextPath }/admin/reportList"> 
										<p>신고현황</p>
										</a>
									</div>
								</div>
							</div>
							<div class="insta-item">
								<div class="insta-img">
									<img src="img/infor/back.PNG" alt="">
									<div class="insta-hover">
										<a href="${pageContext.request.contextPath }/admin/memberList"> 
										<p>회원조회</p>
										</a>
									</div>
								</div>
							</div>
							<div class="insta-item">
								<div class="insta-img">
									<img src="img/infor/back.PNG" alt="">
									<div class="insta-hover">
										<a href="${pageContext.request.contextPath }/chat/msg/sims1"> 
										<p>문의내역</p>
										</a>
									</div>
								</div>
							</div>
						</c:when>
						<c:otherwise>
							<c:if test="${memberLoggedIn.memberRoll eq 'C' }">
								<div class="insta-item">
									<div class="insta-img">
										<img src="img/infor/back.PNG" alt="">
										<div class="insta-hover">
										<a href="${pageContext.request.contextPath }/chef/${memberLoggedIn.memberNick }/chefPage">
											<p>채널가기</p>
										</a>
										</div>
									</div>
								</div>
								<div class="insta-item">
									<div class="insta-img">
										<img src="img/infor/back.PNG" alt="">
										<div class="insta-hover">
										<a href="${pageContext.request.contextPath }/recipe/recipeUpload">
											<p>레시피 등록</p>
										</a>
										</div>
									</div>
								</div>
								<div class="insta-item">
									<div class="insta-img">
										<img src="img/infor/back.PNG" alt="">
										<div class="insta-hover">
										<a href="${pageContext.request.contextPath }/oneday/class_insert">
											<p>원데이 등록</p>
										</a>
										</div>
									</div>
								</div>
								<div class="insta-item">
								<div class="insta-img">
									<img src="img/infor/back.PNG" alt="">
									<div class="insta-hover">
									<a href="${pageContext.request.contextPath }/chef/onedayList">
										<p>예약확인</p>
									</a>
									</div>
								</div>
							</div>
							<div class="insta-item">
								<div class="insta-img">
									<img src="img/infor/back.PNG" alt="">
									<div class="insta-hover">
									<a href="${pageContext.request.contextPath }/chef/chefbuyList">
										<p>구매목록</p>
									</a>
									</div>
								</div>
							</div>
							<div class="insta-item">
								<div class="insta-img">
									<img src="img/infor/back.PNG" alt="">
									<div class="insta-hover">
									<a href="${pageContext.request.contextPath }/mall/cart">
										<p>장바구니</p>
									</a>
									</div>
								</div>
							</div>
							<div class="insta-item">
								<div class="insta-img">
									<img src="img/infor/back.PNG" alt="">
									<div class="insta-hover">
									<a href="${pageContext.request.contextPath}/chef/chefscrapList">
										<p>스크랩 목록</p>
									</a>
									</div>
								</div>
							</div>
								
								
								<!-- dsflkjasdfljdsklfjsdflk -->
							</c:if>
							<c:if test="${memberLoggedIn.memberRoll eq 'M' }">
							<div class="insta-item">
								<div class="insta-img">
									<img src="img/infor/back.PNG" alt="">
									<div class="insta-hover">
									<a href="${pageContext.request.contextPath }/mypage/onedayList">
										<p>예약확인</p>
									</a>
									</div>
								</div>
							</div>
							<div class="insta-item">
								<div class="insta-img">
									<img src="img/infor/back.PNG" alt="">
									<div class="insta-hover">
									<a href="${pageContext.request.contextPath }/mypage/buyList">
										<p>구매목록</p>
									</a>
									</div>
								</div>
							</div>
							<div class="insta-item">
								<div class="insta-img">
									<img src="img/infor/back.PNG" alt="">
									<div class="insta-hover">
									<a href="${pageContext.request.contextPath }/mall/cart">
										<p>장바구니</p>
									</a>
									</div>
								</div>
							</div>
							<div class="insta-item">
								<div class="insta-img">
									<img src="img/infor/back.PNG" alt="">
									<div class="insta-hover">
									<a href="${pageContext.request.contextPath}/mypage/scrapList">
										<p>스크랩 목록</p>
									</a>
									</div>
								</div>
							</div>
							</c:if>
							<c:if test="${memberLoggedIn.memberRoll eq 'C' }">
								<div class="insta-item">
									<div class="insta-img">
										<img src="img/infor/back.PNG" alt="">
										<div class="insta-hover">
										<a href="${pageContext.request.contextPath }/chef/reservationStatus">
											<p>예약현황</p>
										</a>
										</div>
									</div>
								</div>
							</c:if>

							<c:if test="${memberLoggedIn.memberRoll eq 'M' }">
								<div class="insta-item">
									<div class="insta-img">
										<img src="img/infor/back.PNG" alt="">
										<div class="insta-hover">
										<a href="${pageContext.request.contextPath }/chef/chefInsert">
											<p>셰프신청</p>
										</a>
										</div>
									</div>
								</div>
							</c:if>
							<div class="insta-item">
								<div class="insta-img">
									<img src="img/infor/back.PNG" alt="">
									<div class="insta-hover">
									<a href="${pageContext.request.contextPath }/chat/main">
										<p>1:1 문의</p>
									</a>
									</div>
								</div>
							</div>
						</c:otherwise>
					</c:choose>
	

				</div>
				<!-- 알림창 -->
				
					<p style="margin-top:-50px; font-size: 16px; font-weight: 600; ">알리미</p>
				 
						<div class="toast-header row" id="toast-header">
						  <span class="material-icons">sms</span>
						  <strong class="mr-auto">새로운 알림이 있습니다!</strong>
						  <small>11 mins ago</small>
							<span aria-hidden="true">&times;</span>
						</div>
				<script>
				$('#myToast').on('hidden.bs.toast', function () {
				// do something...
				});
				
				$(document).ready(function(){
					
					$(".toast-header").empty();
	            	 $.ajax({
							url:"${pageContext.request.contextPath}/mypage/dingDongList?cPage=1",
							method:"GET",
							datatype:"json",
							success: data => {
								
								let dingdongNum = (data.dingList).length;
								
								$("#dingdongNum").empty();
								$("#dingdongNum").text(dingdongNum);
								$.each(data.dingList,function(index,item){

									console.log('dingdong='+index);
									let linkArr = item.dingdongLink.split('?');
									let ddingddongLink = '';
									
									for(var i = 0 ; linkArr.length>i  ; i++ ){
										if(i>0)
											ddingddongLink += "&";
										ddingddongLink += linkArr[i];
										if(i == 0)
											ddingddongLink+='?dingdongNo='+item.dingdongNo;
									}
									console.log('ddingddongLink'+ddingddongLink);
									let p ='<div class="col-lg-12" style="display: flex;"><a href="${pageContext.request.contextPath }/'+ddingddongLink+'"><span class="material-icons">sms</span>'+

									'<strong class="mr-auto">'+item.dingdongContent+'</strong>'+
									 '<small>'+item.dingRegDate+'</small>'+
									  '</a></div>';
									  
									 $(".toast-header").append(p);
								});
									$()
								    $("#toast-header").after("<p onclick='dingdongMore();'>더보기</p>");
									
							},
							error : (x,s,e) =>{
								console.log(x,s,e);
							}
							
						 });
	            	 
	            	
				 });
				
			
				
				function dingdongMore(){
					location.href ="${pageContext.request.contextPath}/mypage/dingdongList"
				};
				</script>  
			</div>
		</div>
	</div>
	<!-- Infor Model end -->
	</c:if>                            
