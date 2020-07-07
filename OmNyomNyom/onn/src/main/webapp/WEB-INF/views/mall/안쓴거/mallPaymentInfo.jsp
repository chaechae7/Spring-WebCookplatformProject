<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:requestEncoding value="utf-8"/>
<jsp:include page="/WEB-INF/views/common/header.jsp"> 
<jsp:param value="안녕 옴뇸뇸!" name="pageTitle"/>
</jsp:include>

<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/mall_delivery_info.css" />
<!-- 결제정보 js -->
    <script>
        $(document).ready(function() {
            //현재HTML문서가 브라우저에 로딩이 끝났다면   
            $("div.select-pay").hide();
            $('#card').click(function() {
                $("#card-pay").show();
                $("#bank-pay").hide();
                $("#card").style.backgroundColor = "#4949e7";
            }); //click

            $('#bank').click(function() {
                $("#bank-pay").show();
                $("#card-pay").hide();
                $("#bank").style.backgroundColor = "#4949e7";
            });
        }); //ready  

        function mallPayment() {
            location.href="${pageContext.request.contextPath }/mall/mallResult.do";
        };
    </script>
  <!-- Event Details Section -->
    <section class="event-details-section spad overflow-hidden">
        <div class="tm-section-2">
            <div class="container">
                <div class="row">
                    <div class="col text-center">
                        <h2 class="tm-section-title">뇸뇸몰</h2>
                        <p class="tm-color-white tm-section-subtitle">신선한 식재료만을 추구합니다. </p>
                    </div>
                </div>
            </div>
        </div>


        <div class="tm-section tm-position-relative">
            <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100" preserveAspectRatio="none"
                class="tm-section-down-arrow">
                <polygon fill="#4949e7" points="0,0  100,0  50,60"></polygon>
            </svg>
            <div class="container tm-pt-5 tm-pb-4">
                <div class="wizard">
                    <a><span class="badge">01</span>장바구니</a> <a><span class="badge">02</span> 선택된
					상품 리스트</a> <a><span class="badge">03</span> 배송지 정보</a> <a class="current badge-inverse"><span
					class="badge ">04</span>결제 정보</a> <a><span class="badge ">05</span>결제
					완료</a>
                </div>

                <!--form 태그 시작 -->

                <form action="" method="POST">
                    <div class="row text-center">
                        <article class="col-lg-3 tm-article  m-auto">
                            <h3 class="tm-color-primary tm-article-title-1">결제 상품 </h3>
                            <table class="ticket-tbl container">

                                <tr>
                                    <td><b>총 결제 금액</b></td>
                                    <td>36,000원</td>
                                    
                                </tr>
                            </table>
                        </article>
                        <article class=" col-lg-3 tm-article  m-auto">
                            <h3 class="tm-color-primary tm-article-title-1">결제수단</h3>
                            <p class="box_subtitle">❖ 원하시는 결제수단을 선택해 주세요.</p>
                            <input type="button" class="pay-btn" id="card" name="payCard" value="신용카드"
                                onclick="selectPayType();">
                            <input type="button" class="pay-btn" id="bank" name="payBank" value="계좌이체"
                                onclick="selectPayType();">
                        </article>

                        <article class="col-lg-3  tm-article  m-auto">
                            <h3 class="tm-color-primary tm-article-title-1">결제수단 세부항목</h3>
                            <div class="select-pay" id="card-pay">
                                <p class="box_subtitle">❖ 결제하실 카드사를 선택해 주세요.</p>
                                <select name="pay-card-val" class="card-val" size="1">
                                    <option value="">카드선택</option>
                                    <option value="C">군산카드</option>
                                    <option value="C">국민카드</option>
                                    <option value="C">하나카드</option>
                                    <option value="C">신한카드</option>
                                </select>
                            </div>
                            <div class="select-pay" id="bank-pay">
                                <p class="box_subtitle">❖ 결제하실 은행를 선택해 주세요.</p>
                                <select name="pay-bank-val" class="card-val" size="1">
                                    <option value="">은행선택</option>
                                    <option value="W">군산은행</option>
                                    <option value="W">국민은행</option>
                                    <option value="W">하나은행</option>
                                    <option value="W">신한은행</option>
                                </select>
                            </div>

                        </article>
                        <article class=" col-lg-1">
                            <input type="button" value="결제완료" class="tm-color-white tm-btn-white-bordered" onclick="mallPayment();"/>
                        </article>
                    </div>
                    </form>

            </div>

        </div>
    </section>
    <!-- Event Details Section end -->

<jsp:include page="/WEB-INF/views/common/footer.jsp" />
