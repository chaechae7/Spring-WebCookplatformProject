package com.soda.onn.member.model.vo;

import java.io.Serializable;
import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Setter
@Getter
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class QnAMsg  implements Serializable{
	
	private static final long serialVersionUID = 1L;

	private String sender;
	private String receiver;
	private String qnaMsg;
	private Date regDate;
}
