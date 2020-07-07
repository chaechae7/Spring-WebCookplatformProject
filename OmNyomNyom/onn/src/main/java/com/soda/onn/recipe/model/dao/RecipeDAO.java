 package com.soda.onn.recipe.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;

import com.soda.onn.mall.model.vo.Ingredient;
import com.soda.onn.mall.model.vo.IngredientMall;
import com.soda.onn.mypage.model.vo.DingDong;
import com.soda.onn.mypage.model.vo.Scrap;
import com.soda.onn.recipe.model.vo.Like;
import com.soda.onn.recipe.model.vo.MenuCategory;
import com.soda.onn.recipe.model.vo.Recipe;
import com.soda.onn.recipe.model.vo.RecipeIngredient;
import com.soda.onn.recipe.model.vo.RecipeQuestion;
import com.soda.onn.recipe.model.vo.RecipeReply;
import com.soda.onn.recipe.model.vo.RecipeWithIngCnt;
import com.soda.onn.recipe.model.vo.RelRecipeSelecter;
import com.soda.onn.recipe.model.vo.Report;

public interface RecipeDAO {

	int deleteRecipeList(int[] deleteList);

	int insertDingDong(DingDong dd);

	String selectChefProfile(String chefId);

	int recipeUpdate(Recipe recipe);

	int recipeIngrDelete(int recipeNo);

	int deleteRecipe(int recipeNo);

	int insertQuestion(RecipeQuestion question);

	int deleteQuestion(int questionNo);
	
	List<RecipeQuestion> selectQuestionList(int recipeNo);
	
	int insertReply(RecipeReply reply);

	int deleteReply(int replyNo);
	
	List<RecipeReply> selectReplyList(int recipeNo);
	
	List<String> selectIngSubCtg(String mainCtg);

	List<Ingredient> selectIngredients(String subCtg, int cPage, int numPerPage);

	int selectIngredientsCnt(String subCtg);
	List<Ingredient> ingredientAjax(String ingr);

	int recipeUpload(Recipe recipe);

	int recipeIngrUpload(RecipeIngredient ingr);

	Recipe selectRecipeOne(int recipeNo);

	List<RecipeIngredient> selectRecIngList(int recipeNo);

	List<MenuCategory> selectCategoryList();

	Like selectLikeOne(Like l);

	int insertLike(Like like);

	int deleteLike(Like like);

	Scrap selectScrap(Scrap s);

	int deleteScrap(Scrap scrap);

	int insertScrap(Scrap scrap);
	
 	List<Report> selectReportList(RowBounds rowBounds);

    int increaseReadCount(int recipeNo);

	List<IngredientMall> selectIngrMallListIn(Map listMap);

	List<IngredientMall> selectIngrMallListNotIn(Map listMap, int i);

	List<Recipe> selectRelRecipeList(RelRecipeSelecter rrs, int listSize);

	List<Recipe> selectRelRecipeListPr(RelRecipeSelecter rrs, int i);

	List<Recipe> selectRelRecipeListAll(RelRecipeSelecter rrs, int i);
	
	List<RecipeWithIngCnt> recipeSerachByIng(Map<String, Object> maps, int cPage, int nUMPERPAGE);

	List<RecipeWithIngCnt> selectPopRecipe();

	List<Ingredient> selectPopIngredient(Map<String, Object> maps);

	List<RecipeWithIngCnt> recipeSearchByMenu(Map<String, Object> maps, int cPage, int NUMPERPAGE);

	List<String> selectMenuSubCtg(String mainCtg);

	Report selectReport(Report rp);

	int insertReport(Report rp);

	List<Recipe> recipeSelectAll(String chefNickName);

	int ingrdientInsert(Ingredient ingredient);

	int selectRecipeCnt(Map<String, Object> maps);

	int rcpCntByMenu(Map<String, Object> maps);

}
