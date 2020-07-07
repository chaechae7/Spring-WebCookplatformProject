package com.soda.onn.chef.controller;

import java.io.File;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.Collections;
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
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.google.common.reflect.TypeToken;
import com.google.gson.Gson;
import com.soda.onn.chef.model.service.ChefService;
import com.soda.onn.chef.model.vo.Chef;
import com.soda.onn.chef.model.vo.ChefRequest;
import com.soda.onn.common.base.PageBar;
import com.soda.onn.common.util.ChefRequestUtils;
import com.soda.onn.mall.model.service.MallService;
import com.soda.onn.mall.model.vo.BuyHistory;
import com.soda.onn.member.model.vo.Member;
import com.soda.onn.member.model.vo.Notice;
import com.soda.onn.mypage.model.service.MypageService;
import com.soda.onn.mypage.model.vo.DingDong;
import com.soda.onn.mypage.model.vo.Scrap;
import com.soda.onn.oneday.model.service.OnedayService;
import com.soda.onn.oneday.model.vo.Oneday;
import com.soda.onn.oneday.model.vo.Reservation;
import com.soda.onn.oneday.model.vo.ReservationRequest;
import com.soda.onn.recipe.model.service.RecipeService;
import com.soda.onn.recipe.model.vo.Recipe;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/chef")
public class ChefController {

	@Autowired
	private ChefService chefservice;
	
	@Autowired
	private RecipeService recipeService;
	
	@Autowired
	private OnedayService onedayService;
	
	@Autowired
	private MallService mallService;
	
	@Autowired
	private MypageService mypageService;
	
	final int NUMPERPAGE = 15;
	final int PAGEBARSIZE = 10;
	
	private RowBounds rowBounds = null;
	
	@GetMapping("/chefMain")
	public void mypagechefMain() {
		log.debug("셰프 마이페이지 메인 첫 화면 입니다");
	}
	
	//셰프도 원데이클래스 예약하고 목록들을 보는 뷰
	@GetMapping("/onedayList")
	public void onedayList(HttpSession session, 
						   Model model,
						   @RequestParam(value="cPage", defaultValue="1") int cPage) {
		int numPerPage = 15;
		Member member = (Member)session.getAttribute("memberLoggedIn");
		String memberId = member.getMemberId();
		
		RowBounds rowBounds = new RowBounds((cPage-1)*numPerPage, numPerPage);
		List<ReservationRequest> reservationList = onedayService.selectReservationList(memberId,rowBounds);
		log.debug("reservationList={}",reservationList);
		model.addAttribute("reservationList", reservationList);
	}
	
	//자신의 클래스 예약현황
	@GetMapping("/reservationStatus")
	public ModelAndView reservationStatus(HttpSession session) {
		Member member = (Member)session.getAttribute("memberLoggedIn");
		String memberId = member.getMemberId();
		System.out.println("셰프 아이디 = "+memberId);
		
		List<ReservationRequest> statusList = onedayService.selectAllReservationList(memberId);
		
		ModelAndView mav = new ModelAndView();
		mav.addObject("statusList", statusList);
		System.out.println("셰프 원데이클래스 예약현황="+statusList);
		mav.setViewName("chef/reservationStatus");
		
		return mav;
	}
	
	
	//셰프가 구매한 목록
	@GetMapping("/chefbuyList")
	public void buyList(HttpSession session, Model model) {
		System.out.println("buyList 메소드입니다");
		
		Member member = (Member)session.getAttribute("memberLoggedIn");
		String memberId = member.getMemberId();
		
		List<BuyHistory> buyList = mallService.selectBuyList(memberId);
		log.debug("buyList={}",buyList);
		model.addAttribute("buyList", buyList);
	}
	
	//1:1문의사항
	@GetMapping("/qnaMsg")
	public void qnaMsg() {
		
	}
	
	//셰프가 스크랩한 목록들
	@GetMapping("/chefscrapList")
	public ModelAndView scrapList(HttpSession session, @RequestParam(value="cPage", defaultValue="1") int cPage, HttpServletRequest request) {
		
		log.debug("scrapList = {}", session);
		
		Member member = (Member)session.getAttribute("memberLoggedIn");
		String memberId = member.getMemberId();
		log.debug("scrapList memberId={}", memberId);
		
		ModelAndView mav = new ModelAndView();
		
		rowBounds = new RowBounds((cPage-1)*NUMPERPAGE, NUMPERPAGE);
		int pageStart = ((cPage - 1)/PAGEBARSIZE) * PAGEBARSIZE +1;
		int pageEnd = pageStart+PAGEBARSIZE-1;
		int totalCount = chefservice.selectChefRequestListCnt();
		int totalPage =  (int)Math.ceil((double)totalCount/NUMPERPAGE);
		String url = request.getRequestURL().toString();
		String paging = PageBar.Paging(url, cPage, pageStart, pageEnd, totalPage);
		
		List<Scrap> list = mypageService.selectScrapList(memberId, rowBounds);
		System.out.println("여기는 스크랩목록 = " + list);
		
		mav.addObject("list", list);
		mav.addObject("paging", paging);
		mav.setViewName("chef/chefscrapList");
		
		return mav;
	}
	
