package com.soda.onn.mall.model.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mortbay.log.Log;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.soda.onn.mall.model.dao.MallDAO;
import com.soda.onn.mall.model.vo.BuyHistory;
import com.soda.onn.mall.model.vo.BuyItem;
import com.soda.onn.mall.model.vo.Cart;
import com.soda.onn.mall.model.vo.IngredientMall;

@Service
public class MallServiceImpl implements MallService {

	@Autowired
	private MallDAO mallDAO;
	
	@Override
	public List<IngredientMall> selectIngredientList(String subCtg) {
		return mallDAO.selectIngredientList(subCtg);
	}

	@Override
	public List<BuyHistory> selectBuyList(String memberId) {
		return mallDAO.selectBuyList(memberId);
	}

	@Override
	public int selectBuyHistoryListCnt() {
		return mallDAO.selectBuyHistoryListCnt();
	}
	
	@Override
	public int updateIngMall(List<Map<String,String>> list) {
		int result = 0;
		for(Map<String,String> map:list) 
			result += mallDAO.updateIngMall(map);
		
		return result;
	}

	@Override
	public List<BuyHistory> selectBuyHistoryList(RowBounds rowBounds) {
		List<BuyHistory> buyHisotyList = mallDAO.selectBuyHistoryList(rowBounds);
		int max = rowBounds.getLimit()-rowBounds.getOffset();
		for (int i = 0; i < buyHisotyList.size(); i++) {
			BuyHistory bh = buyHisotyList.get(i);
			bh.setIngMallList(mallDAO.selectBuyItemOne(bh.getBuyNo()));
			buyHisotyList.set(i, bh);
		}
		return buyHisotyList;
	}

	@Override
	public IngredientMall selectIngMallOne(int ingMallNo) {
		return mallDAO.selectIngMallOne(ingMallNo);
	}

	@Override
	public int insertCart(Cart sb) {
		Cart sb2 = mallDAO.selectCart(sb);
		if(sb2 != null) {
			sb.setSbStock(sb.getSbStock()+sb2.getSbStock());
			return mallDAO.updateCart(sb);
		}
		else return mallDAO.insertCart(sb);
	}

	@Override
	public List<Cart> selectCartList(String memberId) {
		return mallDAO.selectCartList(memberId);
	}

	@Override
	public List<IngredientMall> selectIngMallSearch(String keyword) {
		return mallDAO.selectIngMallSearch(keyword);
	}

	@Override
	public List<IngredientMall> selectCheckOutIng(List<Integer> ingredientNoList) {
		List<IngredientMall> ingMallList = new ArrayList<IngredientMall>();
		for(int i:ingredientNoList) 
			ingMallList.add(mallDAO.selectIngMallOne(i));
			
		return ingMallList;
	}

	@Override
	public int deleteCart(Cart sb) {
		return mallDAO.deleteCart(sb);
	}

	@Override
	public List<IngredientMall> selectIngMallList(List<Map<String, String>> list) {
		List<IngredientMall> ingMallList = new ArrayList<>();
		for(Map<String,String> map : list) {
			int ingNo = Integer.parseInt(map.get("ingNo"));
			int stock = Integer.parseInt(map.get("stock"));

			IngredientMall ingMall = mallDAO.selectIngMallOne(ingNo);
			if(stock > ingMall.getStock())
				ingMall.setStock(0);
			else
				ingMall.setStock(stock);
			ingMallList.add(ingMall);
		}
			
		return ingMallList;
	}

	@Override
	public List<BuyHistory> selectAdminBuyList(String memberId) {
		return mallDAO.selectAdminBuyList(memberId);
	}

	@Override
	public int ingredientInsert(IngredientMall ingredientMall) {
		
		return mallDAO.ingredientInsert(ingredientMall);
  }

	public int insertBuyHistory(BuyHistory bHis) {
		return mallDAO.insertBuyHistory(bHis);
	}

	@Override
	public int insertBuyItems(List<BuyItem> bItems) {
		return mallDAO.insertBuyItem(bItems);
	}

	@Override
	public int deletePaid(List<Cart> cList) {
		return mallDAO.deletePaid(cList);
	}

	@Override
	public String prCategory(String pr) {
		
		return mallDAO.prCategory(pr);
	}

	@Override
	public String crCategory(String cr) {
		
		return mallDAO.crCategory(cr);
	}

	@Override
	public List<BuyHistory> selectBuyHistoryList(String memberId, RowBounds rowBounds) {
		return mallDAO.selectBuyHistoryList(memberId, rowBounds);
	}

}
