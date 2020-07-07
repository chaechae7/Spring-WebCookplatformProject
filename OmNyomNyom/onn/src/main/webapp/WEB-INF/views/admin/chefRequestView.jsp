<%@page import="com.soda.onn.member.model.vo.Member"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:requestEncoding value="utf-8"/>

<!-- 해시태그부분 소스 -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/prism/1.17.1/themes/prism.min.css">
    <script src='https://cdnjs.cloudflare.com/ajax/libs/prism/1.17.1/prism.min.js'></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/tagify.css">
    <script src="${pageContext.request.contextPath }/resources/js/tagify.js"></script>
    <script src="${pageContext.request.contextPath }/resources/js/jQuery.tagify.min.js"></script>
 
 
	<jsp:include page="/WEB-INF/views/common/header.jsp"> 
	<jsp:param value="안녕 옴뇸뇸!" name="pageTitle"/>
	</jsp:include>

  	<script src="${pageContext.request.contextPath }/resources/js/class-insert.js"></script>
    <!--  해당 페이지 css-->
	<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/chefInsert.css" />

<!-- Event Details Section end -->
 <script data-name="dropdown-tags">
        $(function() {

            var input = document.querySelector('input[name="menuPrCategory"]'),
                // init Tagify script on the above inputs
                tagify = new Tagify(input, {
                    whitelist: ["한식", "중식", "일식", "양식", "밀식", "즉석식", "기타식", "건강식"],
                    maxTags: 3,
                    dropdown: {
                        maxItems: 20, // <- mixumum allowed rendered suggestions
                        classname: "tags-look", // <- custom classname for this dropdown, so it could be targeted
                        enabled: 0, // <- show suggestions on focus
                        closeOnSelect: false // <- do not hide the suggestions dropdown once an item has been selected
                    }
                });
        });
 </script>
 <script>
        window.onload = function() {
            //비디오 불러오기 후 처리
       
            function video_readURL(input) {
                if (input.files && input.files[0]) {
                    var imgFile = $(input).val();
                    var fileForm = /(.*?)\.(mp4|mov|mpeg4|avi|wmv)$/i;
                    var maxSize = 64 * 1000 * 1000 * 1000;
                    var fileSize;

                    if (imgFile != "" && imgFile != null) {
                        fileSize = input.files[0].size;
                        if (!imgFile.match(fileForm)) {
                            alert("비디오 파일(mp4,mov,mpeg4,avi,wmv)만 업로드 가능");
                            $(input).val(null);
                            return;
                        } else if (fileSize > maxSize) {
                            alert("파일 사이즈는 64GB까지 가능");
                            $(input).val(null);
                            return;
                        }
                    }


                    var reader = new FileReader();

                    reader.onload = function(e) {
                        //                    	$('#image_section').show();
                        //                        $('.image_section_src').attr('src', e.target.result).show();
                        $('#video_section').attr('src', e.target.result).show();
                        let $vidoe_uploadbtn = $("#vidoe_uploadbtn");
                        $vidoe_uploadbtn.html("");
                        $vidoe_uploadbtn.addClass("uploading");
                        setTimeout(function() {
                            $vidoe_uploadbtn.removeClass('uploading');
                            $vidoe_uploadbtn.html("Upload Files");
                        }, 1200);
                    };

                    reader.readAsDataURL(input.files[0]);
                } else {
                    $('#video_section').hide();
                }
            }

            //비디오 불러오기
            $("#videoInput").change(function() {

                video_readURL(this);
            });

            //시작시 비다오
            $("#video_section").hide();


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
                        $('#image_section').attr('src', e.target.result).show();
                        let $uploadbtn = $("#uploadbtn");
                        $uploadbtn.html("");
                        $uploadbtn.addClass("uploading");
                        setTimeout(function() {
                            $uploadbtn.removeClass('uploading');
                            $uploadbtn.html("Upload Files");
                        }, 1200);
                    };

                    reader.readAsDataURL(input.files[0]);
                } else {
                    $('#image_section').hide();
                }
            }

            //이미지 불러오기
            $("#imgInput").change(function() {

                readURL(this);
            });

            //시작시 이미지
            $("#image_section").hide();

        };

        //이미지 불러오기 버튼 처리
        function videoUpload(ref) {
            $("#videoInput").click();
        };

        function upload(ref) {
            $("#imgInput").click();
        };

        // 영상 업로드 버튼에 따른 뷰단 조정
        function view_change(e) {
            let id = $(e).attr('id');
            console.log(id);
            if (id == "video_btn") {
                $("#url_upload").css('display', 'none');
                $("#video_upload").css('display', 'block');
            } else {
                $("#url_upload").css('display', 'block');
                $("#video_upload").css('display', 'none');
            }
        }
    </script>

 <!-- 페이지 titile start -->
    <section class="event-details-section spad overflow-hidden">
        <div class="tm-section-2">
            <div class="container">
                <div class="row">
                    <div class="col text-center">
                        <h2 class="tm-section-title">셰프 신청목록 </h2>
                        <!-- <p class="tm-color-white tm-section-subtitle">당신을 응원합니다.</p> -->
                    </div>
                </div>
            </div>
        </div>


        <div class="tm-section tm-position-relative">
            <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100" preserveAspectRatio="none" class="tm-section-down-arrow">
                    <polygon fill="#4949e7" points="0,0  100,0  50,60"></polygon>
        </svg>

    </section>
    <script>
   
    </script>
    <!-- 페이지 titile end -->
    <!-- Event Details Section -->
    <section class="event-details-section spad overflow-hidden">
        <div class="container">
      
            
              <%-- <%Member memberLoggedIn = (Member)session.getAttribute("memberLoggedIn");
              	System.out.println(memberLoggedIn.getMemberId());%> --%>
				 <input type="text" name="chefId" value="${memberLoggedIn.memberId}" hidden/> 
                <hr>
                <h3 class="mall_isnert_title title_auto">주 종목 등록</h3>
                <p class="title_info">셰프님의 주 종목을 3가지까지만 등록해주세요.</p>
                <hr>
                <!-- 음식주종목 3가지 선택 -->
                <div class="input-group mb-3">
                    <div class="input-group-prepend">
                        <span class="input-group-text" id="basic-addon1">주 종목</span>
                    </div>
                  
                    <input type="text" class="form-control" name="menuPrCategory" class="some_class_name"  
                    		value="${categoryStr }" aria-label="Username" aria-describedby="basic-addon1" readonly>
                    
                </div>

                <div class="row" style="margin-top:100px;">
                    <div class="col-lg-4">
                        <!-- 프로필 이미지 등록 -->
                        <h3 class="mall_isnert_title">프로필 등록</h3>

                        <hr>
                        <p style="font-size: 10px; color:red;">*규격은 200px*200px 입니다.</p>
                        <div class="chef_img">
                            <img src="${pageContext.request.contextPath }/resources/upload/profile/${chefRequest.chefProfile}" 
                            	 style="display: inline-block !important; width:200px; height:200px;"alt="" id="image_section">
                        </div>

                    </div>

                    <!-- 사이드부분 -->
                    <div class="col-lg-8 col-md-5 col-sm-8 ">
                        <h3 class="mall_isnert_title">셰프정보 등록</h3>
                        <hr>
                        <!-- 셰프 채널명 닉네임 -->
                        <p style="font-size: 10px; color:red; margin-left:5px; float: right; position:relative; top: 25px;">*채널명은 닉네임과 동일하게 진행됩니다.</p>
                        <span class="input input--yoshiko">
                                    <!-- 클래스명 input -->
                                    <input class="input__field input__field--yoshiko" type="text" id="input-class-name" name="chefNickName" value="${chefRequest.chefNickName }" readonly />
                                    <!-- 클래스명 라벨 -->
                                    <label class="input__label input__label--yoshiko" for="input-class-name">
                                        <span class="input__label-content input__label-content--yoshiko" data-content="채널명(닉네임)">채널명(닉네임)</span>
                        </label>
                        </span>

                        <!--  사업장 등록  -->
                        <p style="font-size: 10px; color:red; margin-left:5px; float: right; position:relative; top: 25px;">*운영하시는 사업장을 홍보해 드립니다. (업장명/주소)</p>
                        <span class="input input--yoshiko">
                                    <!-- 클래스명 input -->
                                    <input class="input__field input__field--yoshiko" name="businessInfo" type="text" id="input-class-name" value="${chefRequest.businessInfo}" readonly/>
                                    <!-- 클래스명 라벨 -->
                                    <label class="input__label input__label--yoshiko" for="input-class-name">
                                        <span class="input__label-content input__label-content--yoshiko" data-content="사업장 정보">사업장 정보</span>
                        </label>
                        </span>
                    </div>
                    <!-- sns 정보 등록  -->
                    <div class="col-lg-12">
                        <hr>
                        <h3 class="mall_isnert_title title_auto">SNN </h3>
                        <p class="title_info">셰프님의 sns 정보입니다. </p>
                        <hr>
                    </div>
                    <div class="col-lg-6">
                        <span class="input input--yoshiko">
                            <!-- 클래스명 input -->
                            <input class="input__field input__field--yoshiko"  type="text" name="facebook" id="input-class-name" value="${snsMap['facebook']}" />
                            <!-- 클래스명 라벨 -->
                            <label class="input__label input__label--yoshiko" for="input-class-name">
                                <span class="input__label-content input__label-content--yoshiko" data-content="페이스북">페이스북</span>
                        </label>
                        </span>
                    </div>
                    <div class="col-lg-6">
                        <span class="input input--yoshiko">
                            <!-- 클래스명 input -->
                            <input class="input__field input__field--yoshiko" type="text" name="insta" id="input-class-name" value="${snsMap['insta ']}"/>
                            <!-- 클래스명 라벨 -->
                            <label class="input__label input__label--yoshiko" for="input-class-name">
                                <span class="input__label-content input__label-content--yoshiko" data-content="인스타그램">인스타그램</span>
                        </label>
                        </span>
                    </div>
                </div>


                <hr>
                <h3 class="mall_isnert_title title_auto">어필영상 등록</h3>
                <p class="title_info">저희는 어필영상으로 신청 여부를 결정하고 있습니다. 자신있는 영상을 반드시 등록 부탁드립니다.</p>
                <hr>
               
                <div class="row">
                    <div class="col-lg-12" style="text-algin:center;">

                            <iframe width="560" height="315" src="https://www.youtube.com/embed/${chefRequest.chefApVideo}"
                           style="margin:auto; " frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
                            
                          
                    </div>
                </div>
                <hr>
                <h3 class="mall_isnert_title title_auto">셰프님 자기소개 </h3>
                <p class="title_info">셰프님의 간략한 자기 소개 입니다. </p>
                <hr>
                <div cols="118" rows="10" name="chefContent">${chefRequest.chefContent }</div>
                <div class="sb-widget">
                 <form style="display: none" action="${pageContext.request.contextPath }/admin/chefRequest" method="POST" id="request_put">
					  <input type="hidden" id="chefId" name="chefId" value="${chefRequest.chefId }"/>
					  <input type="hidden" id="variable" name="variable" value=""/>
			     </form>
					<input type="button" class="site-btn sb-gradient reservation_class ac_ok_btn" value="셰프수락 ">
                    <input type="button" class="site-btn sb-gradient reservation_class ac_no_btn" value="셰프거절 ">
                </div>
        </div>
    </section>
  <script src="${pageContext.request.contextPath }/resources/js/classie.js"></script>
  <script>
        $(function() {
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
            //submit 버튼 
            	$(".ac_ok_btn").on("click",function(){
					$("#variable").val("Y");
					$("#request_put").submit();
				});
				
				$(".ac_no_btn").on("click",function(){
					$("#variable").val("N");
					$("#request_put").submit();
				});
            
        });
    </script>
<jsp:include page="/WEB-INF/views/common/footer.jsp" />
