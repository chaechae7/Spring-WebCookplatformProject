package com.soda.onn.mypage.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.soda.onn.mypage.model.vo.DingDong;
import com.soda.onn.mypage.model.vo.Scrap;

@Repository
public class MypageDAOImpl implements MypageDAO {
	
	@Autowired
	private SqlSessionTemplate sqlSession;

	@Override
	public List<Scrap> selectScrapList(String memberId, RowBounds rowBounds) {
		return sqlSession.selectList("mypage.selectScrapList", memberId, rowBounds);
	}

	@Override
	public int deleteScrap(Map mmap) {
		return sqlSession.delete("mypage.deleteScrap", mmap);
	}

	@Override
	public int updateScrap(Scrap scrap) {
		return sqlSession.update("mypage.updateScrap", scrap);
	}

	@Override
	public List<DingDong> selectDingList(Map<String, String > map) {
		return sqlSession.selectList("mypage.selectDingList", map);
	}

	@Override
	public int dingdongUpdate(int dingdongNo) {
		
		return sqlSession.update("mypage.dingdongUpdate",dingdongNo);
	}

	@Override
	public int insertPayDing(DingDong dd) {
		return sqlSession.insert("mypage.insertPayDing", dd);
	}
}
