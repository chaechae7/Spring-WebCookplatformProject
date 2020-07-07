<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:requestEncoding value="utf-8"/>
<jsp:include page="/WEB-INF/views/common/header.jsp"> 
<jsp:param value="안녕 옴뇸뇸!" name="pageTitle"/>
</jsp:include>

<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/mall_insert.css" />
    <!-- 페이지 titile start -->
  

    <section class="event-details-section spad overflow-hidden">
        <div class="tm-section-2">
            <div class="container">
                <div class="row">
                    <div class="col text-center">
                        <h2 class="tm-section-title">뇸뇸몰 상품 등록</h2>
                        <p class="tm-color-white tm-section-subtitle">등록할 상품을 등록하세요.</p>
                    </div>
                </div>
            </div>
        </div>


        <div class="tm-section tm-position-relative">
            <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100" preserveAspectRatio="none" class="tm-section-down-arrow">
                    <polygon fill="#4949e7" points="0,0  100,0  50,60"></polygon>
        </svg>
		</div>
    </section>
    <!-- 페이지 titile end -->
    <!-- Event Details Section -->
    <section class="event-details-section spad overflow-hidden">
        <div class="container">
            <form action ="${pageContext.request.contextPath }/admin/ingredientInsert" 
            	  method="POST" 
            	  enctype="multipart/form-data">
                <hr>
                <h3 class="mall_isnert_title title_auto">상세상품 카테고리 등록</h3>
                <p class="title_info">상품 관련 카테고리를 등록해 주세요.</p>
                <hr>
                <div class="row ">
                    <div class="col-lg-3">
                     <select class="circle-select pr_category" id="pr_category"  name="ingPrCategory">
                        <option data-display="대분류 ">대분류</option>
                         <option value="채소/과일">채소/과일</option>
                        <option value="육류">육류</option>
                        <option value="수산물">수산물</option>
                        <option value="곡물/견과류">곡물/견과류</option>
                        <option value="양념/소스">양념/소스</option>
                        <option value="가공/유제품">가공/유제품</option>
                        <option value="기타">기타</option>
                    </select>
                    <input type="text" id="enPrcategory"name="engPrCategory" hidden/>
             </div>
                    <div class="col-lg-3 here">
                        <select class="circle-select subCt" id="" name ="ingcdCategory">
                            <option data-display="중분류">중분류</option>
                            <option value="잎채소">잎채소</option>
                            <option value="열매채소">열매채소</option>
                            <option value="뿌리채소">뿌리채소</option>
                            <option value="버섯">버섯</option>
                            <option value="나물/허브류">나물/허브류</option>
                         </select>
                    </div>
                    <input type="text" id="enCrcategory" name="engCrCategory" hidden/>
                </div>
                  <script>
                    $("#pr_category").change(function(){
                    	let pr = $(this).val();	
                    	console.log(pr);
                    	
                    	$.ajax({
                    		url:"${pageContext.request.contextPath }/admin/prCategory",
                    		method : "GET",
                    		sycn:false,
                    		data :{"prCategory":pr},
                    		success : data =>{
                    			console.log(data);
                    			$("#enPrcategory").val(data.engPrcategory);
                    			
                    			console.log($("#enPrcategory").val());
                    			
                    			$(".subCt").remove();
                    			
                    			//append할 코드 
                    			let p =  '<select class="circle-select subCt" id="" name ="ingcdCategory"> '
                    						+'<option data-display="중분류">중분류</option>';
                                   
                    			$.each(data.subCtgList ,function(idx,item){
                                      p += '<option value="'+item+'">'+item+'</option>' ;                                   	
                    			});
								console.log(p);
								p += '</select>';
								
                    			$(".here").append(p);
                    				
                    		},error : (x,s,e) =>{
								console.log(x,s,e);
							}
                    	}); 
                    });
                    
                    $(".here").change(function(){
                    	let pr = $(".subCt").val();	
                    	$.ajax({
                    		url:"${pageContext.request.contextPath }/admin/crCategory",
                    		method : "GET",
                    		data :{"crCategory":pr},
                    		success : data =>{
                    			console.log(data);
                    			$("#enCrcategory").val(data);
	
                    		},error : (x,s,e) =>{
								console.log(x,s,e);
							}
                    	}); 
                    });
                    </script>
                <div class="row">
                    <div class="col-lg-5">
                        <!-- 이미지 등록 -->
                        <h3 class="mall_isnert_title">상품 이미지 등록</h3>
                        <hr>
                        <div class="oneday_class_img">
                            <div id="uploadbtn" onclick="upload(this);">Upload Files</div>
                            <input type='file' class="imgInput" name ="ingFilename" hidden/>
                            <img src="#" alt="" id="image_section">
                        </div>

                    </div>

                    <!-- 사이드부분 -->
                    <div class="col-lg-7 col-md-5 col-sm-8 ">
                        <h3 class="mall_isnert_title">상품정보 등록</h3>
                        <hr>
                        <!-- 재료명 입력란 -->
                        <span class="input input--yoshiko">
                                    <!-- 클래스명 input -->
                                    <input class="input__field input__field--yoshiko" type="text" id="input-class-name" name="ingredientName" />
                                    <!-- 클래스명 라벨 -->
                                    <label class="input__label input__label--yoshiko" for="input-class-name">
                                        <span class="input__label-content input__label-content--yoshiko" data-content="상품명">상품명</span>
                        </label>
                        </span>

                        <!-- 상품가격 입력란 -->
                        <span class="input input--yoshiko">
                                    <!-- 상품가격 input -->
                                    <input class="input__field input__field--yoshiko" type="text" id="input-class-channel" name="price" value=""/>
                                    <!-- 상품가격 라벨 -->
                                    <label class="input__label input__label--yoshiko" for="input-class-channel">
                                        <span class="input__label-content input__label-content--yoshiko" data-content="상품가격">상품가격</span>
                        </label>
                        </span>
                        <!-- 상품 판매단위/중량/용량 입력란 -->
                        <span class="input input--yoshiko">
                                    <!-- 판매단위/중량/용량  input -->
                                    <input class="input__field input__field--yoshiko" type="text" id="input-class-cost" name="minUnit"/>
                                    <!-- 판매단위/중량/용량  라벨 -->
                                    <label class="input__label input__label--yoshiko" for="input-class-cost">
                                        <span class="input__label-content input__label-content--yoshiko" data-content="판매단위/중량/용량">판매단위/중량/용량</span>
                        </label>
                        </span>
						
						<!-- 상품 판매단위/중량/용량 입력란 -->
                        <span class="input input--yoshiko">
                                    <!-- 판매단위/중량/용량  input -->
                                    <input class="input__field input__field--yoshiko" type="text" id="input-class-cost" name="stock"/>
                                    <!-- 판매단위/중량/용량  라벨 -->
                                    <label class="input__label input__label--yoshiko" for="input-class-cost">
                                    <span class="input__label-content input__label-content--yoshiko" data-content="재고량">제고량</span>
                        </label>
                        </span>
                        
                        <!-- 상품 원산지 입력란 -->
                        <span class="input input--yoshiko">
                            <!-- 상품 원산지 input -->
                            <input class="input__field input__field--yoshiko" type="text" id="input-class-cost" name="ingOrigin" />
                            <!-- 상품 원산지  라벨 -->
                            <label class="input__label input__label--yoshiko" for="input-class-cost">
                                <span class="input__label-content input__label-content--yoshiko" data-content="상품 원산지">상품 원산지</span>
                        </label>
                        </span>

                        <!-- 상품 유통기한 입력란 -->
                        <span class="input input--yoshiko">
                                    <!-- 상품 유통기한 input -->
                                    <input class="input__field input__field--yoshiko" type="text" id="input-class-adress"name="shelfLife"  />
                                    <!-- 상품 유통기한 라벨 -->
                                    <label class="input__label input__label--yoshiko" for="input-class-adress">
                                        <span class="input__label-content input__label-content--yoshiko" data-content="상품 유통기한">상품 유통기한</span>
                        </label>
                        </span>

                    </div>
                </div>


                <hr>
                <h3 class="mall_isnert_title title_auto">상세상품 등록</h3>
                <p class="title_info">상품 관련 상세이미지를 등록하세요!</p>
                <hr>

                <div class="row">
                    <div class="col-lg-5">

                        <!-- 상품 상세 이미지 등록 -->
                         <div class="mall_img">
                            <div id="uploadbtn" onclick="upload(this);">Upload Files</div>
                            <input type='file' class="imgInput" name="ingInfo" hidden/>
                            <img src="#" alt="" id="image_section">
                        </div> 
                    </div>
                </div>
                <div class="sb-widget">
                    <!-- 상품 등록 버튼 -->
                    <button type="submit" class="site-btn sb-gradient reservation_class">등록하기</button>
                </div>
            </form>
        </div>
    </section>
    <!-- Event Details Section end -->
     <script src="${pageContext.request.contextPath }/resources/js/classie.js"></script>
    <script>
        $(document).ready(function() {
            // trim polyfill : https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/String/Trim
            if (!String.prototype.trim) {
                (function() {
                    // Make sure we trim BOM and NBSP
                    var rtrim = /^[\s\uFEFF\xA0]+|[\s\uFEFF\xA0]+$/g;
                    String.prototype.trim = function() {
                        return this.replace(rtrim, '');
                    };
                })();
            }
            [].slice.call(document.querySelectorAll('input.input__field')).forEach(function(inputEl) {
                // in case the input is already filled..
                if (inputEl.value.trim() !== '') {
                    classie.add(inputEl.parentNode, 'input--filled');
                }
                // events:
                inputEl.addEventListener('focus', onInputFocus);
                inputEl.addEventListener('blur', onInputBlur);
            });

            function onInputFocus(ev) {
                classie.add(ev.target.parentNode, 'input--filled');
            }

            function onInputBlur(ev) {
                if (ev.target.value.trim() === '') {
                    classie.remove(ev.target.parentNode, 'input--filled');
                }
            }
               
                


                //이미지 불러오기 후 처리
                function readURL(input) {
                    if (input.files && input.files[0]) {
                        var imgFile = $(input).val();
                        var fileForm = /(.*?)\.(jpg|jpeg|png)$/i;
                        var maxSize = 5 * 1024 * 1024;
                        var fileSize;

                        if (imgFile != "" && imgFile != null) {
                            fileSize = input.files[0].size;
                            if (!imgFile.match(fileForm)) {
                                alert("이미지 파일만 업로드 가능");
                                $(input).val(null);
                                return;
                            } else if (fileSize > maxSize) {
                                alert("파일 사이즈는 5MB까지 가능");
                                $(input).val(null);
                                return;
                            }
                        }


                        var reader = new FileReader();

                        reader.onload = function(e) {
                            $(input).next().attr('src', e.target.result).show();
                            let $uploadbtn = $(input).prev();
                            $uploadbtn.html("");
                            $uploadbtn.addClass("uploading");
                            setTimeout(function() {
                                $uploadbtn.removeClass('uploading');
                                $uploadbtn.html("Upload Files");
                            }, 1200);
                        };

                        reader.readAsDataURL(input.files[0]);
                    } else {
                        $(input).next().hide();
                    }
                }

 
            
            
            //이미지 불러오기
            $(".imgInput").change(function() {

                readURL(this);
            });

            //시작시 이미지
            //$("#image_section").hide();


	         
        });
        function upload(ref) {
            $(ref).next().click();
        };
    </script>
    
<jsp:include page="/WEB-INF/views/common/footer.jsp" />
