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
public class RecipeQuestion implements Serializable {

	private static final long serialVersionUID = 1L;

	private int questionNo;
	private int recipeNo;
	private String memberId;
	private int highQuestionNo;
	private String questionContent;
	private Date regDate;
	private String memberNick;
}
