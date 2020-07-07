<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:requestEncoding value="utf-8" />

<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="1:1 문의" name="pageTitle" />
</jsp:include>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/1on1_chat.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/mypage/chef-list.css"/>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/mall_delivery_info.css" />
	

<!-- WebSocket:sock.js CDN -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.3.0/sockjs.js"></script>

<!-- WebSocket: stomp.js CDN -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.js"></script>

<div class="container">
	<div class="section">
		<div class="row">
			<c:if test="${memberLoggedIn.memberRoll eq 'A' }">
				<jsp:include page="/WEB-INF/views/common/adminSidenav.jsp">
					<jsp:param value="관리자 정보" name="sidenav"/>
				</jsp:include>
			</c:if>
			<c:if test="${memberLoggedIn.memberRoll ne 'A' }">
				<div class="col-2 side_nav">
					<a href="${pageContext.request.contextPath}/mypage/main"><p class="nav_text ">내 정보보기</p></a>
					<a href="${pageContext.request.contextPath}/mypage/onedayList"><p class="nav_text ">예약목록</p></a>
					<a href="${pageContext.request.contextPath}/mypage/buyList"><p class="nav_text ">구매목록</p></a>
					<a href="${pageContext.request.contextPath}/chat/msg/sims1"><p class="nav_text selected_nav">1:1 문의</p></a>
					<a href="${pageContext.request.contextPath}/mypage/scrapList"><p class="nav_text">스크랩 목록</p></a>
					<a href="${pageContext.request.contextPath}/chef/chefInsert"><p class="nav_text">셰프신청</p></a>
					<a href="${pageContext.request.contextPath}/mypage/dingdongList"><p class="nav_text">알림목록</p></a>
				</div>
			</c:if>
			<div class="col-2 side_nav">
				<c:forEach items="${recentList }" var="msg">
				<div class="chat_thumbnail_box">
					<a href="${pageContext.request.contextPath}/chat/msg/${msg.memberId}"><p>
					<c:choose>
						<c:when test='${msg.memberId eq "sdmin" }'>
							<img src="${pageContext.request.contextPath}/resources/upload/profile/sdmin.jpg" alt="" class="chat_thumbnail" />
						</c:when>
						<c:otherwise>
							<img src="${pageContext.request.contextPath}/resources/upload/profile/${msg.prevImg}" alt="" class="chat_thumbnail"/>
						</c:otherwise>
					</c:choose>
					<br />	
					${msg.memberNick }
					</p></a>
				</div>
				</c:forEach>				
			</div>
				

		<!-- 1:1문의 채팅 start -->
		<!-- partial:index.partial.html -->
		<div class="chat_container clearfix">
		
		
			<div class="chat">
				<div class="chat-header clearfix">
					<c:if test="${memberLoggedIn.memberRoll eq 'A' }">
					<img
						src="${pageContext.request.contextPath }/resources/upload/profile/${chef.chefProfile}"
						class="chat_thumbnail"
						style="width: 55px"
						onerror='this.src="${pageContext.request.contextPath }/resources/images/member_default.png"'/>
					</c:if>
					<c:if test="${memberLoggedIn.memberRoll ne 'A' }">
					<img
						src="${pageContext.request.contextPath }/resources/upload/profile/${chef.chefProfile}"
						class="chat_thumbnail"
						style="width: 55px"
						onerror='this.src="${pageContext.request.contextPath }/resources/images/member_default.png"'/>
					</c:if>
						
		
					<div class="chat-about">
						<div class="chat-with">${chef.chefNickName ne chef.chefNickName }</div>
						<div class="chat-num-messages" ><span id="msg-count">${fn:length(chatList)}</span> Message</div>
					</div>
					<!-- <i class="fa fa-star"></i> -->
				</div>
				<!-- end chat-header -->
		
				<div class="chat-history">
					<ul id="msg-target">
						<c:forEach items="${chatList }" var="chat" >
							<c:if test="${chat.memberId eq memberLoggedIn.memberId }">
								<li class="clearfix">
									<div class="message-data align-right">
										<span class="message-data-time">${chat.time }</span> 
				
									</div>
									<div class="message other-message float-right">${chat.msg }</div>
								</li>
							
							</c:if>				
							<c:if test="${chat.memberId ne memberLoggedIn.memberId }">
								<li>
									<div class="message-data">
										<span class="message-data-name"><i
											class="fa fa-circle online"></i> ${chat.memberNick }</span> <span
											class="message-data-time">${chat.time }</span>
									</div>
									<div class="message my-message">${chat.msg }</div>
								</li>
							
							</c:if>				
						
						</c:forEach>
		
		
		
					</ul>
		
				</div>
				<!-- end chat-history -->
		
				<div class="chat-message clearfix">
					<textarea name="message-to-send" id="message-to-send" placeholder="Type your message" rows="3"></textarea>
		
					<i class="fa fa-file-o"></i> &nbsp;&nbsp;&nbsp; <i
						class="fa fa-file-image-o"></i>
		
					<button id="sendBtn">Send</button>
		
				</div>
				<!-- end chat-message -->
		
			</div>
			<!-- end chat -->
		
		</div>
	</div>
	</div>

