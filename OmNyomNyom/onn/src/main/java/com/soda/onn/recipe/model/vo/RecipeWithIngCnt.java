package com.soda.onn.recipe.model.vo;

import java.io.Serializable;
import java.sql.Date;
import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

//포함재료 카운트를 가져가는 Vo
@Setter
@Getter
@ToString
@NoArgsConstructor
public class RecipeWithIngCnt extends Recipe implements Serializable {

	private static final long serialVersionUID = 1L;
	
	private int includeNo;
	private String chefProfile;

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	public RecipeWithIngCnt(int recipeNo, String videoTitle, String videoLink, String menuName, String chefNick,
			String chefId, int cookingTime, String category, Date regDate, int viewCount, String recipeContent,
			String timeline, List<RecipeIngredient> ingredientList, int includeNo, String chefProfile) {
		super(recipeNo, videoTitle, videoLink, menuName, chefNick, chefId, cookingTime, category, regDate, viewCount,
				recipeContent, timeline, ingredientList);
		this.includeNo = includeNo;
		this.chefProfile = chefProfile;
	}
	
	
	
	@Override
	public void setCategory(String category) {
		super.setCategory(category);
	}

	@Override
	public void setChefId(String chefId) {
		super.setChefId(chefId);
	}

	@Override
	public void setChefNick(String chefNick) {
		super.setChefNick(chefNick);
	}

	@Override
	public void setCookingTime(int cookingTime) {
		super.setCookingTime(cookingTime);
	}

	@Override
	public void setIngredientList(List<RecipeIngredient> ingredientList) {
		super.setIngredientList(ingredientList);
	}

	@Override
	public void setMenuName(String menuName) {
		super.setMenuName(menuName);
	}

	@Override
	public void setRecipeContent(String recipeContent) {
		super.setRecipeContent(recipeContent);
	}

	@Override
	public void setRecipeNo(int recipeNo) {
		super.setRecipeNo(recipeNo);
	}

	@Override
	public void setRegDate(Date regDate) {
		super.setRegDate(regDate);
	}

	@Override
	public void setTimeline(String timeline) {
		super.setTimeline(timeline);
	}

	@Override
	public void setVideoLink(String videoLink) {
		super.setVideoLink(videoLink);
	}

	@Override
	public void setVideoTitle(String videoTitle) {
		super.setVideoTitle(videoTitle);
	}

	@Override
	public void setViewCount(int viewCount) {
		super.setViewCount(viewCount);
	}

	@Override
	public String getCategory() {
		return super.getCategory();
	}

	@Override
	public String getChefId() {
		return super.getChefId();
	}

	@Override
	public String getChefNick() {
		return super.getChefNick();
	}

	@Override
	public int getCookingTime() {
		return super.getCookingTime();
	}

	@Override
	public List<RecipeIngredient> getIngredientList() {
		return super.getIngredientList();
	}

	@Override
	public String getMenuName() {
		return super.getMenuName();
	}

	@Override
	public String getRecipeContent() {
		return super.getRecipeContent();
	}

	@Override
	public int getRecipeNo() {
		return super.getRecipeNo();
	}

	@Override
	public Date getRegDate() {
		return super.getRegDate();
	}

	@Override
	public String getTimeline() {
		return super.getTimeline();
	}

	@Override
	public String getVideoLink() {
		return super.getVideoLink();
	}

	@Override
	public String getVideoTitle() {
		return super.getVideoTitle();
	}

	@Override
	public int getViewCount() {
		return super.getViewCount();
	}

	
	
	
}
