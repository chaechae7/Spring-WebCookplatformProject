package com.soda.onn.recipe.model.vo;

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
public class Report {

	private String repMemberId;
	private int replyNo;
	private Date reportDate;
	private String reportReason;
}
