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
public class BuyItem implements Serializable{
	
	private static final long serialVersionUID = 1L;
	
	private int buyNo;
	private int ingredientNo;
	private int stock;
	private int price;
	
}
