package com.soda.onn.oneday.model.vo;

import java.io.Serializable;
import java.sql.Date;
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
public class ReservationCancel extends Reservation implements Serializable{
	
	private static final long serialVersionUID = 1L;

	private String cancelReason;

	public ReservationCancel(int reservationNo, String reserMemberId, Oneday oneday, String regDate, int personnel,
			String cancel, String cancelReason, int resPrice) {
		super(reservationNo, reserMemberId, oneday, regDate, personnel, cancel, resPrice);
		this.cancelReason = cancelReason;
	}

	 
}
