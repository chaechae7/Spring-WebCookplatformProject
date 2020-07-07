package com.soda.onn.mall.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;

import com.soda.onn.mall.model.vo.BuyHistory;
import com.soda.onn.mall.model.vo.BuyItem;
import com.soda.onn.mall.model.vo.IngredientMall;
import com.soda.onn.mall.model.vo.Cart;

public interface MallDAO {

	List<IngredientMall> selectIngredientList(String subCtg);

	List<BuyHistory> selectBuyList(String memberId);

	int selectBuyHistoryListCnt();
	
	int updateIngMall(Map<String,String> map);

	List<BuyHistory> selectBuyHistoryList(RowBounds rowBounds);

	IngredientMall selectIngMallOne(int ingMallNo);

	List<Cart> selectCartList(String memberId);
	
	List<IngredientMall> selectIngMallSearch(String keyword);

	int insertCart(Cart cart);

	Cart selectCart(Cart cart);
	
	int updateCart(Cart cart);

	int deleteCart(Cart cart);

	List<BuyHistory> selectAdminBuyList(String memberId);

	int ingredientInsert(IngredientMall ingredientMall);

	int insertBuyHistory(BuyHistory bHis);

	int insertBuyItem(List<BuyItem> bItems);

	int deletePaid(List<Cart> cList);

	String prCategory(String pr);

	List<IngredientMall> selectBuyItemOne(int buyNo);

	String crCategory(String cr);

	List<BuyHistory> selectBuyHistoryList(String memberId, RowBounds rowBounds);



}
