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
public class IngredientMall implements Serializable {

	private static final long serialVersionUID = 1L;

	private int ingMallNo;
	private String ingMallName;
	private String prevImg;
	private int price;
	private int stock;
	private String minUnit;
	private String ingOrigin;
	private int shelfLife;
	private String ingInfo;
	private String mallEngPrCategory;
	private String mallEngCdCategory;

}
