package com.soda.onn.chef.model.vo;

import java.io.Serializable;
import java.sql.Date;
import java.util.List;
import java.util.Map;

import com.soda.onn.member.model.vo.Member;

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
public class ChefRequest implements Serializable{

	private static final long serialVersionUID = 1L;
	
	
	private String chefId;
	private String chefNickName;
	private String chefProfile;
	private String sns;
	private String chefContent;
	private String chefApVideo;
	private String menuPrCategory;
	private String businessInfo;
	private Date reqDate;
	private String chefReqOk;
	
	private Map<String, String> snsMap;
	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	
	
	
	
	
	
	

}
