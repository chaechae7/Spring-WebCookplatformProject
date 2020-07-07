<%@page import="com.google.api.services.youtube.model.MemberListResponse"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:requestEncoding value="utf-8"/> <!-- 인코딩설정 안해주면 한글 깨짐  -->
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="" name="pageTitle"/>
</jsp:include>
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/recipeUpload.css"/>
<script src="${pageContext.request.contextPath }/resources/js/upload.js"></script>
<!-- 해시태그부분 소스 -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/prism/1.17.1/themes/prism.min.css">
<script src='https://cdnjs.cloudflare.com/ajax/libs/prism/1.17.1/prism.min.js'></script>
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/tagify.css">
<script src="${pageContext.request.contextPath }/resources/js/jq.multiinput.js"></script>
<script src="${pageContext.request.contextPath }/resources/js/tagify.js"></script>
<script src="${pageContext.request.contextPath }/resources/js/jQuery.tagify.min.js"></script>	
	
<!-- 타임스탬프 -->
<link href="${pageContext.request.contextPath }/resources/css/jq.multiinput.min.css" rel="stylesheet">
	
 <!-- 에디터 부분 -->
 <!-- <script src="https://cdn.ckeditor.com/4.14.0/standard/ckeditor.js"></script> -->
	
<style contenteditable>
.tags-look .tagify__dropdown__item{
  display: inline-block;
  border-radius: 3px;
  padding: .3em .5em;
  border: 1px solid #CCC;
  background: #F3F3F3;
  margin: .2em;
  font-size: .85em;
  color: black;
  transition: 0s;
}
	
.tags-look .tagify__dropdown__item--active{
  color: black;
}
	
.tags-look .tagify__dropdown__item:hover{
  background: lightyellow;
  border-color: gold;
}
</style>	
<script>
var player; //유튜브 api 전역변수
var setVideoId = "${recipe.videoLink}"; //유튜브영상 ID

//유튜브 영상 준비
function onYouTubeIframeAPIReady() {
    player = new YT.Player('testPTag', {
        videoId: setVideoId,
    });
}


var categoryArr = new Array();
<c:forEach items="${categoryList}" var="category" varStatus="vs">
categoryArr.push("${category.menuPrCategory}/${category.menuCdCategory}");
</c:forEach>
$(function(){
	var input = document.querySelector('input[id="input-custom-dropdown"]'),
	// init Tagify script on the above inputs
	tagify = new Tagify(input, {
		whitelist: categoryArr,
		maxTags: 1,
		dropdown: {
			maxItems: 20,           // <- mixumum allowed rendered suggestions
			classname: "tags-look", // <- custom classname for this dropdown, so it could be targeted
			enabled: 0,             // <- show suggestions on focus
			closeOnSelect: false    // <- do not hide the suggestions dropdown once an item has been selected
		}
	});
	//enter누를시 자동 submit되는 것을 방지
	$('input[type="text"]').keydown(function() {
		  if (event.keyCode === 13) {
		    event.preventDefault();
		  };
		});
	
	let $autoComplete = $("#autoComplete");

	$("#input-ingredient").keyup(function(e){
		let $sel = $(".sel");
		let $li = $("#autoComplete li");
		
		if(e.key == 'ArrowDown'){
			if($sel.length == 0){
				$li.first().addClass("sel");
			}else {
				$sel.removeClass("sel").next().addClass("sel");
			}
			
		}else if(e.key == 'ArrowUp'){
			if($sel.length == 0){
				$li.last().addClass("sel");
			}else {
				$sel.removeClass("sel").prev().addClass("sel");
			}
		}else if(e.key == 'Enter'){
			//요소 선택
			$(this).val($sel.text());
			$("#input-ing-number").val($sel.children("input").val());
			//검색어 목록 삭제
			$autoComplete.hide().children().remove();
			
		}else{
			let srchName = $(this).val().trim();
			console.log(srchName);
			<%--
			if(srchName.length == 0)
				return;
			--%>
			
			$.ajax({
				url:"${pageContext.request.contextPath}/recipe/"+ srchName + "/ajax",
				dataType : "json",
				success : function(data) {
								console.log(data);//'김' 입력시, "조기김, 돌김, 김가루..."
								if (data.length == 0) {
									$autoComplete.hide();
								} else {
	
									let html = "";
									$.each(data, function(idx, ingr) {
											html += "<li><span>" + 
													ingr.ingredientName.replace(srchName,"<span class='srchval'>" + srchName+ '</span>')+ 
													"</span><input type='number' value="+
													ingr.ingredientNo+
													" hidden/></li>";
									});
									$autoComplete.html(html).show();
	
									//마우스 입력 추가
									$autoComplete.children("li")
												 .click(function() {
														$("#input-ingredient").val($(this).text());
														$("#input-ing-number").val($(this).children("input").val());
														$autoComplete.hide().children().remove();
											   }).hover(function() {
														$(this).siblings().removeClass("sel");
														$(this).addClass("sel");
													  },function() {
														$(this).removeClass("sel");
											   });
	
								}
	
				},
				error : function(x, s, e) {
					console.log(x, s, e);
				}
			});
		}
	});
});

