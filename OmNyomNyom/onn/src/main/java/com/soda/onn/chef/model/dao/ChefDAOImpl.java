package com.soda.onn.chef.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.soda.onn.chef.model.vo.Chef;
import com.soda.onn.chef.model.vo.ChefRequest;
import com.soda.onn.member.model.vo.Notice;
import com.soda.onn.oneday.model.vo.Oneday;
import com.soda.onn.recipe.model.vo.Recipe;

@Repository
public class ChefDAOImpl implements ChefDAO {

	@Autowired
	private SqlSessionTemplate sqlSession;
	
	
	@Override
	public List<Chef> selectChefAllList() {
		
		return sqlSession.selectList("chef.selectChefAllList");
	}
	@Override
	public List<ChefRequest> selectChefRequestList(RowBounds rowBounds) {
		return sqlSession.selectList("chef.selectChefRequestList", null, rowBounds);
	}

	@Override
	public ChefRequest selectChefRequest(String memberId) {
		return sqlSession.selectOne("chef.selectChefRequest", memberId);
	}

	@Override
	public int selectChefRequestListCnt() {
		return Integer.parseInt(sqlSession.selectOne("chef.selectChefRequestListCnt"));
	}

	@Override
	public int chefReuqest(ChefRequest chefRequest) {
		return sqlSession.insert("chef.chefRequest",chefRequest);
	}
	@Override
	public List<Chef> chefSearch(String chefsearchbar) {
		return sqlSession.selectList("chef.chefSearch", chefsearchbar);
	}
	@Override
	public Chef chefSelectOne(String chefNickName) {
		return sqlSession.selectOne("chef.chefSelectOne",chefNickName);
	}

	@Override
	public int chefRequestUpdate(Map<String, String> chefReq) {
		return sqlSession.update("chef.chefRequestUpdate", chefReq);
	}
	
	@Override
	public List<Recipe> recipeSelectAll(String chefNickName) {
		return sqlSession.selectList("chef.recipeSelectAll", chefNickName );
	}
	@Override
	public int chefNoticeInsert(Notice notice) {
		return sqlSession.insert("chef.chefNoticeInsert", notice);
	}
	@Override
	public Notice chefNoticeView(int noticeNo) {
		return sqlSession.selectOne("chef.chefNoticeView", noticeNo);
	}
	@Override
	public List<Notice> noticeSelectAll(String chefId) {
		return sqlSession.selectList("chef.noticeSelectAll", chefId);
	}
	@Override
	public int chefNoticeDelete(int noticeNo) {
		return sqlSession.delete("chef.chefNoticeDelete", noticeNo);
	}
	@Override
	public int chefnoticeUpdate(Notice notice) {
		return sqlSession.update("chef.noticeUpdate",notice);
	}
	@Override
	public List<Oneday> onedaySelectAll(String chefId) {
		return sqlSession.selectList("chef.onedaySelectAll",chefId);
	}
	@Override
	public int chefRequestUpdate(ChefRequest chefreq) {
			return sqlSession.update("chef.chefRequestUpdate", chefreq);
	}
	@Override
	public Chef chefSelectId(String memberId) {
		return sqlSession.selectOne("chef.chefSelectId", memberId);
	}


}
