<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:requestEncoding value="utf-8"/> <!-- 인코딩설정 안해주면 한글 깨짐  -->
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="메뉴명으로 레시피 검색하기~!" name="pageTitle"/>
</jsp:include>
    <!-- Main Stylesheets -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/recipe-search(Menu).css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/recipe-search(Ingredients).css">
    <%  
    	request.setCharacterEncoding("UTF-8");
	    
    %>
    
    <script>
    	var contextPath = "${pageContext.request.contextPath}";    
    	/* ------------------------------------------------------- */
 	$().ready(function(){
		console.log('jquery로드 완료');
		subCtgload();
		selectSubCt();
		
	});
	
    	
    	//검색버튼 클릭 이벤트
	function keywordValidate() {
		let searchKey = $("#searchKey");
		
		console.log(searchKey.val());
		
		if(searchKey.val().trim().length == 0){
			alert("최소 한 글자 이상 입력해야 검색이 가능합니다.");
			searchKey.focus();
			return false;
		} else{
			
			recipeSearchByIng();
		}
		
		true;
	}    	
    	
	function subCtgload(){
		/* 메인 카테고리 선택에 따른 변경 */
		$(".main-ctg-menu p").on('click', function(){
			/* 이미 선택된 분류라면 아래의 코드 수행하지 않음 */
			
		 	if($(this).hasClass("active")) {
		 		$(this).removeClass("active");
				return; 
		 	}
			
			console.log($(this));
			let mainCtg = {'mainCtg' : $(this).html()};
			
			console.log(mainCtg);
			$(".main-ctg-menu p").removeClass("active");
		 	$(this).addClass("active");
			
			$.ajax({
				url: contextPath+"/recipe/getSubMenuCtg",
				dataType: "json",
				method : "GET",
				data: mainCtg,
				success : data =>{
					console.log(data);
					/* 서브 카테고리 교체작업 */
					let subCtgList = ' '; 
					$.each(data,function(index, item){
						subCtgList += '<li> <p>'+item+'</p> </li>';
						selectSubCt();
						recipeSearchByIng();
					});
					$(".sub-ctg-menu").html(subCtgList);
					
				},
				error : (x,s,e) =>{
					console.log(x,s,e);
				}
			});
			
			
		});
	}; //서브 카테고리 교체 끝
	
	
	//서브 카테고리 선택 이벤트
	function selectSubCt(){
		$(document).on('click', '.sub-ctg-menu p', function(){
			if($(this).hasClass("active")){
				return; 
			} else {
			$(".sub-ctg-menu p").removeClass("active");
		 	$(this).addClass("active");
		 	recipeSearchByIng()
			}
		});
	};
    
	
	//입력한 키워드와 선택된 카테고리로 검색 버튼 클릭에 따른 이벤트 작동.
	function recipeSearchByIng(){
		console.log("버튼 클릭됨");
	
		let searchKey = $("#searchKey").val();
		
		let cPage; 
		let forwardingData;
		//카테고리 가져오기.
		let searchMCtg = $('.main-ctg-menu>li>p.active').text();
		let searchSCtg = $('.sub-ctg-menu>li>p.active').text();
		console.log($('.main-ctg-menu').find('.active'));
		console.log($('.main-ctg-menu>li>p.active'));
		console.log("카테고리값", searchMCtg, searchSCtg);

		//영상용 pagination
		if($(this).hasClass('rcpPaging')){
			if( $("a.rcpCurPage").text() != undefined && $("a.rcpCurPage").text() != 0 && $("a.rcpCurPage").text() != null)  {
				cPage = Number($("a.rcpCurPage").text());
			} else{
				cPage = Number(1);
			}
			cPage = cPage + Number($(this).children('a').attr("tabindex"));
			forwardingData = {'searchKey': searchKey, 'searchMCtg':searchMCtg, 'searchSCtg': searchSCtg, 'cPage' : cPage};
		} else if(!$(this).hasClass('rcpPaging')){
			forwardingData = {'searchKey': searchKey, 'searchMCtg':searchMCtg, 'searchSCtg': searchSCtg, 'cPage' : 1};
			
		}	
	
		console.log("====================forwardingData====================",forwardingData);
		
		$.ajax({
			url: "${pageContext.request.contextPath}/recipe/searchByMenu",
			dataType: "json",
			method : "GET",
			data: forwardingData,
			success : data =>{
			
				console.log(data);
				let RList = data.searchedList;
				let rcpCnt = data.rcpCnt;
				cPage = data.cPage;
				
				$(".searchList").prev('.searchedKey>h5').remove();
				$(".searchList").prev('.searchedKey>h5').append('searchKey');
				
				/* 검색된 영상 리스트  교체작업*/
				$("div.searchList").empty();
				$.each(RList, function(index, item){
					let eachRecipe = '<div class="col-xs-6 col-sm-3 placeholder chef_list">' +
									'<a href="'+contextPath+'/recipe/recipe-details?recipeNo='+item.recipeNo+'"><img src="https://img.youtube.com/vi/'+item.videoLink+'/mqdefault.jpg" alt="" class="chef-Thumbnail">'+
									'<div class="forTitle"><p class="chef-Thumbnail-title">'+item.videoTitle+'</p></div><div class="forTitle"><p class="chef-Thumbnail-title">'+item.category+'</p></div></a>' +
									'<div class="row"> <div class="col-8">'+
									'<img src="'+contextPath+'/resources/upload/profile/'+item.chefProfile+'" class="" alt="" style="width: 40px; height: 40px; border-radius: 50%;"> <span class="chef-min-name">'+item.chefNick+'</span></div>' +						
									'<div class="col-4 chef-view-count"> <span><small> 조회수 :'+item.viewCount+'</span> </small></div>'+
									'</div> </div>';
					$(".searchList").append(eachRecipe);
				}); //영상교체 완료
				//페이징 처리
				console.log("레시피 페이징 시작", rcpCnt);
				console.log("레시피 페이징 시작 cpage", cPage);
				let totalPage = '<a class="rcpPaging"><small>..totalPage : '+rcpCnt+'</small></a>';
				let pagingPrevbtn = '<a class="rcpPaging" tabindex="-1" onclick="recipeSearchByIng();" > <i class="material-icons">keyboard_arrow_left</i></a>';
				let pagingNextbtn = '<a class="rcpPaging" tabindex="1" onclick="recipeSearchByIng();" > <i class="material-icons">keyboard_arrow_right</i></a>';
				let curPagebtn = '<a class="rcpPaging rcpCurPage" onclick="recipeSearchByIng();" >'+cPage+'</a>'
				$("div.site-pagination").empty();
				console.log("totalPage",totalPage);
				console.log("pagingPrevbtn ", pagingPrevbtn );
				console.log("pagingNextbtn", pagingNextbtn);
				console.log("curPagebtn", curPagebtn);
				//페이지바 추가
				if(rcpCnt == 1 && cPage == 1){
				//1페이지가 전제일 경우
					console.log(12341234);
					$("div.site-pagination").append(totalPage);
				}else if(rcpCnt >= 2 && cPage != 1 && ingCnt != cPage){
					console.log(12341234);
				//이전 페이지와 다음 페이지가 모두 존재할 경우
					$("div.site-pagination").append(pagingPrevbtn);
					$("div.site-pagination").append(curPagebtn);
					$("div.site-pagination").append(pagingNextbtn);
					$("div.site-pagination").append(totalPage);
				}else if(rcpCnt >= 2 && cPage == 1 ){
				//다음페이지가 있고 이전페이지가 없는경우
					console.log(12341234);
					$("div.site-pagination").append(curPagebtn);
					$("div.site-pagination").append(pagingNextbtn);
					$("div.site-pagination").append(totalPage);
				}else if(rcpCnt >= 2 && cPage == ingCnt){
				//이전 페이지만 존재하는 경우
					console.log(12341234);
					console.log("4");
					$("div.site-pagination").append(pagingPrevbtn);
					$("div.site-pagination").append(curPagebtn);
					$("div.site-pagination").append(totalPage);	
				};	
				console.log("레시피 페이징 끝========================");
			},
			error : (x,s,e) =>{
				console.log(x,s,e);
			}
		});
		
		
	}; 
	
	
	
	
	
    </script>
    
	<style>
    .mid-select{
        margin-left: 27px;
        padding-bottom: 50px;
        padding-top: 15px;
    }
    .select li{
        margin-right: 70px;
    
    }
    </style>
    
            <!-- --------------------------------------------------------------------------------------------------------- -->
        <link href="https://fonts.googleapis.com/css?family=Nanum+Gothic:400,700,800&display=swap&subset=korean" rel="stylesheet">
    
        <section class="page-top-section page-sp set-bg" data-setbg="img/page-top-bg.jpg">
            <div class="container">
                <div class="row">
                    <div class="col-lg-7 m-auto text-white">
                        <h2>메뉴 이름으로 레시피 검색</h2>
                        <p>메뉴 이름으로 검색하고 카테고리별로 필터링하기</p>
                    </div>
                </div>
            </div>
        </section>
			
