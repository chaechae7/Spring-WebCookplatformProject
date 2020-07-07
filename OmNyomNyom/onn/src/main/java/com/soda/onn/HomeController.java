package com.soda.onn;

import java.text.DateFormat;
import java.util.Date;
import java.util.Enumeration;
import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.soda.onn.chef.model.service.ChefService;
import com.soda.onn.chef.model.vo.Chef;
import com.soda.onn.oneday.model.service.OnedayService;
import com.soda.onn.oneday.model.vo.Oneday;
import com.soda.onn.oneday.model.vo.OnedayReview;
import com.soda.onn.recipe.model.service.RecipeService;
import com.soda.onn.recipe.model.vo.RecipeWithIngCnt;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	
	@Autowired
	private OnedayService onedayService;
	@Autowired
	private RecipeService recipeService;
	@Autowired
	private ChefService chefservice;
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */  
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, 
					   Model model, 
					   HttpSession session) {
		logger.info("Welcome home! The client locale is {}.", locale);
		
		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
		
		String formattedDate = dateFormat.format(date);
		
		
//		MainPage Recipe 인기 영상 
		List<RecipeWithIngCnt> popRecipe = recipeService.selectPopRecipe();
//		MainPage Onedayclass 인기 클래스 
		List<Oneday> popList = onedayService.popList();
		List<Chef> chefList = chefservice.selectChefAllList();
//		MainPage Onedayclass Review 댓글
		List<Oneday> AllList = onedayService.onedayselect(); 
		List<OnedayReview> reviewList = onedayService.reviewAll();
		
		
		model.addAttribute("popList", popList);
		model.addAttribute("chefList", chefList);
		model.addAttribute("popRecipe",popRecipe);
		model.addAttribute("AllList",AllList);
		model.addAttribute("reviewList",reviewList);
		model.addAttribute("serverTime", formattedDate );
		
		return "forward:/index.jsp";// /WEB-INF/views/home.jsp
	}
	
}
