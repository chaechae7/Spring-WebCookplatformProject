package com.soda.onn.mypage.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.RowBounds;
import org.mortbay.jetty.servlet.AbstractSessionManager.Session;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.google.gson.Gson;
import com.soda.onn.chef.model.service.ChefService;
import com.soda.onn.chef.model.vo.ChefRequest;
import com.soda.onn.common.base.PageBar;
import com.soda.onn.mall.model.service.MallService;
import com.soda.onn.mall.model.vo.BuyHistory;
import com.soda.onn.member.model.service.MemberService;
import com.soda.onn.member.model.vo.Member;
import com.soda.onn.mypage.model.service.MypageService;
import com.soda.onn.mypage.model.vo.DingDong;
import com.soda.onn.mypage.model.vo.Scrap;
import com.soda.onn.oneday.model.service.OnedayService;
import com.soda.onn.oneday.model.vo.Reservation;
import com.soda.onn.oneday.model.vo.ReservationRequest;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/mypage")
public class MypageController {

	@Autowired
	private MypageService mypageService;

	@Autowired
	private MallService mallService;

	@Autowired
	private ChefService chefService;

	@Autowired
	private OnedayService onedayService;
	
	@Autowired
	private MemberService memberService;
	
	final int NUMPERPAGE = 15;
	final int PAGEBARSIZE = 10;
	
	final int DINGNUMPERPAGE = 5;
	final int DINGPAGEBARSIZE = 10;
	
	private RowBounds rowBounds = null;

	
	public String paging(int cPage, String url) {
		
		int pageStart = ((cPage - 1)/PAGEBARSIZE) * PAGEBARSIZE +1;
		int pageEnd = pageStart+PAGEBARSIZE-1;
		int totalCount = mallService.selectBuyHistoryListCnt();
		int totalPage =  (int)Math.ceil((double)totalCount/NUMPERPAGE);
		
		return PageBar.Paging(url, cPage, pageStart, pageEnd, totalPage);
	}
	
	@GetMapping("/main")
	public void mypageMain() {
		log.debug("일반 유저 마이페이지 메인 첫 화면 입니다");
	}
		
	@GetMapping("/updateinfo")
	public String updateInfo(HttpSession session,
							 RedirectAttributes redirectAttributes,
							 Member member) {
		if(session.getAttribute("memberLoggedIn") != null) {
			
			Member loginUser = (Member) session.getAttribute("memberLoggedIn");
			member.setMemberId(loginUser.getMemberId());
			
			Map<String, Object> params = new HashMap<String, Object>();
			params.put("member", member);
			
			int updateInfo = memberService.updateInfo(params);			
			session.setAttribute("memberLoggedIn", memberService.selectOne(member.getMemberId()));
					
			redirectAttributes.addFlashAttribute("msg", updateInfo>0?"수정 성공!":"수정 실패!");	
		}
		
		return "redirect:/mypage/main";
	}
	
	//일반 유저의 구매목록들
	@GetMapping("/buyList")
	public ModelAndView buyList(@RequestParam (value="dingdongNo", defaultValue="-1")int dingdongNo,
			   					@RequestParam (value="cPage", defaultValue="1") int cPage,
			   					HttpServletRequest request,
								HttpSession session,
								Model model) {
		rowBounds = new RowBounds((cPage-1)*NUMPERPAGE, NUMPERPAGE);
		String url = request.getRequestURL().toString();
		String paging = paging(cPage, url);
		
		if(dingdongNo != -1) {
			int result = mypageService.dingdongUpdate(dingdongNo);
		}
		Member member = (Member)session.getAttribute("memberLoggedIn");
		String memberId = member.getMemberId();
		
		List<BuyHistory> buyList = mallService.selectBuyHistoryList(memberId, rowBounds);
		log.debug("buyList={}",buyList);
		ModelAndView mav = new ModelAndView();
		mav.addObject("buyList", buyList);
		mav.setViewName("mypage/buyList");
		return mav;
	}
	
	
	
	@GetMapping("/chefRequest")
	public void chefRequest(HttpSession session, Model model) {
		String memberId = (String) session.getAttribute("");
		ChefRequest chefRequest = chefService.selectChefRequest(memberId);
		log.debug("chefRequest={}",chefRequest);
		model.addAttribute("chefRequest", chefRequest);
	}
	
	@GetMapping("/onedayList")
	public void onedayList(@RequestParam (value="dingdongNo", defaultValue="-1")int dingdongNo,
						   HttpSession session, 
						   Model model,
						   @RequestParam(value="cPage", defaultValue="1") int cPage) {
		int numPerPage = 15;
		
		Member member = (Member)session.getAttribute("memberLoggedIn");
		String memberId = member.getMemberId();
		
		RowBounds rowBounds = new RowBounds((cPage-1)*numPerPage, numPerPage);
		List<ReservationRequest> reservationList = onedayService.selectReservationListUser(memberId,rowBounds);
		if(dingdongNo != -1) {
			int result = mypageService.dingdongUpdate(dingdongNo);
			log.debug("dingResult={}",result);
		}
		
		log.debug("reservationList={}",reservationList);
		model.addAttribute("reservationList", reservationList);
	}
	
