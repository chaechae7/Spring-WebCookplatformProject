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
public class Member implements Serializable {

	private static final long serialVersionUID = 1L;

	private String memberId;
	private String memberPwd;
	private String memberNick;
	private String memberName;
	private String phone;
	private String email;
	private String ssn;
	private String memberRoll;
	private Date regDate;
	private String address;
	
}