function frmValidate(){

	if(!$("input[name=chefId]").val().trim()){
		alert('로그인 먼저 해주세요.');
		location.href="/onn/";
		return false;
	}
	
	if(!$("input[name=videoTitle]").val().trim()){
		alert('레시피 이름을 입력하세요.');
		$("input[name=videoTitle]").val('').focus();
		return false;
	}
	
	if(!$("input[name=category]").val().trim()){
		alert("음식 분류를 입력하세요.");
		$("input[name=category]").val('').focus();
		return false;
	}
	
	if(!$("input[name=menuName]").val().trim()){
		alert("음식 이름을 넣어주세요.");
		$("input[name=menuName]").val('').focus();
		return false;
	}
	
	
	if($("input[name=ingr_name]").length <=0){
		alert("레시피 재료가 없습니다. 레시피 재료를 추가해 주세요.");
		$("#input-ingredient").val('').focus();
		$("#input-ing-number").val('');
		$("#input-ing-mass").val('');
		return false;
	}
	
	let $tn_firstname = $("input[name=tn_firstname]");
	let $tn_lastname = $("input[name=tn_lastname]");
	
	let tn_firstBool = true;
	let tn_lastBool = true;
	
	$tn_firstname.each(function(i,element){
		let $elem = $(element);
		if(!$elem.val().trim()){
			alert("요리방법 시간이 안 적힌 곳이 있습니다.");
			$elem.val('').focus();
			tn_firstBool=false;
			return false;
		}
	});
	
	if(!tn_firstBool)
		return false;
	
	$tn_lastname.each(function(i,element){
		let $elem = $(element);
		if(!$elem.val().trim()){
			alert("요리방법이 안 적힌 곳이 있습니다.");
			$elem.val('').focus();
			tn_lastBool=false;
			return false;
		}
	});
	
	if(!tn_lastBool)
		return false;
	
	if(!$("textarea[name=recipeContent]").val().trim()){
		alert("내용이 비어있습니다.");
		$("textarea[name=recipeContent]").val('').focus()
		return false;
	}
	
	if($("input[name=uploadFile]").val().trim())
		alert("영상 업로드에 시간이 걸릴 수 있습니다. 잠시만 기다려주세요.");
	return true;
};
</script>

	<link href="https://fonts.googleapis.com/css?family=Nanum+Gothic:400,700,800&display=swap&subset=korean" rel="stylesheet">
	
	<section class="page-top-section page-sp">
		<div class="container">
			<div class="row">
				<div class="col-lg-7 m-auto text-white">
					<h2>레시피 수정</h2>
				</div>
			</div>
		</div>
	</section>
	 <!-- Page top Section end -->

	                                                                            
	<!-- 레시피 영상  Section --><!--  -->
	<section class="classes-details-section spad overflow-hidden">
		<div class="container">
			<form name="memberFrm" action="${pageContext.request.contextPath }/recipe/recipeUpdateEnd" method="post" onsubmit="return frmValidate();" enctype="multipart/form-data">
			<input name="recipeNo" value="${recipe.recipeNo }" hidden/>
			<input name="chefId" value="${memberLoggedIn.memberId}" hidden/>
			<input name="chefNick" value="${memberLoggedIn.memberNick}" hidden/>
			<div class="row">
				<div class="col-lg-7">
					<div class="recipe-details">
						<div class="classes-preview">
							<div class="input-group mb-3">
                                <div class="input-group-prepend">
                                  <span class="input-group-text" id="basic-addon1">제목</span>
                                </div>
                                <input name="videoTitle" type="text" class="form-control" placeholder="레시피제목을 입력하세요." aria-label="Username" aria-describedby="basic-addon1" 
                                	   value="${recipe.videoTitle }">
							  </div>
							<hr>
							<div id="youtubevideo">
                                <div class="recipe-video" id="testPTag"></div>
                            </div>
							<hr>
								<div class="input-group mb-3">
                                    <div class="input-group-prepend">
                                      <span class="input-group-text" id="basic-addon1">음식 분류</span>
									</div>
									<!-- <input class="form-control" name='basic' value="" placeholder="해시태그를 입력하세요." aria-label="Username" aria-describedby="basic-addon1" autofocus> -->
									<input class="form-control" name="category" id="input-custom-dropdown" class="some_class_name" placeholder="해시태크를 입력하세요." value="${recipe.category }" aria-label="Username" aria-describedby="basic-addon1">
								</div>
									<div class="input-group mb-3">
									<div class="input-group-prepend">
									  <span class="input-group-text" id="basic-addon1">음식 이름</span>
									</div>
									<!-- <input class="form-control" name='basic' value="" placeholder="해시태그를 입력하세요." aria-label="Username" aria-describedby="basic-addon1" autofocus> -->
									<input class="form-control" name="menuName" class="some_class_name" placeholder="음식의 이름을 입력하세요." value="${recipe.menuName}" aria-label="Username" aria-describedby="basic-addon1" >
								</div>
							<hr>
								<!-- 재료입력 -->
								<h6 class="insert-title">재료를 입력하세요.</h6>
						<div class="container">
							<div class="row">
								<div class="col-lg-12">
                                <div class="row m-auto">
                                <span class="input col-4 p-0">
                                    <input class="form-control" type="text" id="input-ingredient" autocomplete="off" placeholder="재료명을 입력하세요."/>
                                	<ul id="autoComplete"></ul>
								</span>
								<input type="number" id="input-ing-number" value=0 hidden/>
								<span class="input col-4 p-0">
                                    <input class="form-control" type="text" id="input-ing-mass" autocomplete="off" placeholder="계량을 입력하세요."/>
                                </span>
                                <div class="col py-1 pr-0 input">
                                <!-- <button class="site-btn sb-gradient px-3" style="min-width: 100%;" type="button" onclick="addClassTime();">추가</button> -->
									<i class="fa fa-lg fa-plus-circle" style="min-width: 100%;" onclick="addIngredient();" type="button"></i>
								</div>
                                </div>
	                                <div id="input-date-list">
	                                	<c:forEach items="${recipe.ingredientList}" var="ingr" varStatus="vs">
	                                	<div class='row m-auto'>
	                            			<span class="input col-4 p-0">
	                            				<input name="ingr_name" class="form-control" type="text" autocomplete="off" value="${ingr.ingredientName }" readonly/>
											</span>
											<span class="input col-4 p-0">
	                            				<input name="ingr_mass" class="form-control" type="text" autocomplete="off" value="${ingr.minWeight }" readonly/>
											</span>
											<input name="ingr_number" type="number" hidden value="${ingr.ingredientNo }">
	                            			<div class="col py-1 pr-0 input">
												<i class="fa fa-lg fa-minus-circle" style="min-width: 100%;" onclick="removeClassTime(this);" type="button"></i>
	                        				</div>	
	                         			</div>
	                         			</c:forEach>
                                	</div>
								</div>
							</div>
						</div>	
						<hr>
						</div>
					</div>
				<!-- 댓글 -->
				<div class="updatetext">
					<h6>해당 영상의 부가 설명을 입력하세요.</h6>
				</div>
				<div class="row recipe-editor">
					<div class="col">

						<textarea name="recipeContent" style="width: 100%;">${recipe.recipeContent }</textarea>

					</div>
				</div>
				<div class="mt-2">
					<input type="submit" class="" value="레시피 수정">
				</div>
			</div>
			
				<div class="col-lg-5 col-md-6 col-sm-9 sidebar">
				<!-- 타임 스탬프 start -->
					<div class="sb-widget">
						<h6 class="sb-title">요리방법을 작성해주세요. </h6>
						<div class="classes-info">
							<div class="container">
								<div class="row">
									<div class="col-xs-4">
									<div class="form-control" id="participants" name="participants">[
										<c:forEach items="${fn:split(recipe.timeline,'⇔')}" var="timeline" varStatus="vs">
                            				{"tn_firstname":${fn:split(timeline,'∮')[0]},"tn_lastname":"${fn:split(timeline,'∮')[1]}"}
                            				<c:if test="${!vs.last }">,</c:if>
                        				</c:forEach>
									]</div>
									</div>
								</div>
							</div>
						</div>
					</div>
					<!-- 타임 스탬프 end -->

				</div>
			</div>
			</form>
		</div>
	</section>
	<!-- Classes Details Section end -->

		


<!-- <script crossorigin="anonymous" integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8=" src="https://code.jquery.com/jquery-3.3.1.min.js"></script> -->


	
	

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>