package com.soda.onn.chat.model.dao;

import java.util.List;
import java.util.Map;

import com.soda.onn.chat.model.vo.ChatMember;
import com.soda.onn.chat.model.vo.ChatRoom;
import com.soda.onn.chat.model.vo.Msg;

public interface ChatDAO {

	String findChatIdByMemberId(Map<String, String> map);
	
	List<String> findChatIdByMemberId(String memberId);

	String selectOneChatId(String chatId);

	int insertChatRoom(ChatRoom chatRoom);
	
	int insertChatMember(ChatMember chatMember);

	int insertChatLog(Msg fromMessage);

	int deleteChatRoom(String chatId);

	int updateLastCheck(Msg fromMessage);

	//관리자용
	List<Map<String, String>> findRecentList(String memberId);

	List<Msg> findChatListByChatId(String chatId);




}

