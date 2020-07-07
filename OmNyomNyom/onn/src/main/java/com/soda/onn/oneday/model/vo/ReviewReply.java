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
public class ReviewReply  implements Serializable{
	
	private static final long serialVersionUID = 1L;

	private int reviewRepNo;
	private String memberId;
	private String reviewRepContent;
	private Date regDate;
}
