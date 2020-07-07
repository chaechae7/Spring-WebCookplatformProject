package com.soda.onn.recipe.model.vo;

import java.io.Serializable;

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
public class Like implements Serializable{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private String memberId;
	private int recipeNo;
	
	public static long getSerialversionuid() {
		return serialVersionUID;
	}
}
