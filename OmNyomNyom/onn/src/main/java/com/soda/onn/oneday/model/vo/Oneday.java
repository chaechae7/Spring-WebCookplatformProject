package com.soda.onn.oneday.model.vo;

import java.io.Serializable;
import java.util.List;

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
public class Oneday  implements Serializable{
	 
	private static final long serialVersionUID = 1L;

	private int onedayclassNo; //시퀀스
	private String memberId;
	private String onedayName; // 원데이 클래스명 !
	private int onedayPrice; //가격
	private String onedayContent;
	private double latitude; //위도
	private double longitude; //경도
	private String addr;
	private String detailedAddr; //상세주소 !
	private int onedayTime; //소요시간 => 시간 
	private int onedayMaxper;
	private int onedayMinper;
	private String onedayImg; //사진 파일명
	private String menuList;
	
	private List<OnedayTime> onedayTimeList; // 일정 !
	
}
