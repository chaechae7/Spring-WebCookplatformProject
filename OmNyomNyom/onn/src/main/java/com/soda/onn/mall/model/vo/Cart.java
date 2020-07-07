package com.soda.onn.mall.model.vo;

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
public class Cart  extends IngredientMall implements Serializable{
	private static final long serialVersionUID = 1L;

	private int sbIngNo;
	private String sbMemberId;
	private int sbStock;
	
	public Cart(int ingMallNo, String ingMallName, String prevImg, int price, int stock, String minUnit,
			String ingOrigin, int shelfLife, String ingInfo, String mallEngPrCategory, String mallEngCdCategory,
			int sbIngNo, String sbMemberId, int sbStock) {
		super(ingMallNo, ingMallName, prevImg, price, stock, minUnit, ingOrigin, shelfLife, ingInfo, mallEngPrCategory,
				mallEngCdCategory);
		this.sbIngNo = sbIngNo;
		this.sbMemberId = sbMemberId;
		this.sbStock = sbStock;
	}

	
}
