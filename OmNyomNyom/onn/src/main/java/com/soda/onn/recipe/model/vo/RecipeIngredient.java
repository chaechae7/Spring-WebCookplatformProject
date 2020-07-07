package com.soda.onn.recipe.model.vo;

import java.io.Serializable;

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
public class RecipeIngredient implements Serializable {
	
	
	private static final long serialVersionUID = 1L;

	private int ingredientNo;
	private String minWeight;
	private String ingredientName;
	private int recipeNo;
}
