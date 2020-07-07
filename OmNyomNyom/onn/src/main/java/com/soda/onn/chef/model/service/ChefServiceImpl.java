package com.soda.onn.chef.model.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.soda.onn.chef.model.dao.ChefDAO;
import com.soda.onn.chef.model.vo.Chef;
import com.soda.onn.chef.model.vo.ChefRequest;
import com.soda.onn.member.model.vo.Notice;
import com.soda.onn.oneday.model.vo.Oneday;
import com.soda.onn.recipe.model.vo.Recipe;

@Service
public class ChefServiceImpl implements ChefService {

	
	@Autowired
	private ChefDAO chefDAO;
	
	@Override
	public List<Chef> selectChefAllList() {
		return chefDAO.selectChefAllList();
	}

	@Override
	public List<ChefRequest> selectChefRequestList(RowBounds rowBounds) {
		return chefDAO.selectChefRequestList(rowBounds);
	}

	@Override
	public ChefRequest selectChefRequest(String memberId) {
		return chefDAO.selectChefRequest(memberId);
	}

	@Override
	public int selectChefRequestListCnt() {
		return chefDAO.selectChefRequestListCnt();
	}

	@Override
	public int chefRequest(ChefRequest chefRequest) {
		return chefDAO.chefReuqest(chefRequest);
	}

	@Override
	public List<Chef> chefSearch(String chefsearchbar) {
		return chefDAO.chefSearch(chefsearchbar);
	}

	@Override
	public Chef chefSelectOne(String chefNickName) {
		return chefDAO.chefSelectOne(chefNickName);
  }
  
  @Override
	public int chefRequestUpdate(Map<String, String> chefReq) {
		return chefDAO.chefRequestUpdate(chefReq);
	}

	@Override
	public List<Recipe> recipeSelectAll(String chefNickName) {
		
		return chefDAO.recipeSelectAll(chefNickName);
	}

	@Override
	public int chefNoticeInsert(Notice notice) {
		return chefDAO.chefNoticeInsert(notice);
	}

	@Override
	public Notice chefNoticeView(int noticeNo) {
		return chefDAO.chefNoticeView(noticeNo);
	}

	@Override
	public List<Notice> noticeSelectAll(String chefId) {
		return chefDAO.noticeSelectAll(chefId);
	}

	@Override
	public int chefNoticeDelete(int noticeNo) {
		return chefDAO.chefNoticeDelete(noticeNo);
	}


	@Override
	public int chefnoticeUpdate(Notice notice) {
		return chefDAO.chefnoticeUpdate(notice);
	}

	@Override
	public List<Oneday> onedaySelectAll(String chefId) {
		return chefDAO.onedaySelectAll(chefId);
	}

	@Override
	public int chefRequestUpdate(ChefRequest chefreq) {
		return chefDAO.chefRequestUpdate(chefreq);
	}



	@Override
	public Chef chefSelectId(String memberId) {
		return chefDAO.chefSelectId(memberId);
	}
	
}
