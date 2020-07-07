package com.soda.onn.recipe.model.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;

import com.soda.onn.recipe.model.vo.Report;
import com.soda.onn.mall.model.vo.Ingredient;
import com.soda.onn.mall.model.vo.IngredientMall;
import com.soda.onn.mypage.model.vo.DingDong;
import com.soda.onn.mypage.model.vo.Scrap;
import com.soda.onn.recipe.model.vo.Like;
import com.soda.onn.recipe.model.vo.MenuCategory;
import com.soda.onn.recipe.model.vo.Recipe;
import com.soda.onn.recipe.model.vo.RecipeIngredient;
import com.soda.onn.recipe.model.vo.RecipeQuestion;
import com.soda.onn.recipe.model.vo.Report;
import com.soda.onn.recipe.model.vo.RecipeWithIngCnt;
import com.soda.onn.recipe.model.vo.RecipeReply;

public interface RecipeService {

	int deleteRecipeList(int[] deleteList);

	int insertDingDong(DingDong dd);

	String selectChefProfile(String chefId);

	int recipeUpdate(Recipe recipe, List<RecipeIngredient> ingredientList);

	int deleteRecipe(int recipeNo);
	
	int insertQuestion(RecipeQuestion question);

	int deleteQuestion(int questionNo);
	
	List<RecipeQuestion> selectQuestionList(int recipeNo);

	int insertReply(RecipeReply reply);

	int deleteReply(int replyNo);
	
	List<String> selectIngSubCtg(String mainCtg);

	List<Ingredient> selectIngredients(String subCtg, int cPage, int nUMPERPAGE);

	int selectIngredientsCnt(String subCtg);

	int recipeUpload(Recipe recipe, List<RecipeIngredient> ingredientList);

	List<Ingredient> ingredientAjax(String ingr);

	Recipe selectRecipeOne(int recipeNo, boolean hasRead);

	List<RecipeIngredient> selectRecIngList(int recipeNo);

	List<MenuCategory> selectCategoryList();

	Like selectLikeOne(Like l);

	int insertLike(Like like);

	int deleteLike(Like like);

	Scrap selectScrap(Scrap s);

	int deleteScrap(Scrap scrap);

	int insertScrap(Scrap scrap);
	
 	List<Report> selectReportList(RowBounds rowBounds);

    List<IngredientMall> selectingrMallList(List<RecipeIngredient> ingredientList);

	List<Recipe> selectRelRecipeList(Recipe recipe);

	List<RecipeReply> selectReplyList(int recipeNo);
	
	List<RecipeWithIngCnt> recipeSerachByIng(Map<String, Object> maps, int cPage, int NUMPERPAGE);

	List<RecipeWithIngCnt> selectPopRecipe();

	List<Ingredient> selectPopIngredient(Map<String, Object> maps);

	List<RecipeWithIngCnt> recipeSearchByMenu(Map<String, Object> maps, int cPage, int nUMPERPAGE);
	
	List<String> selectMenuSubCtg(String mainCtg);

	Report selectReport(Report rp);

	int insertReport(Report rp);

	List<Recipe> recipeSelectAll(String chefNickName);

	int ingredientInsert(Ingredient ingredient);

	int selectRecipeCnt(Map<String, Object> maps);

	int rcpCntByMenu(Map<String, Object> maps);

}
