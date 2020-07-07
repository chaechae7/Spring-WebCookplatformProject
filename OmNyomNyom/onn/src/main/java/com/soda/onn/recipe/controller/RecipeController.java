package com.soda.onn.recipe.controller;


import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.RowBounds;

import java.io.BufferedInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.security.GeneralSecurityException;
import java.sql.Date;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collection;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.servlet.view.RedirectView;

import com.google.api.client.auth.oauth2.Credential;
import com.google.api.client.extensions.java6.auth.oauth2.AuthorizationCodeInstalledApp;
import com.google.api.client.extensions.jetty.auth.oauth2.LocalServerReceiver;
import com.google.api.client.extensions.jetty.auth.oauth2.LocalServerReceiver.Builder;
import com.google.api.client.googleapis.auth.oauth2.GoogleAuthorizationCodeFlow;
import com.google.api.client.googleapis.auth.oauth2.GoogleClientSecrets;
import com.google.api.client.googleapis.javanet.GoogleNetHttpTransport;
import com.google.api.client.http.InputStreamContent;
import com.google.api.client.http.javanet.NetHttpTransport;
import com.google.api.client.json.JsonFactory;
import com.google.api.client.json.jackson2.JacksonFactory;
import com.google.api.services.youtube.YouTube;
import com.google.api.services.youtube.model.Video;
import com.google.api.services.youtube.model.VideoSnippet;
import com.google.api.services.youtube.model.VideoStatus;
import com.google.common.reflect.TypeToken;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.soda.onn.mall.model.vo.Ingredient;
import com.soda.onn.mall.model.vo.IngredientMall;
import com.soda.onn.member.model.vo.Member;
import com.soda.onn.mypage.model.service.MypageService;
import com.soda.onn.mypage.model.vo.DingDong;
import com.soda.onn.mypage.model.vo.Scrap;
import com.soda.onn.recipe.model.service.RecipeService;
import com.soda.onn.recipe.model.vo.Like;
import com.soda.onn.recipe.model.vo.MenuCategory;
import com.soda.onn.recipe.model.vo.Recipe;
import com.soda.onn.recipe.model.vo.RecipeIngredient;
import com.soda.onn.recipe.model.vo.Report;
import com.soda.onn.recipe.model.vo.RecipeWithIngCnt;
import com.soda.onn.recipe.model.vo.RecipeQuestion;
import com.soda.onn.recipe.model.vo.RecipeReply;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/recipe")
public class RecipeController {

	@Autowired
	private RecipeService recipeService;
	
	@Autowired
	private MypageService mypageService;
	final int NUMPERPAGE = 12;
	final int PAGEBARSIZE = 10;

	private RowBounds rowBounds = null;
	