<!-- Page top Section end -->

	<!-- 검색바 시작 -->
    <div class="container">
        <div class="event-filter-warp">
            <div class="row">
                <div class="col-xl-2">
                    <p>메뉴로 검색</p>
                </div>
                <div class="col-xl-10">
                    <form class="event-filter-form"  >
                        <div class="ef-item">
                            <i class="material-icons">search</i>
                            <input type="text" placeholder="검색하고자 하는 메뉴의 이름을 입력하세요~" id="searchKey" name="searchKeyword">
                        </div>
                         <input class="site-btn sb-gradient" type="button" onclick="keywordValidate();" value="검색 하기">
                    </form>
                </div>
            </div>
        </div>
    </div>
	<!-- 검색바 끝 -->
    <section class="classes-details-section overflow-hidden">
        <div class="container">
            <!--  셰프채널 navbar -->
            
            <div class="container">
				<ul class="main-ctg-menu">
					<li> <p>한식</p> </li>
					<li> <p>중식</p> </li>
					<li> <p>일식</p> </li>
					<li> <p>양식</p> </li>
					<li> <p>즉석식</p> </li>
					<li> <p>밀식</p> </li>
					<li> <p>건강식</p> </li>
				</ul>
			</div>
		<!-- 주 카테고리 클릭에 따른 하위 카테고리 반영됨. -->
		<div class="row">
			<div class="container">
				<ul class="sub-ctg-menu">

				</ul>
			</div>
		</div>
        </div>
	</section>   
	<section class="overflow-hidden spad">
	<div class="container col-md-12">
		<div class="container">
			<!-- 영상리스트 섹션 -->
			<div class="row searchedKey"><h5></h5></div>
			<div class="row Ylist searchList" id="Ylist">
					
			</div>
			
			<!-- 검색 영상 페이지바 -->		
			<div class="site-pagination pt-3.5">
			</div>
			
			
			<div class=row>
				<h5>인기영상</h5>
			</div>
			<div class="row Ylist" id="Ylist">
				<c:if test="${not empty popRecipe}">
					<c:forEach items="${popRecipe}" var="rec">
					<div class="col-xs-6 col-sm-3 placeholder chef_list">
						<a
							href="${pageContext.request.contextPath }/recipe/recipe-details?recipeNo=${rec.recipeNo }"><img
							src="https://img.youtube.com/vi/${rec.videoLink }/mqdefault.jpg" alt=""
							class="chef-Thumbnail">
							<div class="forTitle"><p class="chef-Thumbnail-title">${rec.videoTitle }</p></div></a>
						<div class="row">
							<div class="col-8">
								<img src="${pageContext.request.contextPath }/resources/upload/profile/${rec.chefProfile }" class="" alt=""
									style="width: 40px; height: 40px; border-radius: 50%;"> <span
									class="chef-min-name">${rec.chefNick }</span>
							</div>
							<div class="col- chef-view-count">
								<span><small>조회수 : ${rec.viewCount }</small></span>
							</div>
						</div>
					</div>
					</c:forEach>
				</c:if> 
			</div>
		</div>
		<!-- end-->
	</div>
</section>
    	

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>