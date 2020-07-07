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
public class MenuCategory implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private String menuPrCategory;
	private String menuCdCategory;
	
	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	
}
