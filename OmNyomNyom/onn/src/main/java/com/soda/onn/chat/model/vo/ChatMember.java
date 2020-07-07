package com.soda.onn.chat.model.vo;

import java.io.Serializable;
import java.sql.Date;

import com.soda.onn.member.model.vo.Member;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@ToString(callSuper=true)
public class ChatMember extends Member implements Serializable{

	private static final long serialVersionUID = 1L;
	
	private Long id;
	private ChatRoom chatRoom;
	private long lastCheck;
	private Date chatRegDate;
	private boolean enabled;
	
	public ChatMember(String memberId, ChatRoom chatRoom) {
		this.setMemberId(memberId);
		this.chatRoom = chatRoom;
	}

}