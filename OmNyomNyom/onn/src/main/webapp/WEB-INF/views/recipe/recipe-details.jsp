<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:requestEncoding value="utf-8"/> 
<!-- 인코딩설정 안해주면 한글 깨짐  -->

<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="" name="pageTitle"/>
</jsp:include>
    <link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/font-awesome.min.css" />
    
    <link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/mall_slider.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/mall_slider_common.css" />
   	
   	 <script src="${pageContext.request.contextPath }/resources/js/autoslider.js"></script>
    <script>
    	$(function(){
    		//회원의 좋아요 유무에 따른 좋아요 버튼 처리 
    		<c:choose>
    			<c:when test="${isLiked != null}">
    				$('#recipe_like').children().html('favorite');
					$('#recipe_like').one('click',recipeUnlike);
    			</c:when>
    			<c:otherwise>
    				$('#recipe_like').children().html('favorite_border');
    				$('#recipe_like').one('click',recipeLike);
    			</c:otherwise>
    		</c:choose>
    		
    		//회원의 스크랩 여부에 따른 스크랩 버튼 처리
    		<c:choose>
				<c:when test="${scrap != null}">
					$('#recipe_scrap').children().html('스크랩 해제');
					$('#recipe_scrap').on('click',recipeUnscrap);
				</c:when>
				<c:otherwise>
					$('#recipe_scrap').children().html('스크랩');
					$('#recipe_scrap').on('click',recipeScrap);
				</c:otherwise>
			</c:choose>
			
			//레시피 수정, 삭제 버튼 처리 recipe_update,recipe_delete
			<c:if test="${recipe.chefId == memberLoggedIn.memberId }">
				$('#recipe_update').on('click', function(){
					$('#recipe_update_frm').submit();
				});
				$('#recipe_delete').on('click', function(){
					$('#recipe_delete_frm').submit();
				});
			</c:if>
			
			//답글 버튼 일괄 처리
			$('.reply').one('click',showSubReply);

			//문의 보기 버튼 처리
			$('#show_question').on('click',function(){
				$('#question').show();
				$('#comment').hide();
			});
			
			//댓글 보기 버튼 처리
			$('#show_reply').on('click',function(){
				$('#comment').show();
				$('#question').hide();
			});
    	});
    	
        var tag = document.createElement('script'); //이거 뭔지 모름
        tag.src = "https://www.youtube.com/iframe_api"; //api 주소
        var firstScriptTag = document.getElementsByTagName('script')[0]; //이거 뭔지 모름
        firstScriptTag.parentNode.insertBefore(tag, firstScriptTag); //이거 뭔지 모름
        var player; //유튜브 api 전역변수
        var setVideoId = "${recipe.videoLink}"; //유튜브영상 ID
        
        //유튜브 영상 준비
        function onYouTubeIframeAPIReady() {
            player = new YT.Player('testPTag', {
                videoId: setVideoId,
            });
        }

        //유튜브 영상 redirect
        function hreflink(s) {
            player.loadVideoById(setVideoId, s);
        }
        
        //좋아요
        function recipeLike(){
        	$.ajax({
				url:"${pageContext.request.contextPath}/recipe/${memberLoggedIn.memberId}/like/${recipe.recipeNo}",
				success : function(data) {
					if(data == 't'){
						let $recipe_like = $('#recipe_like')
						$recipe_like.children().html('favorite');
						$recipe_like.one('click',recipeUnlike);
					}
				},
				error : function(x, s, e) {
					console.log(x, s, e);
				}
			});
        	
        	
        }
        
        //좋아요 해제
        function recipeUnlike(){
        	$.ajax({
				url:"${pageContext.request.contextPath}/recipe/${memberLoggedIn.memberId}/unlike/${recipe.recipeNo}",
				success : function(data) {
					if(data == 't'){
						let $recipe_like = $('#recipe_like')
						$recipe_like.children().html('favorite_border');
						$recipe_like.one('click',recipeLike);
					}
				},
				error : function(x, s, e) {
					console.log(x, s, e);
				}
			});
        	
        }
        
        //스크랩
        function recipeScrap(){
			let val = prompt("스크랩 내용을 입력하세요.","");
        	
        	console.log(val);
        	if(!$.trim(val)){
        		if(val != null)
        			alert("스크랩 하려면 내용을 입력하세요.");
        		return;
        	}
        	let $recipe_scrap = $('#recipe_scrap');
        	
        	$recipe_scrap.off('click');
        	
        	$.ajax({
				url:"${pageContext.request.contextPath}/recipe/scrap/${recipe.recipeNo}?memo="+val,
				success : function(data) {
					if(data == 't'){
						
						$recipe_scrap.children().html('스크랩 해제');
						$recipe_scrap.on('click',recipeUnscrap);
					}
				},
				error : function(x, s, e) {
					console.log(x, s, e);
				}
			});
        }
        
      //스크랩
        function replyReport(replyNo){
			let val = prompt("신고 내용을 입력하세요.","");
        	
        	console.log(val);
        	if(!$.trim(val)){
        		if(val != null)
        			alert("신고할 내용을 입력하셔야 합니다..");
        		return;
        	}
        	
        	$.ajax({
				url:"${pageContext.request.contextPath}/recipe/replyReport/"+replyNo+"?memo="+val,
				success : function(data) {
					if(data == 't'){
						alert('신고가 접수되었습니다.');
					}else{
						alert('신고에 실패했습니다. 다시 시도해주세요.')
					}
				},
				error : function(x, s, e) {
					console.log(x, s, e);
				}
			});
        }
        
        //스크랩 해제
        function recipeUnscrap(){
        	let bool = confirm('스크랩을 해제하시겠습니까?');
        	
        	if(!bool)
        		return;
        	
        	let $recipe_scrap = $('#recipe_scrap');
        	
        	$recipe_scrap.off('click');
        	
        	$.ajax({
				url:"${pageContext.request.contextPath}/recipe/unscrap/${recipe.recipeNo}",
				success : function(data) {
					if(data == 't'){
						
						$recipe_scrap.children().html('스크랩');
						$recipe_scrap.on('click',recipeScrap);
					}
				},
				error : function(x, s, e) {
					console.log(x, s, e);
				}
			});
        }
        
        //답글 form 보이기
        function showSubReply(e){
        	$('.reply').off('click').one('click',showSubReply).next().hide();
        	$(e.target).next().show();
        	$(e.target).one('click',hideSubReply);
        }
        
        //답글 form 숨기기
        function hideSubReply(e){
        	let $target = $(e.target);
        	$target.next().find('[name=repContent]').val('');
        	$target.next().hide();
        	$target.one('click',showSubReply);
        }
        
        //댓글, 문의, 답글 추가
		function insertReply(e){
			console.log("댓글 등록");
        	$(e).parent().parent().submit();
        }
		
        //댓글, 답글의 내용물 확인
		function replyValidate(e){
			if(!$(e).find('[name=repContent]').val().trim()){
				alert("내용을 작성해 주세요.");
				return false;
			}
		}
		
        //댓글 삭제
		function deleteReply(rNo){
			let bool = confirm('정말 삭제 하시겠습니까?');
			if(bool){
				console.log('삭제번호'+rNo)
				location.href = "${pageContext.request.contextPath}/recipe/deleteReply?replyNo="+rNo+"&recipeNo="+${recipe.recipeNo}; 
			}
		}
		
		//문의, 답글의 내용물 확인
		function questionValidate(e){
			if(!$(e).find('[name=questionContent]').val().trim()){
				alert("내용을 작성해 주세요.");
				return false;
			}
		}
        
        //문의 삭제
		function deleteQuestion(rNo){
			let bool = confirm('정말 삭제 하시겠습니까?');
			if(bool){
				console.log('삭제번호'+rNo)
				location.href = "${pageContext.request.contextPath}/recipe/deleteQuestion?questionNo="+rNo+"&recipeNo="+${recipe.recipeNo}; 
			}
		}
        
        //레시피 삭제 확인
		function recDelValidate(){
        	if(!${recipe.chefId eq memberLoggedIn.memberId}){
        		alert('어떻게 누른거죠?');
        		return false;
        	}
        	return confirm('정말 삭제 하시겠습니까?');
        }
    </script><!-- 레시피 영상  Section -->
    <section class="classes-details-section spad overflow-hidden">
        <div class="container">
            <div class="row">
                <div class="col-lg-7">
                    <div class="recipe-details">
                        <div class="classes-preview">
                            <h2>${recipe.videoTitle}</h2>
                            <div id="youtubevideo">
                                <div class="recipe-video" id="testPTag"></div>
                            </div>
                            <div class="hashtag" id="hashtag">
                                <br>
                                <a href="#">${recipe.category }</a>
                                <br>
                            </div>
                        </div>
                        <div class="row">
                            <!-- 셰프 정보 -->
                            <div class="col-lg-5">
                                <table>
                                	<tr>
                                    <th>
                                        <img src="${pageContext.request.contextPath }/resources/upload/profile/${chefProfile}" class="chef-img" alt=""><!-- 후에 셰프 이미지 경로 정하고... -->
                                    </th>
                                    <td>
                                        <h3 class="chef-name"><a href="${pageContext.request.contextPath }/chef/${recipe.chefNick}/chefPage">${recipe.chefNick}</a></h3>
                                        <div class="cd-meta">
                                            <p><i class="material-icons">people_outline</i>조회수 | ${recipe.viewCount }</p>
                                        </div>
                                    </td>
                                    </tr>
                                </table>
                            </div>
                            <div class="col-lg-7 text-left text-md-right">
                            	<c:if test="${memberLoggedIn != null}">
                            		<a id="recipe_like" style="cursor:pointer;"><i class="material-icons"></i></a><!-- favorite -->
                            		<a id="recipe_scrap" style="cursor:pointer;"><div class="cd-price"></div></a>
                                </c:if>
                            </div>
                        </div>
                        <div class="row">
                            <h3 style="margin-top:30px; border-bottom:3px solid black; margin-bottom:30px;">재료</h3>
                            <table class="table table-bordered">
                                <thead>
                                    <tr>
                                        <th scope="col"></th>
                                        <th scope="col" colspan="2">재료명</th>
                                        <th scope="col">용량</th>

                                    </tr>
                                </thead>
                                <tbody>
                                <c:forEach items="${recipe.ingredientList}" var="ingr" varStatus="vs">
                                    <tr>
                                        <th scope="row">${vs.count }</th>
                                        <td colspan="2">${ingr.ingredientName }</td>
                                        <td>${ingr.minWeight }</td>
                                    </tr>
                                </c:forEach>
                                </tbody>
                            </table>

                        </div>
                        <!-- 셰프 설명글 -->

                        <pre style="font-size: 15px; color: #666666; line-height: 1.8; font-family: 'Noto Sans KR', sans-serif;">${recipe.recipeContent }</pre>
                        
                        <%-- 레시피 수정, 삭제 버튼 --%>
                        <c:if test="${recipe.chefId == memberLoggedIn.memberId }">
	                        <div class="d-flex">
	                        	<a id="recipe_update" style="cursor:pointer;"><div class="cd-price mr-2">레시피 수정</div></a><!-- favorite -->
	                            <a id="recipe_delete" style="cursor:pointer;"><div class="cd-price">레시피 삭제</div></a>
	                        </div>
	                        <form id="recipe_update_frm" action="${pageContext.request.contextPath }/recipe/recipeUpdateFrm" method="post" hidden>
	                       		<input type="text" name="chefId" value="${recipe.chefId }">
	                        	<input type="text" name="recipeNo" value="${recipe.recipeNo }">
	                        </form>
	                        <form id="recipe_delete_frm" action="${pageContext.request.contextPath }/recipe/recipeDelete" method="post" onsubmit="return recDelValidate()" hidden>
	                        	<input type="text" name="chefId" value="${recipe.chefId }">
	                        	<input type="text" name="recipeNo" value="${recipe.recipeNo }">
	                        </form>
                        </c:if>
                    </div>
                </div>
                <div class="col-lg-5 col-md-6 col-sm-9 sidebar">
                    <!-- 타임 스탬프 start -->
                    <div class="sb-widget">
                        <h2 class="sb-title">요리방법 </h2>
                        <div class="classes-info">
                        <c:forEach items="${fn:split(recipe.timeline,'⇔')}" var="timeline" varStatus="vs">
                            <p class="yt_time_stamp" onclick="hreflink(${fn:split(timeline,'∮')[0]});"><span>${vs.count }.</span>&nbsp;${fn:split(timeline,'∮')[1] }</p>
                        </c:forEach>
                        </div>
                    </div>
                    <!-- 타임 스탬프 end -->
                    
					<div class="sb-widget">
                        <h2 class="sb-title">연관영상</h2>
                        <div class="another-video-widget">
                            <table>
                            	<c:forEach items="${relationRecipes }" var="recipe" varStatus="vs">
                                <tr>
                                    <!-- 유튜브 썸네일 추출 방식-->
                                    <th>
                                    	<a href="${pageContext.request.contextPath }/recipe/recipe-details?recipeNo=${recipe.recipeNo}">
                                    		<img src="https://img.youtube.com/vi/${recipe.videoLink }/mqdefault.jpg" alt="" width="200" height="100">
                                    	</a>
                                    </th>
                                    <td>
                                    	<ul>
                                        <li>${recipe.videoTitle }</li>
                                        <li>${recipe.chefNick }</li>
                                        <li>조회수 ${recipe.viewCount }</li>
                                        </ul>
                                    </td>
                                </tr>
                                </c:forEach>
                            </table>
                        </div>
                    </div>
				</div>
            </div>
            <!-- 재료 판매 -->
            <div class="row">
                <div class="goods-add-product">
                    <div class="goods-add-product-wrapper __slide-wrapper" data-slide-item="5">
                        <h3 class="goods-add-product-title">뇸뇸몰</h3>
                        <button type="button" class="goods-add-product-move goods-add-product-move-left __slide-go-left">왼쪽으로 슬라이드 이동</button>
                        <button type="button" class="goods-add-product-move goods-add-product-move-right __slide-go-right">오른쪽으로 슬라이드 이동</button>
                        <div class="goods-add-product-list-wrapper" style="height:275px">
                            <ul class="goods-add-product-list __slide-mover" style="left: 0px;">
								<c:forEach items="${ingrMallList}" var="ingrMall" varStatus="vs">
	                                <li class="goods-add-product-item __slide-item">
	                                    <div class="goods-add-product-item-figure">
	                                        <a href="${pageContext.request.contextPath }/mall/productDetail?ingMallNo=${ingrMall.ingMallNo}" target="_blank">
	                                        	<img src="${pageContext.request.contextPath }/resources/images/ingredient/${ingrMall.prevImg}" class="goods-add-product-item-image" 
	                                        		 onerror="this.src='${pageContext.request.contextPath }/resources/images/ingredient/Ingredient_default.png'">
	                                        </a>
	                                    </div>
	                                    <div class="goods-add-product-item-content">
	                                        <div class="goods-add-product-item-content-wrapper">
	                                            <p class="goods-add-product-item-name">${ingrMall.ingMallNo }.${ingrMall.ingMallName} </p>
	                                            <p class="goods-add-product-item-price">${ingrMall.price}원</p>
	                                        </div>
	
	                                    </div>
	                                </li>
                                </c:forEach>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
            <!-- 댓글 -->
            <div  id="comment">
            <div class="d-flex mt-4">
            	<h3 class="comment-title mr-3">댓글</h3>
            	<a id="show_question" class="recipe-details" style="cursor:pointer;"><div class="cd-price">문의 보기</div></a>
            </div>
            <ul class="comment-list">
                
                <c:forEach items="${replyList }" var="reply" varStatus="vs">
                <c:if test="${reply.highRepNo == 0}">
                <li>
                    <div class="comment-text">
                    	<div class="d-flex">
	                        <h3>${reply.memberNick}</h3>
	                        <div class="comment-date mr-auto"><i class="material-icons">alarm_on</i><fmt:formatDate value="${reply.regDate }" pattern="yyyy-MM-dd a hh:mm:ss"/></div>
	                        <c:if test="${memberLoggedIn != null}">
	                        	<c:if test="${memberLoggedIn.memberId eq reply.memberId || memberLoggedIn.memberRoll eq 'A'}">
	                        		<a onclick="deleteReply(${reply.replyNo});" class="recipe-details" style="cursor:pointer; margin-bottom: 20px;"><div class="cd-price">삭제</div></a>
	                        	</c:if>
	                        	<a onclick="replyReport(${reply.replyNo})" class="recipe-details" style="cursor:pointer; padding: 0; margin-bottom: 20px;"><div class="cd-price">신고</div></a>
	                        </c:if>
                        </div>
                        <p>${reply.repContent }</p>
                        <c:if test="${memberLoggedIn != null}">
                        <a class="reply" style="cursor:pointer;"><i class="material-icons">reply</i>답글</a>
                        <form class="singup-form" action="${pageContext.request.contextPath }/recipe/insertReply" method="post" onsubmit="return replyValidate(this);" style="display: none;">
		                	<div class="mb-3">
		                        <textarea name="repContent" placeholder="댓글 작성"></textarea>
		                        <input name="highRepNo" type="number" value="${reply.replyNo}" hidden/>
		                        <input name="recipeNo" type="number" value="${recipe.recipeNo }" hidden/>
		                        <a onclick="insertReply(this);" class="site-btn sb-gradient">댓글 달기</a>
		                    </div>
		                </form>
                        </c:if>
                    </div>
                    <ul class="comment-sub-list">
                    	<c:forEach items="${replyList }" var="subReply" varStatus="subVs">
                    	<c:if test="${reply.replyNo == subReply.highRepNo }">
                        <li style="margin-bottom: 0">
                            <div class="comment-text">
                            	<div class="d-flex">
	                                <h3>${subReply.memberNick }</h3>
	                                <div class="comment-date mr-auto"><i class="material-icons">alarm_on</i><fmt:formatDate value="${subReply.regDate }" pattern="yyyy-MM-dd a hh:mm:ss"/></div>
	                                <c:if test="${memberLoggedIn != null}">
	                                	<c:if test="${memberLoggedIn.memberId eq subReply.memberId || memberLoggedIn.memberRoll eq 'A'}">
			                        		<a onclick="deleteReply(${subReply.replyNo});" class="recipe-details" style="cursor:pointer; margin-bottom: 20px;"><div class="cd-price">삭제</div></a>
			                        	</c:if>
			                        	<a onclick="replyReport(${subReply.replyNo})" class="recipe-details" style="cursor:pointer; padding: 0; margin-bottom: 20px;"><div class="cd-price">신고</div></a>
			                        </c:if>
		                        </div>
                                <p>${subReply.repContent }</p>
                                <c:if test="${memberLoggedIn != null}">
                                <a class="reply" style="cursor:pointer;"><i class="material-icons">reply</i>답글</a>
                                <form class="singup-form" action="${pageContext.request.contextPath }/recipe/insertReply" method="post" onsubmit="return replyValidate(this);" style="display: none;">
				                	<div class="mb-3">
				                        <textarea name="repContent" placeholder="댓글 작성"></textarea>
				                        <input name="highRepNo" type="number" value="${reply.replyNo}" hidden/>
				                        <input name="recipeNo" type="number" value="${recipe.recipeNo }" hidden/>
				                        <a onclick="insertReply(this);" class="site-btn sb-gradient">댓글 달기</a>
				                    </div>
				                </form>
                                </c:if>
                            </div>
                        </li>
                        </c:if>
                        </c:forEach>
                    </ul>
                </li>
                </c:if>
                </c:forEach>
                <c:if test="${memberLoggedIn != null}">
                <li>
                <form class="singup-form" action="${pageContext.request.contextPath }/recipe/insertReply" method="post" onsubmit="return replyValidate(this);">
                	<div class="mb-3">
                        <textarea name="repContent" placeholder="댓글 작성"></textarea>
                        <input name="recipeNo" type="number" value="${recipe.recipeNo }" hidden/>
                        <a onclick="insertReply(this);" class="site-btn sb-gradient">댓글 달기</a>
                    </div>
                </form>
                </li>
                </c:if>
            </ul>
            </div>
            
            <!-- 문의하기 -->
            <div id="question" style="display: none;">
            <div class="d-flex mt-4">
            	<h3 class="comment-title mr-3">문의하기</h3>
            	<a id="show_reply" class="recipe-details" style="cursor:pointer;"><div class="cd-price">댓글 보기</div></a>
            </div>
            <ul class="comment-list">
                
                <c:forEach items="${questionList }" var="question" varStatus="vs">
                <c:if test="${question.highQuestionNo == 0}">
                <li>
                    <div class="comment-text">
                    	<div class="d-flex">
	                        <h3>${question.memberNick}</h3>
	                        <div class="comment-date mr-auto"><i class="material-icons">alarm_on</i><fmt:formatDate value="${question.regDate }" pattern="yyyy-MM-dd a hh:mm:ss"/></div>
	                        <c:if test="${memberLoggedIn != null}">
	                        	<c:if test="${memberLoggedIn.memberId eq question.memberId || memberLoggedIn.memberRoll eq 'A'}">
	                        		<a onclick="deleteQuestion(${question.questionNo});" class="recipe-details" style="cursor:pointer; margin-bottom: 20px;"><div class="cd-price">삭제</div></a>
	                        	</c:if>
	                        </c:if>
                        </div>
                        <p>${question.questionContent }</p>
                        <c:if test="${memberLoggedIn != null && (recipe.chefId eq memberLoggedIn.memberId || question.memberId eq memberLoggedIn.memberId)}">
                        <a class="reply" style="cursor:pointer;"><i class="material-icons">reply</i>답글</a>
                        <form class="singup-form" action="${pageContext.request.contextPath }/recipe/insertQuestion" method="post" onsubmit="return questionValidate(this);" style="display: none;">
		                	<div class="mb-3">
		                        <textarea name="questionContent" placeholder="댓글 작성"></textarea>
		                        <input name="highQuestionNo" type="number" value="${question.questionNo}" hidden/>
		                        <input name="recipeNo" type="number" value="${recipe.recipeNo }" hidden/>
		                        <input name="memberId" type="text" value="${question.memberId}" hidden/>
		                        <input name="chefId" type="text" value="${recipe.chefId}" hidden/>
		                        <a onclick="insertReply(this);" class="site-btn sb-gradient">댓글 달기</a>
		                    </div>
		                </form>
                        </c:if>
                    </div>
                    <ul class="comment-sub-list">
                    	<c:forEach items="${questionList }" var="answer" varStatus="subVs">
                    	<c:if test="${question.questionNo == answer.highQuestionNo }">
                        <li style="margin-bottom: 0">
                            <div class="comment-text">
                            	<div class="d-flex">
	                                <h3>${answer.memberNick }</h3>
	                                <div class="comment-date mr-auto"><i class="material-icons">alarm_on</i><fmt:formatDate value="${answer.regDate }" pattern="yyyy-MM-dd a hh:mm:ss"/></div>
	                                <c:if test="${memberLoggedIn != null}">
	                                	<c:if test="${memberLoggedIn.memberId eq answer.memberId || memberLoggedIn.memberRoll eq 'A'}">
			                        		<a onclick="deleteQuestion(${answer.questionNo});" class="recipe-details" style="cursor:pointer; margin-bottom: 20px;"><div class="cd-price">삭제</div></a>
			                        	</c:if>
			                        </c:if>
		                        </div>
                                <p>${answer.questionContent }</p>
                                <c:if test="${memberLoggedIn != null && (recipe.chefId eq memberLoggedIn.memberId || question.memberId eq memberLoggedIn.memberId)}">
                                <a class="reply" style="cursor:pointer;"><i class="material-icons">reply</i>답글</a>
                                <form class="singup-form" action="${pageContext.request.contextPath }/recipe/insertQuestion" method="post" onsubmit="return questionValidate(this);" style="display: none;">
				                	<div class="mb-3">
				                        <textarea name="questionContent" placeholder="댓글 작성"></textarea>
				                        <input name="highQuestionNo" type="number" value="${question.questionNo}" hidden/>
				                        <input name="recipeNo" type="number" value="${recipe.recipeNo }" hidden/>
				                        <input name="memberId" type="text" value="${question.memberId}" hidden/>
				                        <input name="chefId" type="text" value="${recipe.chefId}" hidden/>
				                        <a onclick="insertReply(this);" class="site-btn sb-gradient">댓글 달기</a>
				                    </div>
				                </form>
                                </c:if>
                            </div>
                        </li>
                        </c:if>
                        </c:forEach>
                    </ul>
                </li>
                </c:if>
                </c:forEach>
                <c:if test="${memberLoggedIn != null && recipe.chefId != memberLoggedIn.memberId}">
                <li>
                <form class="singup-form" action="${pageContext.request.contextPath }/recipe/insertQuestion" method="post" onsubmit="return questionValidate(this);">
                	<div class="mb-3">
                        <textarea name="questionContent" placeholder="댓글 작성"></textarea>
                        <input name="recipeNo" type="number" value="${recipe.recipeNo }" hidden/>
                        <input name="chefId" type="text" value="${recipe.chefId}" hidden/>
                        <a onclick="insertReply(this);" class="site-btn sb-gradient">댓글 달기</a>
                    </div>
                </form>
                </li>
                </c:if>
            </ul>

            </div>
        </div>
    </section>
    <!-- Classes Details Section end -->

		

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>