<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:requestEncoding value="utf-8"/>
<jsp:include page="/WEB-INF/views/common/header.jsp"> 
	<jsp:param value="재고관리" name="pageTitle"/>
</jsp:include>
<link rel="stylesheet" href="css/user-list.css"/>

<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/mypage/chef-list.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/mypage/mall-manager.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/admin-ingmallList.css" />


<!-- 아이디, 비밀번호, 닉네임, 이름,연락처, 이메일, 주소(선택) , 생년월일  -->
<div class="container">
    <div class="section">
        <div class="row">
		<jsp:include page="/WEB-INF/views/common/adminSidenav.jsp">
			<jsp:param value="재고관리" name="sidenav"/>
		</jsp:include>
            <div class="col-10">
                <h4 class="border_bottom">재고관리</h4>
                <br>

                <div class="row">
                    <div class="col-12">
                        <div class="container">
                            <ul class="main-ctg-menu catch-click-event">
                                <li>
                                    <p class="active">채소/과일</p>
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
                            <div class="bx container ">
                                <div class="container">
                                    <ul class="sub-ctg-menu catch-click-event">
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-12 float-right">
                    <button type="button" class="btn btn-outline-success" id="mall-update">변경하기</button>
                    <button type="button" class="btn btn-outline-success" id="mall-insert">추가하기</button>
                </div>
                <br>

                <div class="col-12 row ">
                    <div class="col-1">&nbsp;</div>
                    <div class="col-2 count-menu-bar"></div>
                    <div class="col-3 count-menu-bar">상품 이름</div>
                    <div class="col-2 count-menu-bar text-ag">판매 단위</div>
                    <div class="col-2 count-menu-bar text-ag">가격</div>
                    <div class="col-2 count-menu-bar">재고</div>
                </div>
                
                <!-- 재료 추가되는 영역 -->
                <div class="col-12 row list-category">
                
                </div>
                <!-- 재료 추가되는 영역 -->

            </div>
        </div>
    </div>

<script>
$("#mall-update").click(function(){
	let updateList = new Array();
	let i = 0;
	$(".sel_img").each(function(index,item){
		let $chk = $(item).find("[type=checkbox]");
		if($chk.attr("checked"))
			updateList[i++] = {"ingNo":$(item).attr("value"),
					    	   "minUnit":$(item).find("[type=text]").val(),
							   "price":$(item).find("[name=price]").val(),
							   "stock":$(item).find("[name=stock]").val()}
	});
	updateList = JSON.stringify(updateList);
	$.ajax({
		url:"${pageContext.request.contextPath}/admin/ingMallUpdate",
		method:"POST",
		data:{"updateList":updateList},
		dataType:"text",
		success: function(data){
			alert(data+"개의 상품이 수정되었습니다!");
			$(".sub-ctg-menu").find(".active").trigger("click");
		},
		error:function(){
			alert("상품 수정에 실패했습니다");
		}
	})
});
$("#mall-insert").click(function(){
	location.href="${pageContext.request.contextPath }/admin/ingredientInsert";
});
function cd_category(e){
	let mainCtg = {'mainCtg':$(e).html()};
	$.ajax({
    	url:"${pageContext.request.contextPath}/recipe/getSubCtg",
    	dataType: "json",
    	method : "GET",
    	data: mainCtg,
    	success : data =>{
    	/* 서브 카테고리 교체작업 */
	    	let subCtgList = ' ';
	    	$.each(data,function(index, item){
		    	if(index == 0){
		    		subCtgList += '<li> <p class="active">'+item+'</p> </li>';
		    	}else{
			    	subCtgList += '<li> <p>'+item+'</p> </li>';
		    	}
	    	});
	    	$(".sub-ctg-menu").html(subCtgList);
    	},
    	error : (x,s,e) =>{
    		console.log(x,s,e);
    	}
	});
}

function ingredient_list(e){
	let subCtg = {'subCtg' : $(e).text()};
	$.ajax({
    	url:"${pageContext.request.contextPath}/admin/ingredientList.ajax",
    	dataType : 'json',
    	method : "GET",
    	data : subCtg,
    	success : data =>{
    	/* 재료목록 교체작업 */
	        $(e).addClass("active");
	        $(e).parent().siblings().find("p").removeClass("active");
	        $(".sel_img").remove();
	    	$.each(data,function(index, item){
	    		let ingMall = '';
	    		ingMall =''
			    		+'<div class="col-12 sel_img row" value="'+item.ingMallNo+'">'
			    		+'<div class="col-1">'
		                +'<input type="checkbox" name="check_btn">'
		                +'</div>'
		                +'<div class="col-2 margin-bottong">'
		                +'<img src="${pageContext.request.contextPath}/resources/images/ingredient/'+item.mallEngPrCategory+'/'+item.mallEngCdCategory+'/'+item.prevImg+'" alt="" class="border-rai">'
		                +'</div>'
		                +'<div class="col-3 inner-col">'+item.ingMallName+'</div>'
		                +'<div class="col-2 inner-col">'
		                +'<input type="text" class="form-control input-number" value="'+item.minUnit+'">'
		                +'</div>'
		                +'<div class="col-2 inner-col">'
		                +'<input type="number" name="price" class="form-control input-number" value="'+item.price+'" step="10">'
		                +'</div>'
		                +'<div class="col-2 inner-col">'
		                +'<input type="number" name="stock" class="form-control input-number" value="'+item.stock+'">'
		                +'</div>'
		                +'</div>'
		    	$(".list-category").append(ingMall); 
	    	});
    	},
    	error : (x,s,e) =>{
    		console.log(x,s,e);
    	}
	});
}

$(document).on("click",".sub-ctg-menu p",function(){ 
				ingredient_list($(this));})
		   .on("click",".sel_img",function(e) {
			    let $chk = $(this).find("[type=checkbox]")
			    $chk.attr("checked", !$chk.attr("checked"));
			});

$(function(){
    $(".catch-click-event").find("p").on("click",function(){
        $(this).addClass("active");
        $(this).parent().siblings().find("p").removeClass("active");
        console.log($(this).text());
    });
	
    $(".product_container").on("click",function(){
    	location.href = "${pageContext.request.contextPath }/mall/productDetail.do";
    });
    $(".main-ctg-menu").find("p").on("click",function(){
    	cd_category($(this));
    });
	$(".active").trigger("click");
/*   	$(".active").click(); */
	/* $(".main-ctg-menu").find("p")[0].trigger("click"); */
	
});
</script>


<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
