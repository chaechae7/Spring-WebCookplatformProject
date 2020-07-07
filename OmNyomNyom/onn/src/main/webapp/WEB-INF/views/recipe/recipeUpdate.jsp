<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:requestEncoding value="utf-8"/> <!-- 인코딩설정 안해주면 한글 깨짐  -->
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="" name="pageTitle"/>
</jsp:include>
    <!-- Main Stylesheets --><!--  -->
    <link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/recipeUpdate.css">
    
    <script>
    function recipeUpload() {
		location.href="${pageContext.request.contextPath}/recipe/recipeUpload.do";
	};
	function recipeUpdate(rNo,cId){
		let frm = $('#recipe_update_frm');
		frm.children('[name=chefId]').val(cId);
		frm.children('[name=recipeNo]').val(rNo);
		frm.submit();
	}
	function deleteRecipeList(){
		$("#delete_list_frm").submit();
	}
    </script>
   <section class="page-top-section page-sp set-bg" data-setbg="">
        <div class="container">
            <div class="row">
                <div class="col-lg-7 m-auto text-white">
                    <h2>레시피 관리</h2>
                    <h6>여러분들이 올린 레시피를 수정 혹은 삭제해보세요.</h6>
                </div>
            </div>
        </div>
    </section>

    <div class="container" id="video-upload-video">
        <h6>업로드한 동영상</h6>
        <div class="row">
            <div class="col-lg-12">
                <button type="button" class="btn btn-outline-danger" onclick="deleteRecipeList();">동영상 삭제</button>
                <button type="button" class="btn btn-outline-danger" onclick="recipeUpload();">동영상 업로드</button>
            </div>
        </div>
		<form id="recipe_update_frm" action="${pageContext.request.contextPath }/recipe/recipeUpdateFrm" method="post" hidden>
			<input type="text" name="chefId">
			<input type="text" name="recipeNo">
		</form>
        <form id="delete_list_frm" action="${pageContext.request.contextPath }/recipe/deleteRecipeList" method="post">
	        <div class="row">
	        	<input type="text" name="chefId" value="${recipeList[0].chefNick }" hidden>
				<c:forEach items="${recipeList }" var="recipe" varStatus="vs">
	            <div class="col-lg-3 upload-video">
	                <input type="checkbox" name="deleteList" value=${recipe.recipeNo}>
	            	<a href="${pageContext.request.contextPath }/recipe/recipe-details?recipeNo=${recipe.recipeNo}">
	                <img src="https://img.youtube.com/vi/${recipe.videoLink }/mqdefault.jpg" alt="" width="300" height="150">
	                <h6>${recipe.videoTitle }</h6>
	                </a>
	                <li>조회수 : ${recipe.viewCount }</li> <input type="button" class="btn btn-outline-danger" onclick="recipeUpdate(${recipe.recipeNo},'${recipe.chefId }');" value="수정">
	            </div>
	            </c:forEach>
	        </div>
		</form>
        <!-- <div class="row">
	        <div class="col-lg-12">
	            <nav aria-label="Page navigation example" class="chefpagebar">
	                <ul class="pagination">
	                    <li class="page-item">
	                        <a class="page-link" href="#" aria-label="Previous">
	                            <span aria-hidden="true">&laquo;</span>
	                        </a>
	                    </li>
	                    <li class="page-item"><a class="page-link" href="#">1</a></li>
	                    <li class="page-item"><a class="page-link" href="#">2</a></li>
	                    <li class="page-item"><a class="page-link" href="#">3</a></li>
	                    <li class="page-item"><a class="page-link" href="#">4</a></li>
	                    <li class="page-item"><a class="page-link" href="#">5</a></li>
	                    <li class="page-item">
	                        <a class="page-link" href="#" aria-label="Next">
	                            <span aria-hidden="true">&raquo;</span>
	                        </a>
	                    </li>
	                </ul>
	            </nav>
	        </div>
	    </div> -->
    </div>
    

		

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>