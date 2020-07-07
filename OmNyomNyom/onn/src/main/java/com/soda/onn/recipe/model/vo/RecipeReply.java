package com.soda.onn.recipe.model.vo;

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
public class RecipeReply implements Serializable {
	
	private static final long serialVersionUID = 1L;

	private int replyNo;
	private int recipeNo;
	private String memberId;
	private String memberNick;
	private String repContent;
	private Date regDate;
	private int highRepNo;
}
