package com.soda.onn.oneday.model.dao;

import java.sql.Date;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.session.RowBounds;
import org.mortbay.log.Log;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.soda.onn.oneday.model.vo.Oneday;
import com.soda.onn.oneday.model.vo.OnedayReview;
import com.soda.onn.oneday.model.vo.OnedayTime;
import com.soda.onn.oneday.model.vo.Reservation;
import com.soda.onn.oneday.model.vo.ReservationRequest;

@Repository
public class OnedayDAOImpl implements OnedayDAO{

	@Autowired
	SqlSessionTemplate sqlSession;

	@Override
	public int deleteOneday(int onedayclassNo) {
		return sqlSession.delete("oneday.deleteOneday", onedayclassNo);
	}

	@Override
	public int insertOneday(Oneday oneday) {
		
		return sqlSession.insert("oneday.insertOneday", oneday);
		

		
	}
	@Override
	public int insertTime(OnedayTime onedayTime) {
		return sqlSession.insert("oneday.insertTime", onedayTime);
	}
	
	@Override
	public Oneday selectOne(int onedayclassNo) {
		return sqlSession.selectOne("oneday.selectOne", onedayclassNo);
	}

	@Override
	public List<ReservationRequest> selectReservationList(String memberId, RowBounds rowBounds) {
		return sqlSession.selectList("oneday.selectReservationList", memberId, rowBounds);
	}

	@Override
	public List<OnedayReview> selectOnedayReviewList(RowBounds rowBounds) {
		return sqlSession.selectList("oneday.selectOnedayReviewList", null, rowBounds);
	}

//	@Override
//	public List<Oneday> selectDateList(String detailedAddr, String onedayName) {
//		// TODO Auto-generated method stub
//		return sqlSession.selectList("oneday.selectDateList");
//	}

	@Override
	public List<OnedayTime> selectTimeList(int onedayclassNo) {
		return sqlSession.selectList("oneday.selectTimeList", onedayclassNo);
	}

	
	@Override
	public List<Oneday> onedaySearch(Map<String, String> sec) {
		return sqlSession.selectList("oneday.onedaySearch", sec);
	}

	@Override
	public List<OnedayTime> detailTime(int onedayclassNo) {
		return sqlSession.selectList("oneday.detailTime", onedayclassNo);
	}

	@Override
	public int insertReservation(ReservationRequest reservationrequest) {
		return sqlSession.insert("oneday.insertReservation", reservationrequest);
	}

	@Override
	public int classUpdate(Oneday oneday) {
		return sqlSession.update("oneday.classUpdate", oneday);
	}

	@Override
	public List<ReservationRequest> selectAllReservationList(String memberId) {
		return sqlSession.selectList("oneday.selectAllReservationList", memberId);
	}


	@Override
	public int insertReview(OnedayReview onedayReview) {
		// TODO Auto-generated method stub
		return sqlSession.insert("oneday.insertReview", onedayReview);
	}

	@Override
	public List<OnedayReview> selectReviewList(int onedayclassNo) {
		// TODO Auto-generated method stub
		return sqlSession.selectList("oneday.selectReviewList", onedayclassNo);
	}

	@Override
	public List<Oneday> selectAll(RowBounds rowBounds) {
		// TODO Auto-generated method stub
		return sqlSession.selectList("oneday.selectAll", null, rowBounds);
	}

	@Override
	public int selectOnedayclassListCnt() {
		// TODO Auto-generated method stub
		return Integer.parseInt(sqlSession.selectOne("oneday.selectOnedayclassListCnt"));
	}

	@Override
	public List<Oneday> onedayselect() {
		// TODO Auto-generated method stub
		return sqlSession.selectList("oneday.onedayselect");
	}

	@Override
	public List<OnedayReview> reviewAll() {
		// TODO Auto-generated method stub
		return sqlSession.selectList("oneday.reviewAll");
	}

//	---akim
	
	@Override
	public OnedayTime selectOnedayTimeOne(int onedayTimeNo) {
		return sqlSession.selectOne("oneday.selectOnedayOne", onedayTimeNo);
	}

	@Override
	public int checkVacancy(Map<String, Integer> maps) {
		return sqlSession.selectOne("oneday.checkVacancy", maps);
	}

	@Override
	public List<ReservationRequest> selectReservationListUser(String memberId, RowBounds rowBounds) {
		return sqlSession.selectList("oneday.selectReservationListUser", memberId);
	}

	@Override
	public List<Oneday> popList() {
		// TODO Auto-generated method stub
		return sqlSession.selectList("oneday.popList");
	}








}
