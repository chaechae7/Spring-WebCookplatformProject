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
public class BuyHistory implements Serializable{
	
	private static final long serialVersionUID = 1L;

	private int buyNo;
	private String buyMemberId;
	private int totalPrice;
	private Date buyRegdate;
	private String buyStatus;
	private List<IngredientMall> ingMallList;
	private String shippingAddress;
	private String receiverPhone;
	private String buyEmail;
	private String buyMemberName;
	private String memo;
	private String buyIngredIentName;
	private int buyStock;
}
