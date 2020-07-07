package com.soda.onn.oneday.model.vo;

import java.io.Serializable;
import java.util.Date;

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
public class OnedayTime implements Serializable {
	
	private static final long serialVersionUID = 1L;
	
	private int onedayTimeNo;
	private int onedayNoo;
	private Oneday oneday; //예약할때 사용.
	private String onedayTimeDate; 
	
	
	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	
	
	
	
}


