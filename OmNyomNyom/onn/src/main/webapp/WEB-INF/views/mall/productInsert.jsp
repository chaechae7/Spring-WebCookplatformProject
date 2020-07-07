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
    <script src="js/class-insert.js"></script>

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

    </section>
    <!-- 페이지 titile end -->
    <!-- Event Details Section -->
    <section class="event-details-section spad overflow-hidden">
        <div class="container">
            <form action="">
                <hr>
                <h3 class="mall_isnert_title title_auto">상세상품 카테고리 등록</h3>
                <p class="title_info">상품 관련 카테고리를 등록해 주세요.</p>
                <hr>
                <div class="row ">
                    <div class="col-lg-3">
                        <select class="circle-select">
                        <option data-display="채소">채소</option>
                        <option value="2">육류</option>
                        <option value="2">수산물</option>
                        <option value="2">곡물/견과류</option>
                        <option value="2">양념/소스</option>
                        <option value="2">기타</option>
                    </select>
                    </div>
                    <div class="col-lg-3">
                        <select class="circle-select">
                            <option data-display="과일">과일</option>
                            <option value="2">잎채소</option>
                            <option value="2">열매채소</option>
                            <option value="2">뿌리채소</option>
                            <option value="2">버섯</option>
                            <option value="2">나물/허브류</option>
                            </select>
                    </div>
                </div>
                <div class="row">
                    <div class="col-lg-5">
                        <!-- 이미지 등록 -->
                        <h3 class="mall_isnert_title">상품 이미지 등록</h3>
                        <hr>
                        <div class="oneday_class_img">
                            <div id="uploadbtn" onclick="upload(this)">Upload Files</div>
                            <input type='file' id="imgInput" hidden/>
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
                                    <input class="input__field input__field--yoshiko" type="text" id="input-class-name" />
                                    <!-- 클래스명 라벨 -->
                                    <label class="input__label input__label--yoshiko" for="input-class-name">
                                        <span class="input__label-content input__label-content--yoshiko" data-content="상품명">상품명</span>
                        </label>
                        </span>

                        <!-- 상품가격 입력란 -->
                        <span class="input input--yoshiko">
                                    <!-- 상품가격 input -->
                                    <input class="input__field input__field--yoshiko" type="text" id="input-class-channel" value=""/>
                                    <!-- 상품가격 라벨 -->
                                    <label class="input__label input__label--yoshiko" for="input-class-channel">
                                        <span class="input__label-content input__label-content--yoshiko" data-content="상품가격">상품가격</span>
                        </label>
                        </span>
                        <!-- 상품 판매단위/중량/용량 입력란 -->
                        <span class="input input--yoshiko">
                                    <!-- 판매단위/중량/용량  input -->
                                    <input class="input__field input__field--yoshiko" type="text" id="input-class-cost" />
                                    <!-- 판매단위/중량/용량  라벨 -->
                                    <label class="input__label input__label--yoshiko" for="input-class-cost">
                                        <span class="input__label-content input__label-content--yoshiko" data-content="판매단위/중량/용량">판매단위/중량/용량</span>
                        </label>
                        </span>

                        <!-- 상품 원산지 입력란 -->
                        <span class="input input--yoshiko">
                            <!-- 상품 원산지 input -->
                            <input class="input__field input__field--yoshiko" type="text" id="input-class-cost" />
                            <!-- 상품 원산지  라벨 -->
                            <label class="input__label input__label--yoshiko" for="input-class-cost">
                                <span class="input__label-content input__label-content--yoshiko" data-content="상품 원산지">상품 원산지</span>
                        </label>
                        </span>

                        <!-- 상품 유통기한 입력란 -->
                        <span class="input input--yoshiko">
                                    <!-- 상품 유통기한 input -->
                                    <input class="input__field input__field--yoshiko" type="text" id="input-class-adress" />
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
                            <div id="uploadbtn" onclick="upload(this)">Upload Files</div>
                            <input type='file' id="imgInput" hidden/>
                            <img src="#" alt="" id="image_section">
                        </div>
                    </div>
                </div>
                <div class="sb-widget">
                    <!-- 상품 등록 버튼 -->
                    <button class="site-btn sb-gradient reservation_class"><a href="class_reservation.html">등록하기</a></button>
                </div>
            </form>
        </div>
    </section>
    <!-- Event Details Section end -->

<jsp:include page="/WEB-INF/views/common/footer.jsp" />
