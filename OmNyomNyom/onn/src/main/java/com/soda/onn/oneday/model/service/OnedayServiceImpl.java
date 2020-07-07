package com.soda.onn.oneday.model.service;

import java.sql.Date;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.One;
import org.apache.ibatis.session.RowBounds;
import org.mortbay.log.Log;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.soda.onn.oneday.model.dao.OnedayDAO;
import com.soda.onn.oneday.model.vo.Oneday;
import com.soda.onn.oneday.model.vo.OnedayReview;
import com.soda.onn.oneday.model.vo.OnedayTime;

import com.soda.onn.oneday.model.vo.Reservation;
import com.soda.onn.oneday.model.vo.ReservationRequest;

import lombok.extern.slf4j.Slf4j;
@Slf4j
@Service
public class OnedayServiceImpl implements OnedayService {

	@Autowired
	private OnedayDAO onedayDAO;

	@Override
	public int deleteOneday(int onedayclassNo) {
		return onedayDAO.deleteOneday(onedayclassNo);
	}
	
	
	@Override
	public int insertOneday(Oneday oneday,  List<String> otiList) {
		
		int result = onedayDAO.insertOneday(oneday);

		if(result>0)
			for(int i=0; i<otiList.size(); i++) {
				OnedayTime onedayTime = new OnedayTime();
				
				onedayTime.setOnedayTimeDate(otiList.get(i));
				
				onedayTime.setOnedayNoo(oneday.getOnedayclassNo());
				
				Log.debug("원데이클래스 no = " + onedayTime);
				onedayDAO.insertTime(onedayTime);
			}
		
		return result;
	}
	
	@Override
	public Oneday selectOne(int onedayclassNo) {
		
		Oneday one = onedayDAO.selectOne(onedayclassNo);
		
		one.setOnedayTimeList(onedayDAO.selectTimeList(onedayclassNo));

		return one;
	}


	@Override
	public List<ReservationRequest> selectReservationList(String memberId, RowBounds rowBounds) {
		return onedayDAO.selectReservationList(memberId, rowBounds);
	}

	@Override
	public List<OnedayReview> selectOnedayReviewList(RowBounds rowBounds) {
		return onedayDAO.selectOnedayReviewList(rowBounds);
	}


	@Override
	public List<Oneday> onedaySearch(Map<String, String> sec) {
		List<Oneday> list = onedayDAO.onedaySearch(sec);
		
		for (Oneday one : list) {
			one.setOnedayTimeList(onedayDAO.selectTimeList(one.getOnedayclassNo()));
////			원데이 클래스의 넘버를 매개변수로하는  OnedayTime을 selectOne하는 것.
////			거기에서 불러온 값을 Oenday의 private List<OnedayTime> onedayTimeList;에 담음.
		
		}
	
		return list;
	}


	@Override
	public List<OnedayTime> selectTimeList(int onedayclassNo) {
		// TODO Auto-generated method stub
		return onedayDAO.selectTimeList(onedayclassNo);
	}


	@Override
	public int insertReservation(ReservationRequest reservationrequest) {
		// TODO Auto-generated method stub
		return onedayDAO.insertReservation(reservationrequest);
	}


	@Override
	public int classUpdate(Oneday oneday, List<String> otiList) {
		// TODO Auto-generated method stub
		int result =  onedayDAO.classUpdate(oneday);
		
		if(result>0)
			for(int i=0; i<otiList.size(); i++) {
				OnedayTime onedayTime = new OnedayTime();
				
				onedayTime.setOnedayTimeDate(otiList.get(i));
				
				onedayTime.setOnedayNoo(oneday.getOnedayclassNo());
				
				Log.debug("원데이클래스 no = " + onedayTime);
				onedayDAO.insertTime(onedayTime);
			}
		
		
		return result;
		
	}


	@Override
	public int insertReview(OnedayReview onedayReview) {
		// TODO Auto-generated method stub
		return onedayDAO.insertReview(onedayReview);
	}


	@Override
	public List<OnedayReview> selectReviewList(int onedayclassNo) {
		// TODO Auto-generated method stub
		return onedayDAO.selectReviewList(onedayclassNo);
	}


	@Override
	public List<Oneday> selectAll(RowBounds rowBounds) {
		// TODO Auto-generated method stub
		return onedayDAO.selectAll(rowBounds);
	}



	@Override
	public List<ReservationRequest> selectAllReservationList(String memberId) {
		return onedayDAO.selectAllReservationList(memberId);
	}


	@Override
	public int selectOnedayclassListCnt() {
		// TODO Auto-generated method stub
		return onedayDAO.selectOnedayclassListCnt();
	}


	@Override
	public List<Oneday> onedayselect() {
		// TODO Auto-generated method stub
		return onedayDAO.onedayselect();
	}


	@Override
	public List<OnedayReview> reviewAll() {
		// TODO Auto-generated method stub
		return onedayDAO.reviewAll();
	}



//	---akim

	@Override
	public OnedayTime selectOnedayTimeOne(int onedayTimeNo) {
		return onedayDAO.selectOnedayTimeOne(onedayTimeNo);
	}


	@Override
	public int checkVacancy(Map<String, Integer> maps) {
		return onedayDAO.checkVacancy(maps);
	}


	@Override
	public List<ReservationRequest> selectReservationListUser(String memberId, RowBounds rowBounds) {
		return onedayDAO.selectReservationListUser(memberId, rowBounds);
	}


	@Override
	public List<Oneday> popList() {
		// TODO Auto-generated method stub
		return onedayDAO.popList();
	}



}


