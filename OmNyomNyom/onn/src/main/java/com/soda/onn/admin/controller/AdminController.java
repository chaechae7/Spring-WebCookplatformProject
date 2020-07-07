package com.soda.onn.admin.controller;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import com.soda.onn.admin.model.service.AdminService;
import com.soda.onn.chat.model.service.ChatService;
import com.soda.onn.chef.model.service.ChefService;
import com.soda.onn.chef.model.vo.Chef;
import com.soda.onn.chef.model.vo.ChefRequest;
import com.soda.onn.common.base.PageBar;
import com.soda.onn.mall.model.service.MallService;
import com.soda.onn.mall.model.vo.BuyHistory;
import com.soda.onn.mall.model.vo.Ingredient;
import com.soda.onn.mall.model.vo.IngredientMall;
import com.soda.onn.member.model.service.MemberService;
import com.soda.onn.member.model.vo.Member;
import com.soda.onn.mypage.model.service.MypageService;
import com.soda.onn.oneday.model.service.OnedayService;
import com.soda.onn.oneday.model.vo.OnedayReview;
import com.soda.onn.oneday.model.vo.ReservationRequest;
import com.soda.onn.recipe.model.service.RecipeService;
import com.soda.onn.recipe.model.vo.Report;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/admin")
public class AdminController {

	@Autowired
	private AdminService adminService;

	@Autowired
	private ChefService chefService;
	
	@Autowired
	private MypageService mypageService;
	
	@Autowired
	private OnedayService onedayService;

	@Autowired
	private MemberService memberService;

	@Autowired
	private MallService mallService;

	@Autowired
	private ChatService chatService;
	
	@Autowired
	private RecipeService recipeService;
	
	final int NUMPERPAGE = 15;
	final int PAGEBARSIZE = 10;

	
	private RowBounds rowBounds = null;
	
	public String paging(int cPage, String url) {
		
		int pageStart = ((cPage - 1)/PAGEBARSIZE) * PAGEBARSIZE +1;
		int pageEnd = pageStart+PAGEBARSIZE-1;
		int totalCount = mallService.selectBuyHistoryListCnt();
		int totalPage =  (int)Math.ceil((double)totalCount/NUMPERPAGE);
		
		return PageBar.Paging(url, cPage, pageStart, pageEnd, totalPage);
	}
	
	@GetMapping("/adminMain")
	public void mypageadminMain() {
		log.debug("관리자 마이페이지 메인 첫 화면 입니다");
	}
	
	@GetMapping("/adminQnaMsg")
	public void adminQnaMsg() {
		
	}
	
	@GetMapping("/chefInsertList")
	public void chefInsertList(HttpSession session) {
		
	}
	
	@GetMapping("/sendDingdong")
	public void sendDingdong() {
		
	}
	
	//셰프목록
	@GetMapping("/chefList")
	public ModelAndView chefList() {
		ModelAndView mav = new ModelAndView();
		
		List<Chef> chefList = chefService.selectChefAllList();
		mav.addObject("chefList", chefList);
		mav.setViewName("admin/chefList");
		
		return mav;
	}
	
	@GetMapping("buyList")
	public void buyList(Model model,
						@RequestParam(value = "cPage",defaultValue = "1") int cPage,
						HttpServletRequest request) {

		rowBounds = new RowBounds((cPage-1)*NUMPERPAGE, NUMPERPAGE);
		String url = request.getRequestURL().toString();
		String paging = paging(cPage, url);
		
		List<BuyHistory> buyHisotyList = mallService.selectBuyHistoryList(rowBounds);
		
		model.addAttribute("paging", paging);
		model.addAttribute("buyHisotyList", buyHisotyList);
	}
	
	//셰프신청목록
	@GetMapping("/chefRequestList")
	public ModelAndView chefRequestList(@RequestParam(value="cPage", defaultValue="1") int cPage, 
										HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		
		rowBounds = new RowBounds((cPage-1)*NUMPERPAGE, NUMPERPAGE);
		String url = request.getRequestURL().toString();
		String paging = paging(cPage, url);
		
		List<ChefRequest> chefRequestList = chefService.selectChefRequestList(rowBounds); 
		
		log.debug("chefRequestList={}",chefRequestList);
		mav.addObject("paging", paging);
		mav.addObject("chefRequestList", chefRequestList);
		mav.setViewName("admin/chefRequestList");
		
		return mav;
	}
		
