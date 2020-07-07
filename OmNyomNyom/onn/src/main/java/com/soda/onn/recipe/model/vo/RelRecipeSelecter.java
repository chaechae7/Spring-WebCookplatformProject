package com.soda.onn.recipe.model.vo;

import java.io.Serializable;
import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class RelRecipeSelecter implements Serializable{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private String category;
	private int recipeNo;
	private List<Recipe> relRecipeList;
	
	public static long getSerialversionuid() {
		return serialVersionUID;
	}
}