	//셰프 알림목록
	@GetMapping("/chefDingdongList")
	public ModelAndView dingdongList(HttpSession session) {
		ModelAndView mav = new ModelAndView();
		
		Member userId = (Member)session.getAttribute("memberLoggedIn");
		String memberId = userId.getMemberId();
		System.out.println("이곳은 알림목록 유저아이디 = "+memberId);
		
		Map<String,String> map =   new HashMap<String, String>();
		map.put("memberId", memberId);
		
		List<DingDong> list = mypageService.selectDingList(map);
		System.out.println("여기는 알림목록  = "+list);
		
		mav.addObject("list", list);
		mav.setViewName("/mypage/dingdongList");
		
		return mav;
	}
	
	@GetMapping("/sendDingdongList")
	public void sendDingdongList() {
		
	}
	
	// 셰프채널 메인 이동 
		@GetMapping("/chefList")
		public ModelAndView chefList() {
			ModelAndView mav = new ModelAndView();
			List<Chef> chefList = chefservice.selectChefAllList();
			
			
			for(Chef ch: chefList) {
				List<Map<String,String>> list = (List<Map<String,String>>) new Gson().fromJson(ch.getChefCategory(), 
												 new TypeToken<List<Map<String,String>>>(){}.getType());
				
				List<String> categoryList = new ArrayList<String>();
				
				for(Map<String,String> map: list) {
//		            log.debug(map.get("value"));
		            categoryList.add(map.get("value"));
		        }
				
				ch.setChefCategoryList(categoryList);
				
			}
			
	        
			log.debug("chefList ={}",chefList);
			mav.addObject("chefList", chefList);
			mav.setViewName("/chef/chefList");
			return mav;
		}
	
	
//	셰프 닉네임으로 검색 
	@GetMapping("chefSearch")
	public ModelAndView chefSearch(@RequestParam(value="chefsearchBar",required=true)String chefsearchbar,
								ModelAndView mav) {
		List<Chef> chefList = chefservice.chefSearch(chefsearchbar);
		
		for(Chef ch: chefList) {
			List<Map<String,String>> list = (List<Map<String,String>>) new Gson().fromJson(ch.getChefCategory(), 
											 new TypeToken<List<Map<String,String>>>(){}.getType());
			
			List<String> categoryList = new ArrayList<String>();
			
			for(Map<String,String> map: list) {
//	            log.debug(map.get("value"));
	            categoryList.add(map.get("value"));
	        }
				ch.setChefCategoryList(categoryList);
			
//			log.debug("{}",ch.getChefCategoryList());
		}
		log.debug("chefSearch={}",chefList);
		
		mav.addObject("chefList", chefList);
		mav.setViewName("/chef/chefList");
		return mav;
}
	
//	셰프 채널 이동 
	@GetMapping(value="/{memberNickName}/chefPage",
			    produces= "text/plain;charset=utf-8")
	@ResponseBody
	public ModelAndView chefPage(@PathVariable("memberNickName") String chefNickName,
						ModelAndView mav) {
		
		Chef chef = chefservice.chefSelectOne(chefNickName);
		String chefId = chef.getChefId();
		
		List<Recipe> recipeList = recipeService.recipeSelectAll(chefNickName);
		List<Notice> noticeList = chefservice.noticeSelectAll(chefId);
		List<Oneday> onedayList = chefservice.onedaySelectAll(chefId);
		List<Recipe> popList = new ArrayList<Recipe>();
		popList.addAll(recipeList);
		
		
		Collections.sort(popList);
		mav.addObject("onedayList",onedayList);
		mav.addObject("noticeList",noticeList);
		mav.addObject("recipeList", recipeList);
		mav.addObject("chef", chef);
	    mav.addObject("popList", popList);
		mav.setViewName("chef/chefPage");
		return mav;
	}
	
// 셰프공지사항 글쓰기 폼 이동 
	@GetMapping("/chefNotice")
	public void chefNotice(){
	}
	
// 셰프공지사항 글쓰기 Insert 이동 
	@PostMapping("/chefNotice")
	public String  chefNoticeInsert(Notice notice,
									Model model){
		
		
		int result = chefservice.chefNoticeInsert(notice);
		log.debug("notice@ = {}",notice);

//		redirectAttributes.addFlashAttribute(result>0?"공지사항 등록 완료!":"공지사항 등록 실패!");
		log.debug("result={}",result);
		
		String url = "";
		
		if(result <= 0) url = "redirect:/chef/chefNotice";
		else  url = "redirect:/chef/noticeView?noticeNo="+notice.getNoticeNo();
		
	    return url;
		
	}
		
