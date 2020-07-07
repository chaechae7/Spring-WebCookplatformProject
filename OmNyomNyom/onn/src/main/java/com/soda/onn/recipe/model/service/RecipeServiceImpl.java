package com.soda.onn.recipe.model.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mortbay.log.Log;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.soda.onn.mall.model.vo.Ingredient;
import com.soda.onn.mall.model.vo.IngredientMall;
import com.soda.onn.mypage.model.vo.DingDong;
import com.soda.onn.mypage.model.vo.Scrap;
import com.soda.onn.recipe.model.dao.RecipeDAO;
import com.soda.onn.recipe.model.vo.Like;
import com.soda.onn.recipe.model.vo.MenuCategory;
import com.soda.onn.recipe.model.vo.Recipe;
import com.soda.onn.recipe.model.vo.RecipeIngredient;
import com.soda.onn.recipe.model.vo.RecipeQuestion;
import com.soda.onn.recipe.model.vo.Report;
import com.soda.onn.recipe.model.vo.RecipeReply;
import com.soda.onn.recipe.model.vo.RelRecipeSelecter;
import com.soda.onn.recipe.model.vo.RecipeWithIngCnt;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class RecipeServiceImpl implements RecipeService {
	
	@Autowired
	private RecipeDAO recipeDAO;

	@Override
	public int deleteRecipeList(int[] deleteList) {
		return recipeDAO.deleteRecipeList(deleteList);
	}

	@Override
	public int insertDingDong(DingDong dd) {
		return recipeDAO.insertDingDong(dd);
	}

	@Override
	public String selectChefProfile(String chefId) {
		return recipeDAO.selectChefProfile(chefId);
	}

	@Override
	public int recipeUpdate(Recipe recipe, List<RecipeIngredient> ingredientList) {
		int result = recipeDAO.recipeUpdate(recipe);
		
		if(result >0) {
			result = recipeDAO.recipeIngrDelete(recipe.getRecipeNo());
			
			for(RecipeIngredient ingr : ingredientList) {
				ingr.setRecipeNo(recipe.getRecipeNo());
				result = recipeDAO.recipeIngrUpload(ingr);
			}
		}
		return result;
	}

	@Override
	public int deleteRecipe(int recipeNo) {
		return recipeDAO.deleteRecipe(recipeNo);
	}

	@Override
	public int insertQuestion(RecipeQuestion question) {
		return recipeDAO.insertQuestion(question);
	}

	@Override
	public int deleteQuestion(int questionNo) {
		return recipeDAO.deleteQuestion(questionNo);
	}

	@Override
	public List<RecipeQuestion> selectQuestionList(int recipeNo) {
		return recipeDAO.selectQuestionList(recipeNo);
	}
	
	@Override
	public int insertReply(RecipeReply reply) {
		return recipeDAO.insertReply(reply);
	}
	

	@Override
	public int deleteReply(int replyNo) {
		return recipeDAO.deleteReply(replyNo);
	}
	
	@Override
	public List<Ingredient> ingredientAjax(String ingr) {
		return recipeDAO.ingredientAjax(ingr);
	}

	@Override
	public List<String> selectIngSubCtg(String mainCtg) {
		return recipeDAO.selectIngSubCtg(mainCtg);
	}

	@Override
	public List<Ingredient> selectIngredients(String subCtg, int cPage, int numPerPage) {
		return recipeDAO.selectIngredients(subCtg, cPage, numPerPage);
	}

	@Override
	public int selectIngredientsCnt(String subCtg) {
		return recipeDAO.selectIngredientsCnt(subCtg);
	}
	
	@Override
	public int recipeUpload(Recipe recipe, List<RecipeIngredient> ingredientList) {
		int result = recipeDAO.recipeUpload(recipe);
		log.debug("recipeNo={}",recipe.getRecipeNo());
		
		if(result >0) {
			for(RecipeIngredient ingr : ingredientList) {
				ingr.setRecipeNo(recipe.getRecipeNo());
				result = recipeDAO.recipeIngrUpload(ingr);
			}
		}
		
		return result;
	}

	@Override
	public Recipe selectRecipeOne(int recipeNo,boolean hasRead) {
		int result = 0;
		
		if(!hasRead) {
			result = recipeDAO.increaseReadCount(recipeNo);
		}
		
		return recipeDAO.selectRecipeOne(recipeNo);
	}

	@Override
	public List<RecipeIngredient> selectRecIngList(int recipeNo) {
		return recipeDAO.selectRecIngList(recipeNo);
	}

	@Override
	public List<MenuCategory> selectCategoryList() {
		return recipeDAO.selectCategoryList();
	}

	@Override
	public Like selectLikeOne(Like l) {
		return recipeDAO.selectLikeOne(l);
	}

	@Override
	public int insertLike(Like like) {
		return recipeDAO.insertLike(like);
	}

	@Override
	public int deleteLike(Like like) {
		return recipeDAO.deleteLike(like);
	}

	@Override
	public Scrap selectScrap(Scrap s) {
		return recipeDAO.selectScrap(s);
	}

	@Override
	public int deleteScrap(Scrap scrap) {
		return recipeDAO.deleteScrap(scrap);
	}

	@Override
	public int insertScrap(Scrap scrap) {
		return recipeDAO.insertScrap(scrap);
	}
	

	@Override
	public List<Report> selectReportList(RowBounds rowBounds) {
		return recipeDAO.selectReportList(rowBounds);
  }
  
  @Override
  public List<IngredientMall> selectingrMallList(List<RecipeIngredient> ingredientList) {
		List<RecipeIngredient> selectList = new ArrayList<RecipeIngredient>();
		int mallSize = 15;
		for(RecipeIngredient r : ingredientList) {
			if(r.getIngredientNo() != 0)
				selectList.add(r);
		}
		Map listMap = new HashMap<String, List<RecipeIngredient>>();
		
		listMap.put("selectList", selectList);
		
		log.debug("{},{}",listMap.get("selectList"), selectList.size());
		
		List<IngredientMall> mallList = null;
		
		if(selectList.size() >0)
			mallList = recipeDAO.selectIngrMallListIn(listMap);
		else
			mallList = new ArrayList<IngredientMall>();
		
		log.debug("{},{}",mallList, mallList.size());
		List<IngredientMall> addList = null;
		if(mallList.size()<mallSize) {
			addList = recipeDAO.selectIngrMallListNotIn(listMap,mallSize-mallList.size());
			log.debug("{}",addList);
			mallList.addAll(addList);
		}

		return mallList;
	}

	@Override
	public List<Recipe> selectRelRecipeList(Recipe recipe) {
		int listSize = 5;
		RelRecipeSelecter rrs = new RelRecipeSelecter(recipe.getCategory(), recipe.getRecipeNo(), null);
		
		List<Recipe> relRecipes = recipeDAO.selectRelRecipeList(rrs,listSize);
		
		if(relRecipes == null)
			relRecipes = new ArrayList<Recipe>();
		
		rrs.setCategory(recipe.getCategory().split("/")[0]);
		rrs.setRelRecipeList(relRecipes);
		
		if(relRecipes.size()<listSize) {
			List<Recipe> prRelRecipes = recipeDAO.selectRelRecipeListPr(rrs,listSize-relRecipes.size());
			relRecipes.addAll(prRelRecipes);
		}

		rrs.setRelRecipeList(relRecipes);
		
		if(relRecipes.size()<listSize) {
			List<Recipe> allRelRecipes = recipeDAO.selectRelRecipeListAll(rrs,listSize-relRecipes.size());
			relRecipes.addAll(allRelRecipes);
		}
		
		return relRecipes;
	}

	@Override
	public List<RecipeReply> selectReplyList(int recipeNo) {
		return recipeDAO.selectReplyList(recipeNo);
	}

	@Override
	public Report selectReport(Report rp) {
		return recipeDAO.selectReport(rp);
	}

	@Override
	public int insertReport(Report rp) {
		return recipeDAO.insertReport(rp);
	}
	
	@Override
	public List<RecipeWithIngCnt> recipeSerachByIng(Map<String, Object> maps, int cPage, int NUMPERPAGE) {
		return recipeDAO.recipeSerachByIng(maps, cPage, NUMPERPAGE);
	}

	@Override
	public List<RecipeWithIngCnt> selectPopRecipe() {
		return recipeDAO.selectPopRecipe();
	}

	@Override
	public List<Ingredient> selectPopIngredient(Map<String, Object> maps) {
		return recipeDAO.selectPopIngredient(maps);
	}

	@Override
	public List<RecipeWithIngCnt> recipeSearchByMenu(Map<String, Object> maps, int cPage, int NUMPERPAGE) {
		return recipeDAO.recipeSearchByMenu(maps, cPage, NUMPERPAGE);
	}

	@Override

	public List<String> selectMenuSubCtg(String mainCtg) {
		return recipeDAO.selectMenuSubCtg(mainCtg);
	}
	
 	@Override 
   	public List<Recipe> recipeSelectAll(String chefNickName) {
		return recipeDAO.recipeSelectAll(chefNickName);
	}

	@Override
	public int ingredientInsert(Ingredient ingredient) {
		return recipeDAO.ingrdientInsert(ingredient);
  }
  
  @Override
	public int selectRecipeCnt(Map<String, Object> maps) {
		return recipeDAO.selectRecipeCnt(maps);
	}

	@Override
	public int rcpCntByMenu(Map<String, Object> maps) {
		return recipeDAO.rcpCntByMenu(maps);
	}

}
