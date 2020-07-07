<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:requestEncoding value="utf-8"/>
<jsp:include page="/WEB-INF/views/common/header.jsp"> 
<jsp:param value="안녕 옴뇸뇸!" name="pageTitle"/>
</jsp:include>


<!-- reservation css  -->
 <link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/class_reservation.css" />
 <!--  달력 css-->
 <link href="${pageContext.request.contextPath }/resources/css/datepicker.min.css" rel="stylesheet" type="text/css">

 <!-- 인원증감  -->
    <script>
        $(function() {
            $('.btn-number').click(function(e) {
                e.preventDefault();
                fieldName = $(this).attr('data-field');
                type = $(this).attr('data-type');
                var input = $("input[name='" + fieldName + "']");
                var currentVal = parseInt(input.val());
                if (!isNaN(currentVal)) {
                    if (type == 'minus') {

                        if (currentVal > input.attr('min')) {
                            input.val(currentVal - 1).change();
                        }
                        if (parseInt(input.val()) == input.attr('min')) {
                            $(this).attr('disabled', true);
                        }

                    } else if (type == 'plus') {

                        if (currentVal < input.attr('max')) {
                            input.val(currentVal + 1).change();
                        }
                        if (parseInt(input.val()) == input.attr('max')) {
                            $(this).attr('disabled', true);
                        }

                    }
                } else {
                    input.val(0);
                }
            });
            $('.input-number').focusin(function() {
                $(this).data('oldValue', $(this).val());
            });
            $('.input-number').change(function() {

                minValue = parseInt($(this).attr('min'));
                maxValue = parseInt($(this).attr('max'));
                valueCurrent = parseInt($(this).val());

                name = $(this).attr('name');
                if (valueCurrent >= minValue) {
                    $(".btn-number[data-type='minus'][data-field='" + name + "']").removeAttr('disabled')
                } else {
                    alert('Sorry, the minimum value was reached');
                    $(this).val($(this).data('oldValue'));
                }
                if (valueCurrent <= maxValue) {
                    $(".btn-number[data-type='plus'][data-field='" + name + "']").removeAttr('disabled')
                } else {
                    alert('Sorry, the maximum value was reached');
                    $(this).val($(this).data('oldValue'));
                }
            });

        });
    </script>
    
    
    <!-- Event Details Section -->
    <section class="event-details-section spad overflow-hidden">
        <div class="tm-section-2">
            <div class="container">
                <div class="row">
                    <div class="col text-center">
                        <h2 class="tm-section-title">원데이클래스</h2>
                        <p class="tm-color-white tm-section-subtitle">당신만의 특별한 경험을 응원합니다. </p>
                    </div>
                </div>
            </div>
           
        </div>



        <div class="tm-section tm-position-relative">
	 <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100" preserveAspectRatio="none" class="tm-section-down-arrow">
                <polygon fill="#4949e7" points="0,0  100,0  50,60"></polygon>
            </svg>
            <div class="container tm-pt-5 tm-pb-4">
                <div class="wizard">
                    <a class="current badge-inverse"><span class="badge">01</span> 클래스 예약</a> <a><span class="badge">02</span>
                        예약 정보동의</a> <a><span class="badge ">03</span>
                        예약 결제</a> <a><span class="badge ">04</span>결제 완료</a>
                </div>

                <!--form 태그 시작 -->

                
                    <div class="row text-center">
                        <article class="col-xl-4 tm-article" id="infoView">
                            <h3 class="tm-color-primary tm-article-title-1">클래스 소개</h3>
                            <img src="${pageContext.request.contextPath}/resources/upload/onedayclass/${one.onedayImg}" alt="클래스 이미지">
                        </article>


                        <article class=" col-xl-2.5 tm-article" name="dateTimeView">
                            <h3 class="tm-color-primary tm-article-title-1"> 날짜</h3>
                            <h4 id="date_hidden" style="display: none;">${reservationrequest.regDate}</h4>
                            
							
                            
                            <h4 id="date"></h4>
                            <p id="time-title" class="box_subtitle">❖ 선택하신 시간을 확인해 주세요.</p>
							
							<h4 id="time"></h4>
                           
							<script>
							
									var t = $("#date_hidden").text();
									var d = t.split(' ');
									
									$("#date").text(d[0]);
									$("#time").text(d[1]);
						
							</script>

                        </article>
                        <article class="col-xl-2.5  tm-article">

                            <h2 class="tm-color-primary tm-article-title-1">${reservationrequest.personnel}명</h2>

                            <article class="col-xl-2.5  tm-article">
                                

                               <h3>${reservationrequest.resPrice}원</h3>
                            </article>

                        </article>
                        <input type="hidden" name="idx" value="0" />
                        <input type="hidden" name="tour_info_id" value="TA60006" />
                        <input type="hidden" name="time" value="00:00" />
                        <input type="hidden" name="date" value="" />
                        <input type="hidden" name="member_no" value="gn200217_0003" />
                        <input type="hidden" name="childPrice" value="75000" />
                        <input type="hidden" name="adultPrice" value="50000" />
               
                <article class=" col-xl-1.5">
                    <a href="${pageContext.request.contextPath }/oneday/oneday_detail?onedayclassNo=${reservationrequest.onedayclassNo}" class="tm-color-white tm-btn-white-bordered">이전</a>
                    <a href="${pageContext.request.contextPath }/oneday/oneday_agree" class="tm-color-white tm-btn-white-bordered">다음</a>
                </article>
                </div>

            </div>
    </section>
    <!-- Event Details Section end -->
    
    <script>
    function countChange(b){
        $count = $("#count");
        let cnum = Number($count.val())+Number(b);
        if(cnum<=0){
            $count.text(1);
            cnum = 1;
        }
        $count.val(cnum);
        let price = $("#price").text()
        price = price.replace(/\,/g,"");
        let ppap = Number(price)*cnum;
        $("#total_price").text(String(ppap).replace(/\B(?=(\d{3})+(?!\d))/g, ","));
/*          $("#total_price").text(Number(price)*cnum); */
    }
    
    $("#countup").on("click",function(){
        countChange(1);
    });
    $("#countdown").on("click",function(){
        countChange(-1);
    });
    $("#count").on("keyup",function(){
        countChange(0);
    });
    </script>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />
    