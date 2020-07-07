package com.soda.onn.mypage.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;

import com.soda.onn.mypage.model.vo.DingDong;
import com.soda.onn.mypage.model.vo.Scrap;

public interface MypageDAO {

	List<Scrap> selectScrapList(String memberId, RowBounds rowBounds);

	int deleteScrap(Map mmap);

	int updateScrap(Scrap scrap);

	List<DingDong> selectDingList(Map<String, String> map);

	int dingdongUpdate(int dingdongNo);

	int insertPayDing(DingDong dd);



}
