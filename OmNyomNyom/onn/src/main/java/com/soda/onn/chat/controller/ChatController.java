package com.soda.onn.chat.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.handler.annotation.DestinationVariable;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;
import com.soda.onn.chat.model.service.ChatService;
import com.soda.onn.chat.model.vo.ChatMember;
import com.soda.onn.chat.model.vo.ChatRoom;
import com.soda.onn.chat.model.vo.Msg;
import com.soda.onn.chef.model.service.ChefService;
import com.soda.onn.chef.model.vo.Chef;
import com.soda.onn.member.model.vo.Member;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/chat")
public class ChatController {

	@Autowired
	private ChatService chatService;
	
	@Autowired
	private ChefService chefService;
	
	
	//메세지 
	@GetMapping("/msg/{getter}")
	public String msg(Model model, 
			 		  HttpSession session,
			 		  @PathVariable(value = "getter") String getter){
		String memberId = ((Member)session.getAttribute("memberLoggedIn")).getMemberId();
		Map<String,String> map = new HashMap<>();
		map.put("memberId", memberId);
		map.put("getter", getter);
		
		String chatId = chatService.findChatIdByMemberId(map);
	
		if(chatId == null) {
			chatId = createChatId(20);
			
			ChatRoom chatRoom = new ChatRoom(chatId);
			List<ChatMember> list = new ArrayList<>();
			list.add(new ChatMember(memberId, chatRoom));
			list.add(new ChatMember(getter, chatRoom));
			
			//chat_room, chat_member테이블에 데이터 생성
			chatService.createChatRoom(list);
		}
		//chatId가 존재하는 경우, 채팅내역 조회
		else{
			//채팅내역
			List<Msg> chatList = chatService.findChatListByChatId(chatId);
			model.addAttribute("chatList",chatList);
		}
		
		Chef chef = chefService.chefSelectId(getter);
		model.addAttribute("chef", chef);
		
		//최근 사용자 채팅메세지 목록
		List<Map<String, String>> recentList = chatService.findRecentList(memberId);
		model.addAttribute("recentList", recentList);
		
		model.addAttribute("chatId", chatId);
		
		return "mypage/directMsg";
	}
	
	@GetMapping("/main")
	public String list(){
		return "redirect:/chat/msg/sdmin";
	}
	
	
	/**
	 * 인자로 전달될 길이의 임의의 문자열을 생성하는 메소드
	 * 영대소문자/숫자의 혼합.
	 * 
	 * @param len
	 * @return
	 */
	private String createChatId(int len){
		Random rnd = new Random();
		StringBuffer buf = new StringBuffer();
		String prefix = "chat";
		
		do {
			buf.setLength(0);//buf 비우기 
			buf.append(prefix);
			for(int i=0; i<len-prefix.length(); i++){
				//임의의 참거짓에 따라 참=>영대소문자, 거짓=> 숫자
				switch(rnd.nextInt(3)) {
				case 0: buf.append((char)(rnd.nextInt(26)+65)); break;
				case 1: buf.append((char)(rnd.nextInt(26)+97)); break;
				case 2: buf.append((rnd.nextInt(10))); break;
				}
			}
		//중복여부 검사
		} while(chatService.selectOneChatId(buf.toString()) != null);
		log.info("chatId가 생성되었음 [{}]",buf.toString());
		
		return buf.toString();
	}	
	
	@MessageMapping("/chat/{chatId}")
	@SendTo("/chat/{chatId}")
	public Msg sendEcho(Msg fromMessage, 
						@DestinationVariable String chatId){
		//db에 메세지로그
		chatService.insertChatLog(fromMessage);

		return fromMessage; 
	}

	@MessageMapping("/lastCheck")
	public Msg lastCheck(@RequestBody Msg fromMessage){
		log.debug("lastCheck={}",fromMessage);
		
		//db에 채팅방별 사용자 최종확인 시각을 갱신한다.
		chatService.updateLastCheck(fromMessage);
		
		return fromMessage; 
	}
	
	
	
}