</div>		
<!-- end container -->
<!-- partial -->
<script src='https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/3.0.0/handlebars.min.js'></script>
<script src='https://cdnjs.cloudflare.com/ajax/libs/list.js/1.1.1/list.min.js'></script>


        
        

        <!-- <div class="credits"><a href="https://codepen.io/clintioo/pen/HAkjq">Original Pen</a> by <a href="https://codepen.io/clintioo/pen/HAkjq">clintioo</a></div> -->
    <!-- 1:1문의 채팅 end -->



    <script src="${pageContext.request.contextPath}/resources/js/datepicker.min.js"></script>
<!-- Include English language -->
<script
	src="${pageContext.request.contextPath}/resources/js/datepicker.kr.js"></script>
<script>
	(function() {
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
		[].slice.call( document.querySelectorAll( 'input.input__field' ) ).forEach( function( inputEl ) {
			// in case the input is already filled..
			if( inputEl.value.trim() !== '' ) {
				classie.add( inputEl.parentNode, 'input--filled' );
			}
			// events:
			inputEl.addEventListener( 'focus', onInputFocus );
			inputEl.addEventListener( 'blur', onInputBlur );
		} );
		function onInputFocus( ev ) {
			classie.add( ev.target.parentNode, 'input--filled' );
		}
		function onInputBlur( ev ) {
			if( ev.target.value.trim() === '' ) {
				classie.remove( ev.target.parentNode, 'input--filled' );
			}
		}
	})();

</script>


<!-- 사용자 chat관련 script -->
<script src="${pageContext.request.contextPath }/resources/js/chat.js"></script>


<script>
const memberId = '${memberLoggedIn.memberId}';
const chatId = '${chatId}';

//웹소켓 선언 및 연결
//1.최초 웹소켓 생성 url: /onn
let socket = new SockJS('<c:url value="/chat" />');
let chatClient = Stomp.over(socket);

chatClient.connect();

/**
 * 각 페이지에서 작성하면, chat.js의 onload함수에서 호출함.
* chat페이지에서 추가적으로 subscripe 한다.
* 웹소켓 connection이 맺어지기 전 요청을 방지하기 위해 stompClient.connected를 체크한다.
* connectionDone 으로 구독요청 완료를 체크해서 1초마다 반복적으로 구독요청한다.
*/
function chatSubscribe(){
	//페이지별로 구독신청 처리
	let iii = 1;
	let connectionDone = false;
	let intervalId = setInterval(()=>{
		if(connectionDone == true)
			clearInterval(intervalId);
		
		if(connectionDone==false && chatClient.connected){
			
			//stomp에서는 구독개념으로 세션을 관리한다. 핸들러 메소드의 @SendTo어노테이션과 상응한다.
			chatClient.subscribe('/chat/'+chatId, function(message) {
				
				let messsageBody = JSON.parse(message.body);
				let nick = messsageBody.memberNick == null?'심관리자':messsageBody.memberNick;
				if(iii%2 != 0){
				if(memberId == messsageBody.memberId){
				    $("#msg-target").append(''
						+'<li class="clearfix">'
						+'<div class="message-data align-right">'
						+'<span class="message-data-time">'+dateTransform(messsageBody.time)+'</span>'
						+'</div> <div class="message other-message float-right">'+messsageBody.msg+'</div>'
						+'</li>'); 
				}else{
				    $("#msg-target").append(''
						+'<li>'
						+'<div class="message-data">'
						+'<span class="message-data-name"><i class="fa fa-circle online"></i>'+nick+'</span>'
						+'<span class="message-data-time">'+dateTransform(messsageBody.time)+'</span>'
						+'</div> <div class="message my-message">'+messsageBody.msg+'</div>'
						+'</li>'); 
				}
				scrollTop();
				$("#msg-count").text(Number($("#msg-count").text())+1);
				}
				iii++;
			});
			connectionDone = true;
		}	
	},1000);
}

function dateTransform(time){
	
	var now = new Date(Number(time));
	var hour = now.getHours();
	
	return now.getMonth() + 1 + "월 "+ now.getDate()+"일("+['일','월','화','수','목','금','토','일'][now.getDay()]+") " + (hour>=12?"오후 ":"오전 ") + hour%12+"시 "+now.getMinutes()+"분";
}
</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp" />