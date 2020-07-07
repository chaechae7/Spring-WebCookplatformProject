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
public class Notice implements Serializable {

	private static final long serialVersionUID = 1L;
	private int noticeNo;
	private String noticeWriter;
	private String noticeCategory;
	private String noticeTitle;
	private String noticeContent;
	private Date regDate;
	
}