   @GetMapping("/noticeView")
	public ModelAndView chefNoticeView(@RequestParam(value ="noticeNo")  int noticeNo,
										ModelAndView mav) {
		
		Notice notice  = chefservice.chefNoticeView(noticeNo);
		
		mav.addObject("notice", notice);
		mav.setViewName("chef/noticeView");
		return mav;
	}
	
// 셰프신청 폼이동 
	@GetMapping("/chefInsert")
	public void chefInsert() {
		
	}
	
//	셰프시청 완료 후 인덱스 페이지 이동 
	@PostMapping("/chefInsert")
	public String chefRequest(ChefRequest chefRequest,
							HttpServletRequest request,
							@RequestParam (value="facebook") String facebook,
							@RequestParam(value ="insta") String insta,
							@RequestParam(value="chefProfileimg",required=true) MultipartFile chefProfile,
							@RequestParam(value="chefApVideoimg", required=true) MultipartFile chefApVideo,
							@RequestParam(value="chefApRink", required=true) String chefApRink,
							RedirectAttributes redirectAttribute) {
		
		System.out.println(chefRequest);

		log.debug("menuPrCategory={}",chefRequest.getMenuPrCategory());
		
		// sns map객체 -> gson으로 넘김 
		Map<String,String> snsMap = new HashMap<String, String>();
		snsMap.put("facebook", facebook);
		snsMap.put("insta ", insta);

		Gson gson = new Gson();
		String snsGson = gson.toJson(snsMap);
		
		chefRequest.setSns(snsGson);
		
//		프로필 사진 리네임 정책 
		String profileOriginalFileName = chefProfile.getOriginalFilename();
		String profileRenamedFileName = ChefRequestUtils.getRenamedFileName(profileOriginalFileName, chefRequest.getChefNickName());
		String profileSaveDirectory = request.getServletContext().getRealPath("/resources/upload/profile");
		try {
			chefProfile.transferTo(new File(profileSaveDirectory,profileRenamedFileName));
		} catch (IllegalStateException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		} catch (IOException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		chefRequest.setChefProfile(profileRenamedFileName);
		
		log.debug("chefApVideo={}",chefApVideo);
		
//		비디오 영상을 받을 경우 
		if(chefApVideo.isEmpty()) {
			chefRequest.setChefApVideo(chefApRink);
		
		}else {

			//프로필 사진 닉네임으로 파일명 저장하기; 
			String chefAPVideoOriginalFileName = chefApVideo.getOriginalFilename();
	
			String videoRenamedFileName = ChefRequestUtils.getRenamedFileName(chefAPVideoOriginalFileName , chefRequest.getChefNickName());
			
			//파일 이동
			String chefApVideoSaveDirectory = request.getServletContext().getRealPath("/resources/upload/chefApVideo");
			try {
				chefApVideo.transferTo(new File(chefApVideoSaveDirectory,videoRenamedFileName));
			} catch (IllegalStateException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}
			chefRequest.setChefApVideo(videoRenamedFileName);
	
		}
	
			log.debug("chefApRink={}",chefApRink);
	

		int result = chefservice.chefRequest(chefRequest);
		String msg=result > 0 ? "셰프신청이 완료되었습니다.":"셰프신청에 실패하셨습니다.";
		redirectAttribute.addFlashAttribute("msg", msg);
		
		return "redirect:/";
	}
	
	@PostMapping("/noticeDelete")
	public String chefNoticeDelete(@RequestParam(value="noticeNo") int noticeNo,
								   @RequestParam(value="memberNickName") String memberNickName) {
		log.debug("memberNickName@Delete ={}",memberNickName);
		int result = chefservice.chefNoticeDelete(noticeNo);
		
		try {
			
			String nickName = URLEncoder.encode(memberNickName, "UTF-8");
			nickName = nickName.replaceAll("\\+", "%20");
			log.debug("memberNickName@Delete@@@@ ={}",nickName);
			return "redirect:/chef/"+nickName+"/chefPage";
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "redirect:/";
	}
	
	@PostMapping("/noticeUpdate")
	public String chefNoticeUpdate(Notice notice,
								   Model model) {
		model.addAttribute("notice", notice);
		return"chef/noticeUpdate";
	}
	
	@PostMapping("/noticeUpdateDone")
	public String chefNoticeUpdateDone(Notice notice) {
		log.debug("notice@Update={}",notice);
		int result = chefservice.chefnoticeUpdate(notice);
		return "redirect:/chef/noticeView?noticeNo="+notice.getNoticeNo();
	}
	
	@GetMapping("/chefPopList")
	@ResponseBody
	public List chefPopList(@RequestParam(value="nickname")String chefnick) {
		
		List<Recipe> recipeList = recipeService.recipeSelectAll(chefnick);
		log.debug("chefnick ={}",chefnick);
		log.debug("recipeList ={}",recipeList);
		
		
		return recipeList;
	}
}
