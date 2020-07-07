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
public class RecipeComment implements Serializable {

	private static final long serialVersionUID = 1L;

	private int repNo;
	private int recipeNo;
	private String memberId;
	private String questionContent;
	private Date regDate;
	private int highRepNo;
}
