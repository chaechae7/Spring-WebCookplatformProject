package com.soda.onn.chat.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.soda.onn.chat.model.dao.ChatDAO;
import com.soda.onn.chat.model.vo.ChatMember;
import com.soda.onn.chat.model.vo.ChatRoom;
import com.soda.onn.chat.model.vo.Msg;


@Service
public class ChatServiceImpl implements ChatService {

	
	@Autowired
	private ChatDAO chatDAO;

	@Override
	public String findChatIdByMemberId(Map<String, String> map) {
		return chatDAO.findChatIdByMemberId(map);
	}
	
	@Override
	public List<String> findChatIdByMemberId(String memberId) {
		return chatDAO.findChatIdByMemberId(memberId);
	}

	@Override
	public String selectOneChatId(String chatId) {
		return chatDAO.selectOneChatId(chatId);
	}

	@Override
	public int createChatRoom(List<ChatMember> list) {
		int result = 0;
		//chat_room 행 생성
		ChatRoom chatRoom = list.get(0).getChatRoom();//모든 chatMember 같은 ChatRoom객체를 공유함.
		result = chatDAO.insertChatRoom(chatRoom);
		System.out.println("chatRoom------------------------------"+chatRoom);
		
		//chat_member 행 생성
		for(ChatMember chatMember: list){
			result += chatDAO.insertChatMember(chatMember);
		}
		return result;
	}
	
	@Override
	public int updateLastCheck(Msg fromMessage) {
		return chatDAO.updateLastCheck(fromMessage);
	}

	@Override
	public int insertChatLog(Msg fromMessage) {
		//메세지 입력시 lastCheck컬럼값도 갱신
		updateLastCheck(fromMessage);
		return chatDAO.insertChatLog(fromMessage);
	}

	@Override
	public int deleteChatRoom(String chatId) {
		return chatDAO.deleteChatRoom(chatId);
	}

	@Override
	public List<Map<String, String>> findRecentList(String memberId) {
		return chatDAO.findRecentList(memberId);
	}

	@Override
	public List<Msg> findChatListByChatId(String chatId) {
		return chatDAO.findChatListByChatId(chatId);
	}



	
	
	
}