	//레시피 리스트 삭제
	@PostMapping("/deleteRecipeList")
	public String deleteRecipeList(HttpSession session,
								   @RequestParam("chefId")String chefId,
								   @RequestParam("deleteList")int[] deleteList,
								   RedirectAttributes reAttr) {
		
		Member member = (Member)session.getAttribute("memberLoggedIn");
		if(!member.getMemberNick().equals(chefId)) {
			reAttr.addFlashAttribute("msg","다른 셰프의 레시피를 수정하려 했습니다.");
			return "redirect:/";
		}
		
		int result = recipeService.deleteRecipeList(deleteList);
		
		try {
			chefId = URLEncoder.encode(chefId, "UTF-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		return "redirect:/recipe/recipeUpdate?chefNickName="+chefId;
	}
	
	//댓글 신고
	@GetMapping(value="/replyReport/{replyNo}",produces = "text/plain;charset=UTF-8")
	@ResponseBody
	public String replyReport(HttpSession session,
						 	  @PathVariable("replyNo")int replyNo,
						 	  @RequestParam("memo")String memo) {
		
		Member m = (Member)session.getAttribute("memberLoggedIn");
		
		Report report = new Report(m.getMemberId(), replyNo, null, memo);
		
		int result = recipeService.insertReport(report);
		
		if(result>0) {
			DingDong dd = new DingDong(0, "sdmin", m.getMemberId()+"가 신고하였습니다.", "/admin/reportList", 1, null);
			
			result = recipeService.insertDingDong(dd);
		}
		
		return result>0?"t":"f";
	}
	//레시피 수정
	@PostMapping("/recipeUpdateEnd")
	public String recipeUpdateEnd(Recipe recipe,
								  @RequestParam(value = "chefId") String chefId,
								  @RequestParam(value = "chefNick") String chefNick,
								  @RequestParam(value = "ingr_name") String[] ingrName,
								  @RequestParam(value = "ingr_mass") String[] ingrMass,
								  @RequestParam(value = "tn_firstname") int[] cookTime,
								  @RequestParam(value = "tn_lastname") String[] cookery,
								  @RequestParam(value = "ingr_number") int[] ingNo) {

		recipe.setChefId(chefId);
		recipe.setChefNick(chefNick);

		List<RecipeIngredient> ingredientList = new ArrayList<RecipeIngredient>();
		
		for(int i =0;i<ingrName.length ;i++) {
			RecipeIngredient ingr = new RecipeIngredient(ingNo[i], ingrMass[i], ingrName[i], 0);
			ingredientList.add(ingr);
		}
		
		List<Map<String,String>> list = (List<Map<String,String>>)new Gson().fromJson(recipe.getCategory(), new TypeToken<List<Map<String,String>>>(){}.getType());
		
		if(!list.isEmpty()) {
			recipe.setCategory(list.get(0).get("value"));
		}
		
		recipe.setTimeline("");
		for(int i =0;i < cookTime.length ;i++) {
			
			if(i>0)
				recipe.setTimeline(recipe.getTimeline()+"⇔");
				
			recipe.setCookingTime(recipe.getCookingTime()+cookTime[i]);
			recipe.setTimeline(recipe.getTimeline() + cookTime[i]+"∮"+cookery[i]);
		}
		
		int result = recipeService.recipeUpdate(recipe,ingredientList);
		
		return "redirect:/";
	}
	
	//레시피 수정 폼 불러오기
	@PostMapping("/recipeUpdateFrm")
	public String recipeUpdateFrm(HttpSession session,
								@RequestParam("chefId")String chefId,
								@RequestParam("recipeNo")int recipeNo,
								Model model,
								RedirectAttributes reAttr) {
		
		Member member = (Member)session.getAttribute("memberLoggedIn");
		if(!member.getMemberId().equals(chefId)) {
			reAttr.addFlashAttribute("msg","다른 셰프의 레시피를 수정하려 했습니다.");
			return "redirect:/";
		}
		
		Recipe recipe = recipeService.selectRecipeOne(recipeNo,true);
		
		recipe.setIngredientList(recipeService.selectRecIngList(recipeNo));
		
		List<MenuCategory> categoryList = recipeService.selectCategoryList();
		
		model.addAttribute("categoryList", categoryList);
		model.addAttribute(recipe);
		
		return "recipe/recipeUpdateFrm";
	}
	
	//레시피 삭제
	@PostMapping("/recipeDelete")
	public String recipeDelete(HttpSession session,
							   @RequestParam("chefId")String chefId,
							   @RequestParam("recipeNo")int recipeNo,
							   RedirectAttributes reAttr) {
		
		Member member = (Member)session.getAttribute("memberLoggedIn");
		if(!member.getMemberId().equals(chefId)) {
			reAttr.addFlashAttribute("msg","다른 셰프의 레시피를 삭제하려 했습니다.");
			return "redirect:/";
		}
		
		int result = recipeService.deleteRecipe(recipeNo);
		
		reAttr.addFlashAttribute("msg",result>0?"레시피를 삭제 했습니다.":"레시피 삭제 실패");
		return "redirect:/";
	}
	
	//댓글, 답글 지우기
	@GetMapping("/deleteQuestion")
	public String deleteQuestion(@RequestParam("questionNo")int questionNo,
							  @RequestParam("recipeNo")int recipeNo) {
		
		int result = recipeService.deleteQuestion(questionNo);
		
		return "redirect:/recipe/recipe-details?recipeNo=" + recipeNo;
	}
	
	//문의, 답글 작성
	@PostMapping("/insertQuestion")
	public String insertQuestion(HttpSession session, 
								 RecipeQuestion question,
								 @RequestParam(value = "memberId", required = false)String memberId,
								 @RequestParam("chefId")String chefId) {
		
		Member member = (Member)session.getAttribute("memberLoggedIn");
		question.setMemberId(member.getMemberId());
		
		int result = recipeService.insertQuestion(question);
		
		if(result>0) {
			DingDong dd;
			
			if(null == memberId || memberId.equals(member.getMemberId())) {
				dd = new DingDong(0, chefId, member.getMemberNick()+"님께서 문의 하셨습니다.", "/recipe/recipe-details?recipeNo=" + question.getRecipeNo(), 1, null);
			}else if(chefId.equals(member.getMemberId())){
				dd = new DingDong(0, memberId, member.getMemberNick()+"님께서 답변 하셨습니다.", "/recipe/recipe-details?recipeNo=" + question.getRecipeNo(), 1, null);
			}else {
				dd = new DingDong(0, "sdmin", member.getMemberId()+"의 비정상적 문의 이용 감지.", "/recipe/recipe-details?recipeNo=" + question.getRecipeNo(), 1, null);
			}
			
			result = recipeService.insertDingDong(dd);
		}
		
		return "redirect:/recipe/recipe-details?recipeNo=" + question.getRecipeNo(); 
	}
	
	//댓글, 답글 지우기
	@GetMapping("/deleteReply")
	public String deleteReply(@RequestParam("replyNo")int replyNo,
							  @RequestParam("recipeNo")int recipeNo) {
		
		int result = recipeService.deleteReply(replyNo);
		
		return "redirect:/recipe/recipe-details?recipeNo=" + recipeNo;
	}
	
	//댓글, 답글 달기
	@PostMapping("/insertReply")
	public String insertReply(HttpSession session, RecipeReply reply) {
		
		Member member = (Member)session.getAttribute("memberLoggedIn");
		reply.setMemberId(member.getMemberId());
		
		int result = recipeService.insertReply(reply);
		
		return "redirect:/recipe/recipe-details?recipeNo=" + reply.getRecipeNo();
	}
	
	//레시피 뷰
	@GetMapping("/recipe-details")
	public String recipedetails(
							@RequestParam (value="dingdongNo", defaultValue="-1")int dingdongNo,
							@RequestParam("recipeNo")int recipeNo,
							  HttpServletRequest request,
							  HttpServletResponse response,
							  Model model) {
		
		if(dingdongNo != -1) {
			int result = mypageService.dingdongUpdate(dingdongNo);
			log.debug("dingResult={}",result);
		}
		
		//뷰 카운터를 위한 쿠키
		Cookie[] cookies = request.getCookies();
		String recipeCookieVal = "";
		boolean hasRead = false;
		
		if(cookies != null) {
			for(Cookie c : cookies) {
				String name = c.getName();
				String value = c.getValue();
				if("recipeCookie".equals(name)) {
					recipeCookieVal = value;
					if(value.contains("|"+ recipeNo +"|")) {
						hasRead=true;
						break;
					}
				}
						
			}
		}
		
		if(hasRead == false) {
			recipeCookieVal = recipeCookieVal + "|"+ recipeNo +"|";
			Cookie recipeCookie = new Cookie("recipeCookie",recipeCookieVal);
			recipeCookie.setMaxAge(7*24*60*60);
			recipeCookie.setPath(request.getContextPath()+"/recipe");
			response.addCookie(recipeCookie);
		}//쿠키 끝
		
		Member member = (Member)request.getSession().getAttribute("memberLoggedIn");
		Like l =null;
		Scrap s = null;
		
		
		if(member != null) {
			l = new Like(member.getMemberId(), recipeNo);
			
			l = recipeService.selectLikeOne(l);
			
			s = new Scrap(recipeNo, member.getMemberId(), null, null, null, null);
			
			s = recipeService.selectScrap(s);
		}
		log.debug("{}",l);
		
		Recipe recipe = recipeService.selectRecipeOne(recipeNo,hasRead);
		
		String chefProfile = recipeService.selectChefProfile(recipe.getChefId());
		
		recipe.setIngredientList(recipeService.selectRecIngList(recipeNo));
		
		List<IngredientMall> ingrMallList = recipeService.selectingrMallList(recipe.getIngredientList());
		
		List<Recipe> relationRecipes =recipeService.selectRelRecipeList(recipe); 
		
		List<RecipeReply> replyList = recipeService.selectReplyList(recipe.getRecipeNo());
		
		List<RecipeQuestion> questionList = recipeService.selectQuestionList(recipe.getRecipeNo());
		
		log.debug("{}",ingrMallList);
		
		log.debug("{}",relationRecipes);
		
		model.addAttribute("chefProfile",chefProfile);
		model.addAttribute("questionList", questionList);
		model.addAttribute("replyList",replyList);
		model.addAttribute("relationRecipes",relationRecipes);
		model.addAttribute("ingrMallList", ingrMallList);
		model.addAttribute("scrap",s);
		model.addAttribute("isLiked",l);
		model.addAttribute("recipe",recipe);
		
		return "/recipe/recipe-details";
	}
	
	//레시피 업로드 폼
	@GetMapping("/recipeUpload")
	public void recipeUpload(Model model) {
		List<MenuCategory> categoryList = recipeService.selectCategoryList();
		log.debug("{}",categoryList);
		model.addAttribute("categoryList", categoryList);
	}
	
	//레시피 업로드
	@PostMapping("/recipeUpload")
	public String recipeUpload(Recipe recipe,
							 @RequestParam(value = "chefId") String chefId,
							 @RequestParam(value = "chefNick") String chefNick,
							 @RequestParam(value = "uploadFile") MultipartFile uploadFile,
							 @RequestParam(value = "ingr_name") String[] ingrName,
							 @RequestParam(value = "ingr_mass") String[] ingrMass,
							 @RequestParam(value = "tn_firstname") int[] cookTime,
							 @RequestParam(value = "tn_lastname") String[] cookery,
							 @RequestParam(value = "ingr_number") int[] ingNo,
							 @ModelAttribute("memberLoggedIn")Member member) {
		
		recipe.setChefId(chefId);
		recipe.setChefNick(chefNick);
		
		if (!uploadFile.isEmpty()) {
			log.debug("{}",uploadFile.getOriginalFilename());
			
			//유튜브 서비스 이용을 위한 객체
			YouTube youtubeService = null;
			try {
				//서비스 이용을 위한 권한 얻기
				youtubeService = getService();
			} catch (GeneralSecurityException e1) {
				e1.printStackTrace();
			} catch (IOException e1) {
				e1.printStackTrace();
			}

			//유튜브에 제목, 내용등의 형식을 집어넣기 위한 객체
			Video video = new Video();
			
			//video객체에 넣기 위한 status객체
			VideoStatus status = new VideoStatus();
			
			//영상 공개 상태, 현재 일부 공개 상태
			status.setPrivacyStatus("unlisted");

			video.setStatus(status);
			
			//유튜브의 제목, 내용, 태그 등록을 위한 객체 
			VideoSnippet snippet = new VideoSnippet();
			
			//영상 제목
			snippet.setTitle(recipe.getVideoTitle());
			//영상 내용
			snippet.setDescription(recipe.getRecipeContent());
			
			//영상 태그
//        List<String> tags = new ArrayList<String>();
//        tags.add("이게");
//        tags.add("되면");
//        tags.add("좋겠다.");
//        snippet.setTags(tags);

			video.setSnippet(snippet);

			// TODO: For this request to work, you must replace "YOUR_FILE"
			// with a pointer to the actual file you are uploading.
			// The maximum file size for this operation is 128GB.
			// File mediaFile = new
			// File(httpRequest.getServletContext().getRealPath("resources"),"KakaoTalk_Video_20190719_1734_13_287.mp4");
			//업로드한 영상을 등록할 객체, 영상 최대 크기는 128GB
			InputStreamContent mediaContent;
			try {
				mediaContent = new InputStreamContent("video/*", new BufferedInputStream(uploadFile.getInputStream()));
				mediaContent.setLength(uploadFile.getSize());

				//영상 업로드 API 선언
				YouTube.Videos.Insert request = youtubeService.videos().insert("snippet,statistics,status", video,
						mediaContent);
				
				//영상 업로드 API 실행
				Video response = request.execute();
				
				//업로드한 유튜브 ID를 레시피 객체에 등록
				recipe.setVideoLink(response.getId());
				
			} catch (FileNotFoundException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		
		
		
		//레시피 재료 리스트 작성 과정
		List<RecipeIngredient> ingredientList = new ArrayList<RecipeIngredient>();
		
		for(int i =0;i<ingrName.length ;i++) {
			RecipeIngredient ingr = new RecipeIngredient(ingNo[i], ingrMass[i], ingrName[i], 0);
			ingredientList.add(ingr);
		}

		//json으로 된 레시피 분류(한식/국물요리 등)를 해체하는 과정
		List<Map<String,String>> list = (List<Map<String,String>>)new Gson().fromJson(recipe.getCategory(), new TypeToken<List<Map<String,String>>>(){}.getType());
		
		if(!list.isEmpty()) {
			recipe.setCategory(list.get(0).get("value"));
		}
		
		//레시피 타임라인 등록
		recipe.setTimeline("");
		for(int i =0;i < cookTime.length ;i++) {
			
			if(i>0)
				recipe.setTimeline(recipe.getTimeline()+"⇔");
			
			recipe.setCookingTime(recipe.getCookingTime()+cookTime[i]);
			recipe.setTimeline(recipe.getTimeline() + cookTime[i]+"∮"+cookery[i]);
		}
		
		//레시피 및 레시피 재료를 DB에 등록
		int result = recipeService.recipeUpload(recipe,ingredientList);
		
		if(result<=0)
			return "redirect:/recipe/recipeUpload";
		
		return "redirect:/recipe/recipe-details?recipeNo=" + recipe.getRecipeNo();
	}

	@GetMapping("/recipeUpdate")
	public void recipeUpdate(@RequestParam("chefNickName")String chefNickName,
							 Model model) {
		List<Recipe> recipeList = recipeService.recipeSelectAll(chefNickName);
		
		model.addAttribute("recipeList", recipeList);
	}
	
	//메뉴검색 페이지 요청 시 인기영상과 메뉴 카테고리 가져가기
	@GetMapping("/recipe-menu-search")
	public ModelAndView recipemenusearch(ModelAndView mav, HttpSession session) {
		List<RecipeWithIngCnt> popRecipe = recipeService.selectPopRecipe();
		
		session.setAttribute("popRecipe", popRecipe);
		mav.setViewName("recipe/recipe-menu-search");
		
		return mav;
	}
	
	//레시피 페이지 이동 -냉부
	@GetMapping("/ingredientsSelection")
	public ModelAndView selectedIngredientsList(ModelAndView mav) {
		
		List<RecipeWithIngCnt> popRecipe = recipeService.selectPopRecipe();
		log.debug(popRecipe.toString());
		mav.addObject("popRecipe", popRecipe);
		mav.setViewName("recipe/ingredientsSelection");
		
		return mav;
	}
	
	//중분류카테고리 가져오기 처리용 -냉부
	@GetMapping("getSubCtg")
	@ResponseBody
	public List<String> selectIngSubCtg(String mainCtg) {
		log.debug("mainCtg = dd{}", mainCtg);
		
		List<String> subCtgList = recipeService.selectIngSubCtg(mainCtg);
		
		subCtgList.add(0, "인기재료"); //자동으로 이벤트 처리되어 인기재료소환함, 다른 ajax에의해서
		
		log.debug("controller list={}", subCtgList.toString());
		return subCtgList;
	}
	
	//레시피 업로드 폼에서 재료명 가져오기 위한 에이잭스
	@GetMapping(value = "/{ingredient}/ajax", produces = "text/plain;charset=UTF-8")
	@ResponseBody
	public String ingredientAjax(@PathVariable("ingredient") String ingr) {
		log.debug(ingr);
		if(ingr == null || ingr.equals("")) {
			return "[]";
		}
		
		List<Ingredient> list = recipeService.ingredientAjax(ingr); 
		
		JsonArray jArray = new JsonArray();
		for(Ingredient i : list) {
			JsonObject jObj = new JsonObject();
			jObj.addProperty("ingredientName", i.getIngredientName());
			jObj.addProperty("ingredientNo", i.getIngredientNo());
			jArray.add(jObj);
		}
		Gson gson = new GsonBuilder().disableHtmlEscaping().create();
		log.debug("{}",list);
		log.debug(gson.toJson(jArray));
		return gson.toJson(jArray);
	}
	
	//레시피 뷰에서 좋아요
	@GetMapping(value = "/{memberId}/like/{recipeNo}", produces = "text/plain;charset=UTF-8")
	@ResponseBody
	public String insertLike(@PathVariable("memberId")String memberId,
							 @PathVariable("recipeNo")int recipeNo) {
		log.debug("like");
		
		Like like = new Like(memberId, recipeNo);
		int result = recipeService.insertLike(like);
		
		return result>0?"t":"f";
	}
	
	//레시피 뷰에서 좋아요 취소
	@GetMapping(value = "/{memberId}/unlike/{recipeNo}", produces = "text/plain;charset=UTF-8")
	@ResponseBody
	public String deleteLike(@PathVariable("memberId")String memberId,
							 @PathVariable("recipeNo")int recipeNo) {
		log.debug("unlike");
		
		Like like = new Like(memberId, recipeNo);
		int result = recipeService.deleteLike(like);
		
		return result>0?"t":"f";
	}

	//레시피 뷰 스크랩 해제
	@GetMapping(value = "/unscrap/{recipeNo}", produces = "text/plain;charset=UTF-8")
	@ResponseBody
	public String deleteScrap(HttpSession session,
						 	  @PathVariable("recipeNo")int recipeNo) {
		log.debug("unscraped");
		log.debug("{}",(Member)session.getAttribute("memberLoggedIn"));
		Scrap scrap = new Scrap(recipeNo, ((Member)session.getAttribute("memberLoggedIn")).getMemberId(), null, null, null, null);
		
		log.debug("{}",scrap);
		
		int result = recipeService.deleteScrap(scrap);
		
		return result>0?"t":"f";
	}
	
	//레시피 뷰 스크랩
	@GetMapping(value = "/scrap/{recipeNo}", produces = "text/plain;charset=UTF-8")
	@ResponseBody
	public String insertScrap(HttpSession session,
						 	  @PathVariable("recipeNo")int recipeNo,
						 	  @RequestParam("memo")String memo) {
		log.debug("scraped");
		log.debug("{}",(Member)session.getAttribute("memberLoggedIn"));
		Scrap scrap = new Scrap(recipeNo, ((Member)session.getAttribute("memberLoggedIn")).getMemberId(), null, memo, null, null);
		
		log.debug("{}",scrap);
		
		int result = recipeService.insertScrap(scrap);
		
		return result>0?"t":"f";
	}
	
	
	/*
	 * Copyright 2020 the original author or authors.
	 *
	 * Licensed under the Apache License, Version 2.0 (the "License");
	 * you may not use this file except in compliance with the License.
	 * You may obtain a copy of the License at
	 *
	 *      https://www.apache.org/licenses/LICENSE-2.0
	 *
	 * Unless required by applicable law or agreed to in writing, software
	 * distributed under the License is distributed on an "AS IS" BASIS,
	 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
	 * See the License for the specific language governing permissions and
	 * limitations under the License.
	 */
	private static final String CLIENT_SECRETS= "/client_secret.json";
    private static final Collection<String> SCOPES =
        Arrays.asList("https://www.googleapis.com/auth/youtube.upload");
    	

    private static final String APPLICATION_NAME = "레시피 등록";
    private static final JsonFactory JSON_FACTORY = JacksonFactory.getDefaultInstance();

    /**
     * Create an authorized Credential object.
     *
     * @return an authorized Credential object.
     * @throws IOException
     */
    //유튜브 등록 전 권한 받기
    public static Credential authorize(final NetHttpTransport httpTransport) throws IOException {
        // Load client secrets.
    	
        InputStream in = RecipeController.class.getResourceAsStream(CLIENT_SECRETS);
        GoogleClientSecrets clientSecrets =
          GoogleClientSecrets.load(JSON_FACTORY, new InputStreamReader(in));
        
        // Build flow and trigger user authorization request.
        GoogleAuthorizationCodeFlow flow =
            new GoogleAuthorizationCodeFlow.Builder(httpTransport, JSON_FACTORY, clientSecrets, SCOPES).build();
        
        Builder localBuilder =  new LocalServerReceiver.Builder().setHost("localhost").setPort(20202);

        LocalServerReceiver local = localBuilder.build();

        AuthorizationCodeInstalledApp authoApp = new AuthorizationCodeInstalledApp(flow, local);

        //여기서 걸린다!
        Credential credential = authoApp.authorize("user");

        return credential;
    }

    /**
     * Build and return an authorized API client service.
     *
     * @return an authorized API client service
     * @throws GeneralSecurityException, IOException
     */
    //유튜브 권한 요청 및 유튜브 객체 제작
    public static YouTube getService() throws GeneralSecurityException, IOException {
    	
        final NetHttpTransport httpTransport = GoogleNetHttpTransport.newTrustedTransport();
        Credential credential = authorize(httpTransport);
        
        return new YouTube.Builder(httpTransport, JSON_FACTORY, credential)
            .setApplicationName(APPLICATION_NAME)
            .build();
    }
	
	//중분류 선택에 따른 재료가져오기 처리
	@GetMapping(value ="getIng", produces="text/plain;charset=UTF-8")
	@ResponseBody
	public String selectIngredients(@RequestParam(value="cPage", defaultValue="1") int cPage, String subCtg, String mainCtg, HttpServletRequest request ) {
		
		Map<String, Object> maps = new HashMap<>();
				List<Ingredient> ingList = new ArrayList<>();
		
		maps.put("mainCtg", mainCtg);
		maps.put("subCtg", subCtg);
		
		if(subCtg.equals("인기재료")) {
			if(maps.get("subCtg").equals("인기재료"))
			maps.put("subCtg", null);
			if(maps.get("mainCtg").equals("인기재료"))
			maps.put("mainCtg", null);
			
			log.debug(" 카테고리 설정 받아온값 mainCtg=={} subCtg== {}", mainCtg, subCtg);
			log.debug(" 카테고리 설정 후 mainCtg=={} subCtg== {}", maps.get("mainCtg"), maps.get("subCtg"));
			ingList = recipeService.selectPopIngredient(maps); 
		}else {
			ingList = recipeService.selectIngredients(subCtg, cPage, NUMPERPAGE);
		}
		log.debug("controller list={}", ingList.toString());
		log.debug("subCtg============{}", subCtg);
		
		//서브카태고리 재료 총 갯수 조회
		int ingCnt = recipeService.selectIngredientsCnt(subCtg);
		
		//카테고리 갯수에 따른 페이징 여부 (12개 이하일 경우 페이징 하지 않음)
		if(ingCnt > 12) {
			ingCnt = (int)Math.ceil((double)ingCnt/12);
		} else {
			ingCnt = 1;
		}
		
		//재료&페이징 맵에 담기
		maps.put("ingList", ingList);
		maps.put("ingCnt", ingCnt);
		maps.put("cPage", cPage);
		
		String gList = new Gson().toJson(maps);

		return gList;
	}
	
	
	@GetMapping("/report")
	@ResponseBody
	public String report(String memberId, int replyNo, Date dateReport, String memo) {
		
		Report rp = new Report(memberId, replyNo, dateReport , memo);
		
		Report rep = recipeService.selectReport(rp);
		
		String result = "";
		
		if(rep != null) {
			result = "신고한 내역이 있는 댓글은 신고접수를 할 수가 없습니다.";
		}
		else {
			int reportInsert = recipeService.insertReport(rp);
			
			if(reportInsert == 1) {
				result = "신고가 접수 되었습니다.";	
			}
		}
		
		String gsonresult = new Gson().toJson(result);
		 
		return gsonresult;
	}
	
	
	//선택한 재료로 레시피 검색하기
	@GetMapping(value="recipeSerachByIng", produces="text/plain;charset=UTF-8")
	@ResponseBody
	public String recipeSerachByIng(@RequestParam("ingNoArr[]") List<Integer> ingNoArr, @RequestParam(value="cPage", defaultValue="1") int cPage) {
		
		log.debug("ingredientNo======={}", ingNoArr);
		
		Map<String, Object> maps = new HashMap<>();
		maps.put("ingNoArr", ingNoArr);
		
		//키워드를 포함한 영상 총 갯수 조회
		int rcpCnt = recipeService.selectRecipeCnt(maps);
		
		//카테고리 갯수에 따른 페이징 여부 (12개 이하일 경우 페이징 하지 않음)
		if(rcpCnt > 12) {
			rcpCnt = (int)Math.ceil((double)rcpCnt/12);
		} else {
			rcpCnt = 1;
		}
		
		List<RecipeWithIngCnt> rlist = recipeService.recipeSerachByIng(maps, cPage, NUMPERPAGE);
		
		maps.put("recipeList", rlist);	
		maps.put("rcpCnt", rcpCnt);
		maps.put("cPage", cPage);
		return new Gson().toJson(maps);
		
	}
	
	//메뉴이름으로 레시피 검색하기
	@GetMapping(value="searchByMenu", produces = "text/plain;charset=UTF-8")
	@ResponseBody
	public String recipeSearchByMenu(@RequestParam("searchKey") String searchKey, @RequestParam(value="cPage", defaultValue="1") int cPage , String searchMCtg, String searchSCtg) {
		Map<String, Object> maps = new HashMap<>();
		
		log.debug("{}=====================searchKey", searchKey);
		log.debug("{}=====================ctgM", searchMCtg);
		log.debug("{}=====================ctgS", searchSCtg);
		maps.put("searchKey", searchKey);
		maps.put("searchMCtg", searchMCtg);
		maps.put("searchSCtg", searchSCtg);
		List<RecipeWithIngCnt> rList = recipeService.recipeSearchByMenu(maps, cPage, NUMPERPAGE);	
		
		int rcpCnt = recipeService.rcpCntByMenu(maps);
		
		//카테고리 갯수에 따른 페이징 여부 (12개 이하일 경우 페이징 하지 않음)
		if(rcpCnt > 12) {
			rcpCnt = (int)Math.ceil((double)rcpCnt/12);
		} else {
			rcpCnt = 1;
		}
		
		
		log.debug("죄회된 영상 리스트"+rList.toString());
	
		maps.put("searchKey", searchKey);	
		maps.put("searchedList", rList);
		maps.put("cPage", cPage);
		maps.put("rcpCnt", rcpCnt);
		
		
		return new Gson().toJson(maps);
	}
	
	//중분류카테고리 가져오기 처리용 -메뉴
	@GetMapping("getSubMenuCtg")
	@ResponseBody
	public List<String> selectMenuSubCtg(String mainCtg) {
		log.debug("mainCtg = dd{}", mainCtg);
		
		List<String> subCtgList = recipeService.selectMenuSubCtg(mainCtg);
	
		
		log.debug("controller list={}", subCtgList.toString());
		return subCtgList;
	}
}
