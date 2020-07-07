package com.soda.onn.oneday.model.vo;

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
public class Reservation implements Serializable{

	private static final long serialVersionUID = 1L;

	private int reservationNo; //시퀀스!
	private String reserMemberId; // 예약한 회원아이디!
	private Oneday oneday; //예약한 수를 가져옴
	private String regDate; //예약을 신청한날짜(클래스 수행날짜)!
	private int personnel; // 사람 수!
	private String cancel; //default N (예약)!
	private int resPrice; //결제금액!
	
}
