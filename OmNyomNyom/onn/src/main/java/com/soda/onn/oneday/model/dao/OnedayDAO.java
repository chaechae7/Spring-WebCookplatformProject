package com.soda.onn.oneday.model.dao;

import java.sql.Date;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;

import com.soda.onn.oneday.model.vo.Oneday;
import com.soda.onn.oneday.model.vo.OnedayReview;
import com.soda.onn.oneday.model.vo.OnedayTime;
import com.soda.onn.oneday.model.vo.Reservation;
import com.soda.onn.oneday.model.vo.ReservationRequest;

public interface OnedayDAO {

	int deleteOneday(int onedayclassNo);

	int insertOneday(Oneday oneday);

	int insertTime(OnedayTime onedayTime);

	Oneday selectOne(int onedayclassNo);

	List<ReservationRequest> selectReservationList(String memberId, RowBounds rowBounds);

	List<OnedayReview> selectOnedayReviewList(RowBounds rowBounds);

//	List<Oneday> selectDateList(String detailedAddr, String onedayName);


	List<OnedayTime> selectTimeList(int onedayclassNo);

	List<Oneday> onedaySearch(Map<String, String> sec);

	List<OnedayTime> detailTime(int onedayclassNo);

	int insertReservation(ReservationRequest reservationrequest);

	int classUpdate(Oneday oneday);

	List<ReservationRequest> selectAllReservationList(String memberId);


	int insertReview(OnedayReview onedayReview);

	List<OnedayReview> selectReviewList(int onedayclassNo);

	List<Oneday> selectAll(RowBounds rowBounds);

	int selectOnedayclassListCnt();

	List<Oneday> onedayselect();

	List<OnedayReview> reviewAll();

	//	---akim
	
	OnedayTime selectOnedayTimeOne(int onedayTimeNo);

	int checkVacancy(Map<String, Integer> maps);

	List<ReservationRequest> selectReservationListUser(String memberId, RowBounds rowBounds);

	List<Oneday> popList();










}
