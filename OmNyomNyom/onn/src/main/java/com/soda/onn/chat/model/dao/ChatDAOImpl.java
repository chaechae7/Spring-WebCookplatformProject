package com.soda.onn.chat.model.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.soda.onn.chat.model.vo.ChatMember;
import com.soda.onn.chat.model.vo.ChatRoom;
import com.soda.onn.chat.model.vo.Msg;

@Repository
public class ChatDAOImpl implements ChatDAO {

	@Autowired
	private SqlSessionTemplate sqlSession;

	@Override
	public String findChatIdByMemberId(Map<String, String> map) {
		return sqlSession.selectOne("chat.findChatIdByMemberId", map);
	}
	
	@Override
	public List<String> findChatIdByMemberId(String memberId) {
//		return sqlSession.selectOne("chat.findChatIdByMemberId", memberId);
		return null;
	}

	@Override
	public String selectOneChatId(String chatId) {
		return sqlSession.selectOne("chat.selectOneChatId", chatId);
	}
	
	@Override
	public int insertChatRoom(ChatRoom chatRoom) {
		return sqlSession.insert("chat.insertChatRoom", chatRoom);
	}
	
	@Override
	public int insertChatMember(ChatMember chatMember) {
		return sqlSession.insert("chat.insertChatMember", chatMember);
	}

	@Override
	public int updateLastCheck(Msg fromMessage) {
		return sqlSession.update("chat.updateLastCheck", fromMessage);	
	}

	@Override
	public int insertChatLog(Msg fromMessage) {
		return sqlSession.insert("chat.insertChatLog", fromMessage);
	}

	@Override
	public int deleteChatRoom(String chatId) {
		return sqlSession.update("chat.deleteChatRoom", chatId);
	}

	@Override
	public List<Map<String, String>> findRecentList(String memberId) {
		return sqlSession.selectList("chat.findRecentList",memberId);
	}

	@Override
	public List<Msg> findChatListByChatId(String chatId) {
		return sqlSession.selectList("chat.findChatListByChatId", chatId);
	}

	

}
