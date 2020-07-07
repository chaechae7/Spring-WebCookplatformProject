package com.soda.onn.oneday.model.vo;

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
public class ReservationRequest extends Reservation implements Serializable {
	private String memberId;
	private String memberName;
	private int onedayclassNo;
	private int onedaytimeNo;
	private String onedayClassName;
	private String onedayTime;
	private int totalPrice;
	private int price;
	
	
	public ReservationRequest(int reservationNo, String reserMemberId, Oneday oneday, String regDate, int personnel,
			String cancel, int resPrice, String memberId, int onedayclassNo, int onedaytimeNo) {
		super(reservationNo, reserMemberId, oneday, regDate, personnel, cancel, resPrice);
		this.memberId = memberId;
		this.onedayclassNo = onedayclassNo;
		this.onedaytimeNo = onedaytimeNo;
	}
	

	

	@Override
	public Oneday getOneday() {
		return super.getOneday();
	}




	@Override
	public void setCancel(String cancel) {
		super.setCancel(cancel);
	}




	@Override
	public void setOneday(Oneday oneday) {
		super.setOneday(oneday);
	}




	@Override
	public void setPersonnel(int personnel) {
		super.setPersonnel(personnel);
	}




	@Override
	public void setRegDate(String regDate) {
		super.setRegDate(regDate);
	}




	@Override
	public void setReserMemberId(String reserMemberId) {
		super.setReserMemberId(reserMemberId);
	}




	@Override
	public void setReservationNo(int reservationNo) {
		super.setReservationNo(reservationNo);
	}




	@Override
	public void setResPrice(int resPrice) {
		super.setResPrice(resPrice);
	}




	@Override
	public String getCancel() {
		return super.getCancel();
	}




	@Override
	public int getPersonnel() {
		return super.getPersonnel();
	}




	@Override
	public String getRegDate() {
		return super.getRegDate();
	}




	@Override
	public String getReserMemberId() {
		return super.getReserMemberId();
	}




	@Override
	public int getReservationNo() {
		return super.getReservationNo();
	}




	@Override
	public int getResPrice() {
		return super.getResPrice();
	}




	private static final long serialVersionUID = 1L;
}
