package com.soda.onn.chef.model.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;

import com.soda.onn.chef.model.vo.Chef;
import com.soda.onn.chef.model.vo.ChefRequest;
import com.soda.onn.member.model.vo.Notice;
import com.soda.onn.oneday.model.vo.Oneday;
import com.soda.onn.recipe.model.vo.Recipe;

public interface ChefService {

	List<Chef> selectChefAllList();

	List<ChefRequest> selectChefRequestList(RowBounds rowBounds);

	ChefRequest selectChefRequest(String memberId);

	int selectChefRequestListCnt();

	int chefRequest(ChefRequest chefRequest);

	List<Chef> chefSearch(String chefsearchbar);

	Chef chefSelectOne(String chefNickName);
	
    int chefRequestUpdate(Map<String, String> chefReq);

    List<Recipe> recipeSelectAll(String chefNickName);

	int chefNoticeInsert(Notice notice);

	Notice chefNoticeView(int noticeNo);

	List<Notice> noticeSelectAll(String chefId);

	int chefNoticeDelete(int noticeNo);

	int chefnoticeUpdate(Notice notice);

	List<Oneday> onedaySelectAll(String chefId);

	int chefRequestUpdate(ChefRequest chefreq);

	Chef chefSelectId(String getter);

}
