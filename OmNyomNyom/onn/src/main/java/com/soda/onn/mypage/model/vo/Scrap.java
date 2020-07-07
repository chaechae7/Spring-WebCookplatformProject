package com.soda.onn.mypage.model.vo;

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
public class Scrap implements Serializable {

	private static final long serialVersionUID = 1L;
	
	private int recipeNo; //얘로 레시피 타이틀이랑 쉐프 닉네임 가져올것//기본키 이자 외래키
	private String scrapId; //유저 아이디
	private Date regDate;
	private String meMo;
	private String chefNick;
	private String videoTitle;
	
	public static long getSerialversionuid() {
		return serialVersionUID;
	}
}
