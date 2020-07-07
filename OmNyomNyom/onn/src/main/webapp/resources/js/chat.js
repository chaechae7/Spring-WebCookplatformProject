//jQuery Load 이후 실행할것!

///////////////////////////// ONLOAD START///////////////////////////// 
$(function() {
	$(".message-data-time").each(function(){
		$(this).text(dateTransform($(this).text()));
	});
	//chat관련 구독신청 : /chat/chatId
	chatSubscribe();
	
	//메세지 전송 관련
	$("#sendBtn").on("click",function() {
		sendMessage();
	});
	$("#message-to-send").keydown(function(key) {
		if (key.keyCode == 13) {// 엔터
			sendMessage();
		}
	});
	
	//채팅로그 최하단 보기
	scrollTop();
	
	//lastCheck 마지막 확인검사용
	//window focus이벤트핸들러 등록
	$(window).on("focus", function() {
		lastCheck();
	});
	
});
///////////////////////////// ONLOAD END/////////////////////////////

///////////////////////////// FUNCTION START/////////////////////////////


/**
 * 지정한 url로 stomp 메세지 전송
 * @returns
 */
function sendMessage() {
	let message = $("#message-to-send").val().trim("");
	console.log(message);
	if(message.length < 1)
		return;
	let data = {
		chatId : chatId,
		memberId : memberId,
		msg : message,
		time : Date.now(),
		type: "MESSAGE"
	}
	
	//전역변수 stompClient를 통해 메세지 전송 
	chatClient.send(`/onn/chat/${chatId}`, {}, JSON.stringify(data));

	message = '';
	//message창 초기화
	$('#message-to-send').val(message);
}


/**
 * 스크롤 처리
 */
function scrollTop(){
	//스크롤처리
    $('.chat-history').scrollTop($(".chat-history").prop('scrollHeight'));
}


/**
 *
 * 윈도우가 활성화 되었을때, chatroom테이블의 lastcheck(number)컬럼을 갱신한다.
 * 안읽은 메세지 읽음 처리
 * 
 */
function lastCheck() {
	
	let data = {
		chatId : chatId,
		memberId : memberId,
		time : Date.now(),
		type: "LASTCHECK"
	}
	
	//전역변수 stompClient를 통해 lastCheck 메세지 전송
	chatClient.send('/onn/lastCheck', {}, JSON.stringify(data));
}

///////////////////////////// FUNCTION END/////////////////////////////