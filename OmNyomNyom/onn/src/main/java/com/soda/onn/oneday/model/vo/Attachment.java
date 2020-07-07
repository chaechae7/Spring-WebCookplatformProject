package com.soda.onn.oneday.model.vo;

import java.io.Serializable;
import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class Attachment implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	

	private String originalFileName;
	private String renamedFileName;
	private Date uploadDate;

	
	
	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	

	
}