	@GetMapping("/qnaMsg")
	public void qnaMsg() {
		
	}

	
	
	//일반유저 스크랩 목록
	@GetMapping("/scrapList")
	public ModelAndView scrapList(HttpSession session, @RequestParam(value="cPage", defaultValue="1") int cPage, HttpServletRequest request) {
		
		log.debug("scrapList = {}", session);
		
		Member member = (Member)session.getAttribute("memberLoggedIn");
		String memberId = member.getMemberId();
		log.debug("scrapList memberId={}", memberId);
		
		ModelAndView mav = new ModelAndView();
		
		rowBounds = new RowBounds((cPage-1)*NUMPERPAGE, NUMPERPAGE);
		int pageStart = ((cPage - 1)/PAGEBARSIZE) * PAGEBARSIZE +1;
		int pageEnd = pageStart+PAGEBARSIZE-1;
		int totalCount = chefService.selectChefRequestListCnt();
		int totalPage =  (int)Math.ceil((double)totalCount/NUMPERPAGE);
		String url = request.getRequestURL().toString();
		String paging = PageBar.Paging(url, cPage, pageStart, pageEnd, totalPage);
		
		List<Scrap> list = mypageService.selectScrapList(memberId, rowBounds);
		System.out.println("여기는 스크랩목록 = " + list);
		
		mav.addObject("list", list);
		mav.addObject("paging", paging);
		mav.setViewName("mypage/scrapList");
		
		return mav;
	}

	
	@GetMapping("/onedayReservation")
	public ModelAndView onedayReservation(HttpSession session) {
		ModelAndView mav = new ModelAndView();
		return mav;
	}
	
	//스크랩 삭제
	@GetMapping("/deleteScrap")
	public String deleteScrap(@RequestParam("recipeNo") int recipeNo,
							  RedirectAttributes redirectAttributes,
							  HttpSession session) {
		Member member = (Member)session.getAttribute("memberLoggedIn");
		String memberId = member.getMemberId();
		
		Map mmap = new HashMap();
		mmap.put("memberId", memberId);
		mmap.put("recipeNo", recipeNo);
		
		int result = mypageService.deleteScrap(mmap);
		redirectAttributes.addFlashAttribute("msg", result>0?"스크랩이 삭제 됐습니다.":"삭제 할 스크랩이 없습니다.");
		
		return "redirect:/mypage/scrapList";
	}
	
	//스크랩 메모 수정
	@GetMapping("updateScrap")
	public String updateScrap(Scrap scrap,
							  HttpSession session,
							  RedirectAttributes redirectAttributes) {

		Member scrapId = (Member)session.getAttribute("memberLoggedIn");
		log.debug("updateScrap scrapId.getMemberId()={}", scrapId.getMemberId());

		scrap.setScrapId(scrapId.getMemberId());
		log.debug("updateScrap scrap={}", scrap);
		
		int result = mypageService.updateScrap(scrap);
		log.debug("updateScrap result={}", result);
				
		redirectAttributes.addFlashAttribute("msg", result>0?"스크랩 메모 수정 성공.":"스크랩 메모 수정 실패.");
		
		return "redirect:/mypage/scrapList";
	}
	
	
	
	//알림 목록
		@GetMapping("/dingdongList")
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
	
		
		
///////////// 헤더 알림 -  김소현 영역 ///////////////////		
	//헤더 알림 목록
	@GetMapping("/dingDongList")
	@ResponseBody
	public Map dingdong(@RequestParam(value="cPage", defaultValue="1") int cPage,
					     HttpSession session,
			 			 HttpServletRequest request) {
	
		
		Member member = (Member)session.getAttribute("memberLoggedIn");
		String memberId=  member.getMemberId();
		log.debug("cPage={}",cPage);
		int pageStart = ((cPage - 1)/DINGPAGEBARSIZE) * DINGPAGEBARSIZE +1;
		int pageEnd = pageStart+PAGEBARSIZE-1;
		
		rowBounds = new RowBounds((cPage-1)*DINGNUMPERPAGE, DINGNUMPERPAGE);
		int totalCount = memberService.selectMemberListCnt();
		int totalPage =  (int)Math.ceil((double)totalCount/DINGNUMPERPAGE);
		String url = request.getRequestURL().toString();
		String paging = PageBar.Paging(url, cPage, pageStart, pageEnd, totalPage);
		Map<String,String> map =   new HashMap<String, String>();
		map.put("memberId", memberId);
		map.put("Read", "1");

		List<DingDong> dingList = mypageService.selectDingList(map);
		log.debug("dingList={}",dingList);

		
		Map mapp =new HashMap();
		
		mapp.put("dingList", dingList);
		return mapp;
	}
	
	
	@GetMapping("/directMsg")
	public void directMsg() {
		
	}
	

	
}
