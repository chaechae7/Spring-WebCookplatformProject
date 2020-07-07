package com.soda.onn.oneday.model.vo;

import java.io.Serializable;
import java.sql.Date;
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
public class OnedayReview implements Serializable {
	
	private static final long serialVersionUID = 1L;

	private int reviewNo; // 후기 번호
	private String memberId; // 아이디
	private int onedayclassNo;
	private String reviewContent; // 내용
	private String reviewImg; // 이미지
	private Date regDate; // 등록날짜
	private int reviewScore; // 평점
	private String reviewTitle; // 글 제목
}
