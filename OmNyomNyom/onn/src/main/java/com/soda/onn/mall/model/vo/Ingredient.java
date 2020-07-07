package com.soda.onn.mall.model.vo;

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
public class Ingredient implements Serializable {

	private static final long serialVersionUID = 1L;

	private int ingredientNo;
	private String ingPrCategory;
	private String ingCdCategory;
	private String engPrCategory;
	private String engCdCategory;
	private String ingredientName;
	private String ingFilename;
}