	@GetMapping("/{memberId}/chefRequestView")
	public ModelAndView chefRequestView(@PathVariable(value="memberId")String memberId,
										ModelAndView mav) {
		
		ChefRequest chefRequest = chefService.selectChefRequest(memberId);
		log.debug("chefRequest@goView={}",chefRequest);
		
	    Gson gson = new Gson();
	    Map<String,String> snsMap = gson.fromJson(chefRequest.getSns(),  new TypeToken<Map<String,String>>(){}.getType());
	    List<Map<String,String>> categoryList = gson.fromJson(chefRequest.getMenuPrCategory(),  new TypeToken<List<Map<String,String>>>(){}.getType());
	    log.debug("snsMap={}",snsMap);
	    log.debug("categoryListMap={}",categoryList);
	    
	    
	    String categoryStr = "";
	    for(int i=0; i<categoryList.size(); i++) {
	    	String category = (categoryList.get(i)).get("value");
	    	categoryStr += ","+category;
	    }
	    mav.addObject("chefRequest", chefRequest);
	    mav.addObject("snsMap", snsMap);
	    mav.addObject("categoryStr", categoryStr);
		mav.setViewName("/admin/chefRequestView");
		return mav;
	}
		
	@PostMapping("/chefRequest")
	public String chefRequest(@RequestParam("variable") String variable,
							  @RequestParam("chefId") String memberId) {
		log.debug("셰프신청 수락여부 결정 진행중");
		log.debug("chefId={}",memberId);
		log.debug("variable={}",variable);
		Map<String, String> chefReq = new HashMap<>();
		chefReq.put("chefId",memberId);
		chefReq.put("variable",variable);
		
		
		ChefRequest chefreq = chefService.selectChefRequest(memberId);
		chefreq.setChefReqOk(variable);
		log.debug("chefreq chefid={}",chefreq);
		int result1 = chefService.chefRequestUpdate(chefreq);
		log.debug("result1={}",result1);
		return "redirect:/admin/chefRequestList";
	}

	//신고목록
	@GetMapping("/reportList")
	public ModelAndView reportList(@RequestParam (value="dingdongNo", defaultValue="-1") int dingdongNo,
								   @RequestParam (value="cPage", defaultValue="1") int cPage,
								  HttpServletRequest request) {
		rowBounds = new RowBounds((cPage-1)*NUMPERPAGE, NUMPERPAGE);
		String url = request.getRequestURL().toString();
		String paging = paging(cPage, url);

		List<Report> list = recipeService.selectReportList(rowBounds);
		
		if(dingdongNo != -1) {
			int result = mypageService.dingdongUpdate(dingdongNo);
		}
		ModelAndView mav = new ModelAndView();
		mav.addObject("list", list);
		mav.setViewName("admin/reportList");
		
		return mav;
	}
	//////	//////	//////	//////	//////	//////	//////	//////	//////	//////	//////	//////	

	//예약현황목록
	@GetMapping("/reservationList")
	public ModelAndView reservationList(@RequestParam(value="cPage", defaultValue="1") int cPage,
										HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		
		rowBounds = new RowBounds((cPage-1)*NUMPERPAGE, NUMPERPAGE);
		String url = request.getRequestURL().toString();
		String paging = paging(cPage, url);

		List<ReservationRequest> reservationList = onedayService.selectReservationList(null, rowBounds);
		
		mav.addObject("paging", paging);
		mav.addObject("reservationList", reservationList);
		mav.setViewName("admin/reservationList");
		
		return mav;
	}
	//////	//////	//////	//////	//////	//////	//////	//////	//////	//////	//////	//////	

	//재료목록
	@GetMapping("/ingredientList")
	public void ingredientList() {}
	
	//재료목록 Ajax
	@GetMapping("/ingredientList.ajax")
	@ResponseBody 
	public List<IngredientMall> ingredientListA(@RequestParam(value = "subCtg") String subCtg) {
		
		List<IngredientMall> ingredientList = mallService.selectIngredientList(subCtg);
		
		return ingredientList;
	}
	
	//재료 업데이트
	@PostMapping(value =  "/ingMallUpdate", produces = {"text/plain;charset=UTF-8","application/json" })
	@ResponseBody
	public String ingMallUpdate(@RequestParam("updateList") String updateList) {
		List<Map<String,String>> list = new Gson().fromJson(updateList, List.class);
		log.debug(list.toString());
		int result = mallService.updateIngMall(list); 
		return ""+result;
	}

		
	//회원목록
	@GetMapping("/memberList")
	public ModelAndView memberList(@RequestParam(value="cPage", defaultValue="1") int cPage,
								   HttpServletRequest request) {
		
		ModelAndView mav = new ModelAndView();
		
		rowBounds = new RowBounds((cPage-1)*NUMPERPAGE, NUMPERPAGE);
		String url = request.getRequestURL().toString();
		String paging = paging(cPage, url);
		
		List<Member> memberList = memberService.selectMemberList(rowBounds);
		
		mav.addObject("paging", paging);
		mav.addObject("memberList", memberList);
		mav.setViewName("admin/memberList");
		return mav;
	}
	//////	//////	//////	//////	//////	//////	//////	//////	//////	//////	//////	//////	

