4<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:requestEncoding value="utf-8" />
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="냉장고 재료로 레시피 검색!" name="pageTitle" />
</jsp:include>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/recipe-search(Menu).css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/recipe-search(Ingredients).css">
<link
	href="https://fonts.googleapis.com/css?family=Nanum+Gothic:400,700,800&display=swap&subset=korean"
	rel="stylesheet">
<script>
	var contextPath = "${pageContext.request.contextPath}"
</script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/js/recipe/searchbyingredients.js"
	charset="UTF-8">
	
</script>

<section class="page-top-section page-sp set-bg"
	data-setbg="img/page-top-bg.jpg">
	<div class="container">
		<div class="row">
			<div class="col-lg-7 m-auto text-white">
				<h2>냉장고 재료로 레시피 검색</h2>
				<p>나의 냉장고 재료로 해먹는 든든한 한끼</p>
			</div>
		</div>
	</div>
</section>

<style>
</style>
<section class="overflow-hidden spad">

	<div class="container col-md-12">
		<div class="container">
			<ul class="main-ctg-menu">

				<li>
					<p>인기재료</p>
				</li>
				<li>
					<p>채소/과일</p>
				</li>
				<li>
					<p>육류</p>
				</li>
				<li>
					<p>수산물</p>
				</li>
				<li>
					<p>곡물/견과류</p>
				</li>
				<li>
					<p>양념/소스</p>
				</li>
				<li>
					<p>가공/유제품</p>
				</li>
				<li>
					<p>기타</p>
				</li>
			</ul>
		</div>

		<div class="row sub-container">
			<div class="bx container col-md-9">
				<div class="container">
					<ul class="sub-ctg-menu">
					</ul>
				</div>
				<!-- 첫번쨰 재료줄 -->
				<div class="row firstline ingline"></div>
				<!-- 두번쨰 재료줄 -->
				<div class="row secondline ingline"></div>
				<!-- 재료리스트 페이징 -->
				<div class="row ing-paging text-center">
					<ul class="pagination justify-content-center col">

					</ul>
				</div>
			</div>
			<!-- 선택한 재료 태그 수집 -->
			<div class="selected-container col-md-3">
				<div>
					<h5 class="giving-spaces">선택한 재료 태그</h5>
				</div>
				<!-- 선택된 재료 담는 div -->
				<div class="selected-ingredients"></div>
				<div class="col btn-section">
					<button type="button" class="btnforseach"
						onclick="recipeSearchByIng();">
						선택한 재료로 검색하기 <i class="fab fa-sistrix"></i>

					</button>
				</div>
			</div>
		</div>
	</div>
</section>
<!-- 재료선택영역 end -->

<section class="overflow-hidden spad">
	<div class="container col-md-12">
		<div class="container">
			<!-- 영상리스트 섹션 -->

			<div class="row Ylist" id="Ylist">
				<c:if test="${not empty popRecipe}">

					<c:forEach items="${popRecipe}" var="rec">
						<div class="col-xs-6 col-sm-3 placeholder chef_list">
							<a
								href="${pageContext.request.contextPath }/recipe/recipe-details?recipeNo=${rec.recipeNo }"><img
								src="https://img.youtube.com/vi/${rec.videoLink }/mqdefault.jpg"
								alt="" class="chef-Thumbnail">
								<div class="forTitle">
									<p class="chef-Thumbnail-title">${rec.videoTitle }</p>
								</div></a>
							<div class="row">
								<div class="col-8">
									<img
										src="${pageContext.request.contextPath }/resources/upload/profile/${rec.chefProfile }"
										class="" alt="" onerror="${pageContext.request.contextPath }/resources/upload/profile/chef_default1"
										style="width: 40px; height: 40px; border-radius: 50%;">
									<span class="chef-min-name">${rec.chefNick }</span>
								</div>
								<div class="col- chef-view-count">
									<span><small>조회수 : ${rec.viewCount }</small></span>
								</div>
							</div>
						</div>
					</c:forEach>
				</c:if>
			</div>
			
			<div class="site-pagination pt-3.5">
			</div>
			
		</div>
		<!-- end-->
	</div>
</section>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />
