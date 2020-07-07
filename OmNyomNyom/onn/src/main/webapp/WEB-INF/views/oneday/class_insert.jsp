
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:requestEncoding value="utf-8" />
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="원데이 클래스 등록" name="pageTitle" />
</jsp:include>

<!-- css -->
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/class_insert.css" />

<link href="${pageContext.request.contextPath }/resources/css/datepicker.min.css" rel="stylesheet" type="text/css">
<!-- 스크립트 -->

<script src="${pageContext.request.contextPath }/resources/js/datepicker.min.js"></script>
<script src="${pageContext.request.contextPath }/resources/js/datepicker.kr.js"></script>
<script src="${pageContext.request.contextPath }/resources/js/class_insert.js"></script>
<script src="${pageContext.request.contextPath }/resources/js/classie.js"></script>
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="//cdn.ckeditor.com/4.14.0/full/ckeditor.js"></script>

<!-- Event Details Section -->

<section class="event-details-section spad overflow-hidden">
	<div class="container">
		<form action="insert.do" method="post" enctype="multipart/form-data">
		<!-- 셰프채널 = memberId, Nickname 입력란-->
		<input type="text" id="input-class-channel" name="memberId" value="${memberLoggedIn.memberId }" hidden/> 
		<input type="text" id="input-class-channel" name="memberNickname" value="${memberLoggedIn.memberNick }" hidden/> 
			<div class="row">
				<div class="col-lg-7">
					<!-- 이미지 등록 -->
					<div class="oneday_class_img">
						<div id="uploadbtn" onclick="upload(this)">Upload Files</div>
						<input type='file' id="imgInput" name="onedayImgFile" hidden /> <img src="#" alt="" id="image_section">
					</div>

					<!-- ck에디터 -->
					<div class="event-details w-100">
						<textarea id="onedayContent" name="onedayContent"></textarea>
					</div>

				</div>

				<!-- 사이드부분 -->
				<div class="col-lg-5 col-md-5 col-sm-8 sidebar">
					<div class="sb-widget">
						<div class="classes-info">

							<!-- 클래스 명 입력란 -->
							<span class="input input--yoshiko"> 
							<!-- 클래스명 input --> 
							<input class="input__field input__field--yoshiko" type="text" id="input-class-name" name="onedayName"/> 
							<!-- 클래스명 라벨 --> 
							<label class="input__label input__label--yoshiko" for="input-class-name"> 
							<span class="input__label-content input__label-content--yoshiko" data-content="클래스명">클래스명</span>
							</label>
							</span>
								
							<!-- 메뉴 입력란 -->
							<span class="input input--yoshiko"> 
							<!-- 클래스명 input --> 
							<input class="input__field input__field--yoshiko" type="text" id="input-menu-name" name="menuList"/> 
							<!-- 클래스명 라벨 --> 
							<label class="input__label input__label--yoshiko" for="input-menu-name"> 
							<span class="input__label-content input__label-content--yoshiko" data-content="메뉴명">메뉴명</span>
							</label>
							</span>
							<!-- 클래스 비용 입력란 -->
							<span class="input input--yoshiko"> <!-- 클래스 비용 input -->
								<input class="input__field input__field--yoshiko" type="number" step="1000" min="1000"  id="input-class-cost" name="onedayPrice"/> 
								<!-- 클래스 비용 라벨 --> 
								<label class="input__label input__label--yoshiko" for="input-class-cost"> 
								<span class="input__label-content input__label-content--yoshiko" data-content="클래스 비용">클래스 비용</span>
							</label>
							</span>
							
							<!-- 클래스 소요시간 입력란 -->
							<div class="row m-auto">
								<div class="col-4 px-0 py-3 input">
									<h5 class="insert-title">클래스 소요시간</h5>
								</div>
								<!-- 시간 입력란 -->
								<span class="input input--yoshiko col px-1"> <!-- 시간 input -->
									<input class="input__field input__field--yoshiko" type="number"
									id="input-class-time-h" name="onedayTime" min="0" autocomplete="off" /> 
									<!-- 시간 라벨 -->
									<label class="input__label input__label--yoshiko" for="input-class-time-h"> 
									<span class="input__label-content input__label-content--yoshiko" data-content="시간">시간</span>
								</label>
								</span>
								<!-- 분 입력란 -->
								<span class="input input--yoshiko col pr-0"> 
								<!-- 분 input -->
								<input class="input__field input__field--yoshiko" type="number" id="input-class-time-m" name="onedayTimeM" min="0" max="59" autocomplete="off" />
									<!-- 분 라벨 --> 
								<label class="input__label input__label--yoshiko" for="input-class-time-m"> 
								<span class="input__label-content input__label-content--yoshiko" data-content="분">분</span>
								</label>
								</span>
							</div>
							<!-- 클래스 소요시간 입력란 end -->

							<div class="row">
								<!-- 최대 정원 인원 입력란 -->
								<span class="input input--yoshiko col"> <!-- 최대 정원 인원 input -->
									<input class="input__field input__field--yoshiko" type="number" id="input-class-max" name="onedayMaxper" min="0" max="100" autocomplete="off" /> 
									<!-- 정원 인원 라벨 -->
									<label class="input__label input__label--yoshiko" for="input-class-max"> 
									<span class="input__label-content input__label-content--yoshiko" data-content="정원 인원">정원 인원</span>
								</label>
								</span>
								<!-- 최소 인원 입력란 -->
								<span class="input input--yoshiko col"> <!-- 최소 인원 input -->
									<input class="input__field input__field--yoshiko" type="number" id="input-class-min" name="onedayMinper" min="0" max="100" autocomplete="off" /> 
									<!-- 최소 인원 라벨 -->
									<label class="input__label input__label--yoshiko" for="input-class-min"> 
									<span class="input__label-content input__label-content--yoshiko" data-content="최소 인원">최소 인원</span>
								</label>
								</span>
							</div>
							<!-- 클래스 주소 입력란 -->
							<!-- 클래스 주소 input -->
							<span class="input input--yoshiko"> 
							<p>도로명/지번 주소</p>
							
								<input class="input__field input__field--yoshiko" type="text"
								id="sample6_address" name="addr" onclick="sample6_execDaumPostcode()" required="required" readonly="readonly"/> 
								<!-- 클래스 주소 라벨 --> 
								<label class="input__label input__label--yoshiko" for="input-class-adress"> 
								<span class="input__label-content input__label-content--yoshiko" data-content=""></span>	
							</label>
							</span>
							<!-- 주소 -->
							<input type="text" id="sample6_postcode" placeholder="우편번호" hidden/>
							<input type="text" id="sample6_extraAddress" placeholder="참고항목" hidden/>
							<span class="input input--yoshiko"> <!-- 클래스 주소 input -->
								<input class="input__field input__field--yoshiko" type="text" id="sample6_detailAddress" name="detailedAddr" required="required"/> 
								<!-- 클래스 주소 라벨 --> 
								<label class="input__label input__label--yoshiko" for="input-class-adress"> 
								<span class="input__label-content input__label-content--yoshiko" data-content="상세 주소">상세주소</span>
									
							</label>
							</span>
							
							<script>
    
							function sample6_execDaumPostcode() {
						        new daum.Postcode({
						            oncomplete: function(data) {
						                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

						                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
						                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
						                var addr = ''; // 주소 변수
						                var extraAddr = ''; // 참고항목 변수

						                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
						                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
						                    addr = data.roadAddress;
						                } else { // 사용자가 지번 주소를 선택했을 경우(J)
						                    addr = data.jibunAddress;
						                }

						                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
						                if(data.userSelectedType === 'R'){
						                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
						                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
						                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
						                        extraAddr += data.bname;
						                    }
						                    // 건물명이 있고, 공동주택일 경우 추가한다.
						                    if(data.buildingName !== '' && data.apartment === 'Y'){
						                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
						                    }
						                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
						                    if(extraAddr !== ''){
						                        extraAddr = ' (' + extraAddr + ')';
						                    }
						                    // 조합된 참고항목을 해당 필드에 넣는다.
						                    document.getElementById("sample6_extraAddress").value = extraAddr;
						                
						                } else {
						                    document.getElementById("sample6_extraAddress").value = '';
						                }

						                // 우편번호와 주소 정보를 해당 필드에 넣는다.
						                document.getElementById('sample6_postcode').value = data.zonecode;
						                document.getElementById("sample6_address").value = addr;
						                // 커서를 상세주소 필드로 이동한다.
						                document.getElementById("sample6_detailAddress").focus();
						            }
						        }).open();
						    }
						</script>
							<h5 class="insert-title">클래스 날짜</h5>
							<!-- 클래스 날짜 입력란 -->
							<div class="row m-auto">
								<span class="input input--yoshiko col-9 p-0"> <!-- 클래스 날짜 input -->
									<input
									class="input__field input__field--yoshiko datepicker-here"
									type="text" id="input-date" data-language='kr' data-date-format='yyyy/mm/dd' data-time-format='hh:ii'
									data-timepicker="true" autocomplete="off" />
								</span>

								<div class="col py-1 pr-0 input">
									<!-- 클래스 날ㅉ 버튼 -->
									<button class="site-btn sb-gradient px-3"
										style="min-width: 100%;" type="button"
										onclick="addClassTime();">추가</button>
								</div>
							</div>
							<!-- 클래스 날짜 리스트 div -->
							<div id="input-date-list" name="classDateList"></div>
						</div>
					</div>
					<div class="sb-widget col py-1 pr-0 input">
						<!-- 위도/경도 더미 값 -->
						<input type="number" name="latitude" value="150" hidden/><input type="number" name="longitude" value="150" hidden/>
						<!-- 클래스 등록 버튼 -->
						<input type="submit" class="site-btn sb-gradient px-3 reservation_class" value="등록하기"></input>
					</div>
				</div>
			</div>
		</form>
	</div>
</section>


<!-- Event Details Section end -->

<jsp:include page="/WEB-INF/views/common/footer.jsp" />