	//후기목록
	@GetMapping("/onedayReviewList")
	public void onedayReviewList(@RequestParam(value="cPage", defaultValue="1") int cPage,
								 HttpServletRequest request,
								 Model model) {
		
		rowBounds = new RowBounds((cPage-1)*NUMPERPAGE, NUMPERPAGE);
		String url = request.getRequestURL().toString();
		String paging = paging(cPage, url);

		List<OnedayReview> onedayReviewList = onedayService.selectOnedayReviewList(rowBounds);
		
		model.addAttribute("onedayReview", onedayReviewList);
		model.addAttribute("paging", paging);
	}
	//////	//////	//////	//////	//////	//////	//////	//////	//////	//////	//////	//////	

	@GetMapping("/ingredientInsert")
  	public void ingredientInsert() {
  		
  	}
	
	@GetMapping("prCategory")
	@ResponseBody
	public Map prCategory(@RequestParam(value="prCategory")String pr) {
		log.debug("pr={}",pr);
		String engPrcategory = mallService.prCategory(pr);
		List<String> subCtgList = recipeService.selectIngSubCtg(pr);
		log.debug(engPrcategory);
		log.debug("subCtgList={}",subCtgList);
		
		Map map = new HashMap();
		map.put("engPrcategory",engPrcategory);
		map.put("subCtgList",subCtgList);
		
		return map;
	}
	
	@GetMapping("crCategory")
	@ResponseBody
	public String crCategory(@RequestParam(value="crCategory")String cr) {
		
		String engCrcategory = mallService.crCategory(cr);

		return engCrcategory;
	}
			
	@PostMapping("/ingredientInsert")
  	public ModelAndView ingredientInsert(Ingredient ingredient , 
  								         IngredientMall ingredientMall,
  								         HttpServletRequest httpServletRequest,
  								         @RequestParam(value="engPrCategory") String engPrCategory,
  								         @RequestParam(value="engCrCategory") String engCrCategory,
  								         @RequestParam(value="ingFilename",required=false) MultipartFile ingFilename,
  								         @RequestParam(value="ingInfo", required=false) MultipartFile ingInfo,
  								         ModelAndView mav) {
		
		ingredient.setIngPrCategory(httpServletRequest.getParameter("ingPrCategory"));
		ingredient.setIngCdCategory(httpServletRequest.getParameter("ingcdCategory"));
		ingredient.setEngPrCategory(httpServletRequest.getParameter(engPrCategory));
		ingredient.setEngCdCategory(httpServletRequest.getParameter(engCrCategory));
		ingredient.setIngredientName(httpServletRequest.getParameter("ingredientName"));
//		재료 이미지 
		String ingFileName = ingFilename.getOriginalFilename();
		log.debug("ingFileName={}",ingFileName);
		String ingFileNameSaveDirectory = httpServletRequest.getServletContext().getRealPath("/resources/images/ingredient")+"/"+engPrCategory+"/"+engCrCategory;
		
		
		 try {
			ingFilename.transferTo(new File(ingFileNameSaveDirectory,ingFileName));
		} catch (IllegalStateException | IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		 ingredient.setIngFilename(ingFileName);
		log.debug("ingredient={}",ingredient);
		
		ingredientMall.setIngMallName(httpServletRequest.getParameter("ingredientName"));
		String ingInfoFileName = ingInfo.getOriginalFilename();
		String ingInfoSaveDirectory = httpServletRequest.getServletContext().getRealPath("/resources/images/mall");
		ingredientMall.setIngInfo(ingInfoFileName);
		try {
			ingInfo.transferTo(new File(ingInfoSaveDirectory,ingInfoFileName ));
		} catch (IllegalStateException | IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		ingredientMall.setPrice(Integer.parseInt((httpServletRequest.getParameter("price"))));
		ingredientMall.setStock(Integer.parseInt((httpServletRequest.getParameter("stock"))));
		ingredientMall.setMinUnit(httpServletRequest.getParameter("minUnit"));
		ingredientMall.setIngOrigin(httpServletRequest.getParameter("ingOrigin"));
		ingredientMall.setShelfLife(Integer.parseInt((httpServletRequest.getParameter("shelfLife"))));
		
		
		log.debug("ingredientMall={}",ingredientMall);
		
		int result = mallService.ingredientInsert(ingredientMall);
		int resultt = recipeService.ingredientInsert(ingredient);
		mav.setViewName("/admin/ingredientList");
		return mav;
  	}
}
