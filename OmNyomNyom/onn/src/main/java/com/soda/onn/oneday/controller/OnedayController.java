package com.soda.onn.oneday.controller;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.RowBounds;
import org.mortbay.log.Log;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.google.gson.Gson;
import com.soda.onn.chef.model.service.ChefService;
import com.soda.onn.chef.model.vo.Chef;
import com.soda.onn.common.base.PageBar;
import com.soda.onn.common.util.Utils;
import com.soda.onn.member.model.service.MemberService;
import com.soda.onn.member.model.vo.Member;
import com.soda.onn.mypage.model.service.MypageService;
import com.soda.onn.mypage.model.vo.DingDong;
import com.soda.onn.oneday.model.service.OnedayService;
import com.soda.onn.oneday.model.vo.Attachment;
import com.soda.onn.oneday.model.vo.Oneday;
import com.soda.onn.oneday.model.vo.OnedayReview;
import com.soda.onn.oneday.model.vo.OnedayTime;
import com.soda.onn.oneday.model.vo.Reservation;
import com.soda.onn.oneday.model.vo.ReservationRequest;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/oneday")
public class OnedayController {

	@Autowired
	private OnedayService onedayService;
	@Autowired
	private ChefService chefservice;
	@Autowired
	private MypageService mypageService;
	@Autowired 
	private MemberService memberService;

	
	final int NUMPERPAGE = 20;
	final int PAGEBARSIZE = 10;
	
	private RowBounds rowBounds = null;


	
//	원데이 클래스 메인뷰로 이동 
	@GetMapping("/oneday")
	public ModelAndView oneday(ModelAndView mav, HttpSession session) {
		
		log.debug("@oneday @ onedayController = 원데이클래스 메인페이지로 이동합니다!" );
		
		List<Oneday> AllList = onedayService.onedayselect(); 
		List<OnedayReview> reviewList = onedayService.reviewAll();
		List<Chef> chefList = chefservice.selectChefAllList();
		List<Oneday> popList = onedayService.popList();
		
		mav.addObject("popList", popList);
		mav.addObject("chefList", chefList);
		mav.addObject("reviewList", reviewList);
		mav.addObject("AllList", AllList);
		
		return mav;
	}
	
	
	
	
//	원데이 클래스 생성뷰로 이동
	@GetMapping("/class_insert")
	public void classinsert() {
		
		log.debug("oneday_insert @ onedayController = 원데이클래스 등록 페이지로 이동합니다!");
	}
	
//	클래스 관리 페이지로 이동
	@GetMapping("/class_manager")
	@ResponseBody
	public ModelAndView classManager(ModelAndView mav, HttpSession session) {
		log.debug("oneday_manager @ onedayController = 원데이클래스 관리페이지로 이동합니다!");
		String MemberNickName = ((Member) session.getAttribute("memberLoggedIn")).getMemberNick();
		Chef chef = chefservice.chefSelectOne(MemberNickName);
		String chefId = chef.getChefId();
		List<Oneday> onedayList = chefservice.onedaySelectAll(chefId);

		mav.addObject("onedayList",onedayList);
		return mav;
	}
	
//	원데이클래스 수정페이지로 이동
	@RequestMapping("/oneday_update")
	public ModelAndView classUpdateView(@ModelAttribute ModelAndView mav,
									RedirectAttributes redirectAttributes,
									HttpSession session,
									@RequestParam(value="onedayclassNo") int onedayclassNo) {
		log.debug("oneday_update @ controller = 원데이클래스 수정페이지로 이동합니다.");
		log.debug("update@onedayclassNo = "+onedayclassNo);
		String memberId = ((Member) session.getAttribute("memberLoggedIn")).getMemberId();
		
		Oneday oneday = onedayService.selectOne(onedayclassNo);
		
		List<OnedayTime> list = onedayService.selectTimeList(onedayclassNo);
		
		mav.addObject("memberId",memberId);
		mav.addObject("list", list);
		mav.addObject("oneday", oneday);
		
		return mav;
	}
//	원데이클래스 수정실행
	@PostMapping("/class_update")
	public ModelAndView classUpdate(@ModelAttribute Oneday oneday,
								   RedirectAttributes redirectAttributes,
								   @RequestParam(value="onedayTimeM", defaultValue = "0")int onedayTimeM,
								   @RequestParam(value="onedayImgFile", required = false) MultipartFile onedayImg,
								   @RequestParam(value="classdate") String[] onedayTimeList,
								   HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		
		log.debug("class_update @ controller = 원데이클래스 수정절차를 실행합니다.");
		
		
		List<Attachment> addImgList = new ArrayList<>();
		if(!onedayImg.isEmpty()) {
			String originalFileName = onedayImg.getOriginalFilename();
			String renamedFileName = Utils.getRenamedFileName(originalFileName);			
			
			//파일 이동시킴
			String saveDirectory = request.getServletContext().getRealPath("/resources/upload/onedayclass");
			
			try {
				
				onedayImg.transferTo(new File(saveDirectory, renamedFileName));
			} catch (IllegalStateException | IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
			//실제 데이터 -> db 저장
			Attachment addImg = new Attachment();
			addImg.setOriginalFileName(originalFileName);
			addImg.setRenamedFileName(renamedFileName);
			log.debug("classupdate @ addImg={}",addImg);
			addImgList.add(addImg);
			
			oneday.setOnedayImg(renamedFileName);
		}
		//이미지 확인
		log.debug("classupdate @ addImgList={}", addImgList);
		
		//String[]의 
		
		
		List<String> otiList = new ArrayList<String>(Arrays.asList(onedayTimeList));
	
		if(otiList != null) {
			for (int i=0; i<otiList.size(); i++) {
				System.out.println("classupdate @ otiList = "+ otiList.get(i));
			}
		}
		
		System.out.println("classupdate @ otiList = "+otiList);
		
		int result = onedayService.classUpdate(oneday, otiList);
		
		mav.addObject("onedayTimeM", onedayTimeM);
		log.debug("onedayclassNo="+ oneday.getOnedayclassNo());
		mav.setViewName("redirect:/oneday/oneday_detail?onedayclassNo="+oneday.getOnedayclassNo());
		return mav;
		
	} 

	
//  원데이클래스 삭제
	@PostMapping("/class_delete")
	public String classDelete(
								RedirectAttributes redirectAttributes,
								@RequestParam(value ="onedayclassNo")int onedayclassNo) {
		
		int result = onedayService.deleteOneday(onedayclassNo);
		
		String msg ="";
		
		redirectAttributes.addFlashAttribute("msg",result>0?"원데이클래스를 정상적으로삭제하였습니다.":"원데이클래스를 삭제하기 못하였습니다.");
		
		return "redirect:/oneday/class_manager";
		
	}
	
//	클래스 검색 결과뷰 로 이동 
	@RequestMapping("/oneday_All")
	public ModelAndView search(ModelAndView mav, 
							   @RequestParam(value="cPage", defaultValue="1") int cPage,
							   HttpServletRequest request) {
		
		
		log.debug("oneday_search @ ondayController = 원데이클래스 검색!");
		log.debug("oneday_search @ ondayController = 전체목록 조회!");
		
//		페이징 처리
		int pageStart = ((cPage - 1)/PAGEBARSIZE) * PAGEBARSIZE +1;
		int pageEnd = pageStart+PAGEBARSIZE-1;
		rowBounds = new RowBounds((cPage-1)*NUMPERPAGE, NUMPERPAGE);
		int totalCount = onedayService.selectOnedayclassListCnt();
		int totalPage =  (int)Math.ceil((double)totalCount/NUMPERPAGE);
		String url = request.getRequestURL().toString();
		String paging = PageBar.Paging(url, cPage, pageStart, pageEnd, totalPage);
		
		List<Chef> chefList = chefservice.selectChefAllList();
		List<Member> memberList = memberService.selectMemberList(rowBounds);
		
//		전체 리스트 조회
		List<Oneday> selectAllList = onedayService.selectAll(rowBounds);
		
		log.debug("chefList={}", chefList);
		
		mav.addObject("chefList", chefList);
		mav.addObject("memberList",memberList);
		mav.addObject("paging", paging);
		mav.addObject("selectAllList", selectAllList);
		mav.setViewName("oneday/oneday_All");
		return mav;
		
	}
	
//	클래스 검색
	@PostMapping("/oneday_search")
	public ModelAndView search(@ModelAttribute ModelAndView mav,
						@RequestParam(value = "menuList" , defaultValue="") String menuList,
						@RequestParam(value = "detailedAddr", defaultValue="")String detailedAddr,
						@RequestParam(value = "onedayName",defaultValue="")String onedayName,
						@RequestParam(value = "onedayTimeDate",defaultValue="") String onedayTimeDate,
						@RequestParam(value="cPage", defaultValue="1") int cPage,
						HttpServletRequest request) {
		
		Map<String, String> sec = new HashMap<>();
		sec.put("menuList", menuList);
		sec.put("detailedAddr", detailedAddr);
		sec.put("onedayName", onedayName);
		sec.put("onedayTimeDate", onedayTimeDate);
		
		
		List<Chef> chefList = chefservice.selectChefAllList();
		List<Member> memberList = memberService.selectMemberList(rowBounds);
		List<Oneday> list = onedayService.onedaySearch(sec);
		
		
		mav.addObject("chefList", chefList);
		mav.addObject("memberList",memberList);
		mav.addObject("list", list);
		mav.setViewName("oneday/oneday_search");
		return mav;
	}
	
//	원데이 클래스 디테일뷰 로 이동 
	@GetMapping("/oneday_detail")
	public void detail(@RequestParam(value="onedayclassNo") int onedayclassNo, Model model) {
	
		Oneday oneday = onedayService.selectOne(onedayclassNo);
		List<OnedayTime> list = onedayService.selectTimeList(onedayclassNo);
		List<OnedayReview> ReviewList = onedayService.selectReviewList(onedayclassNo);
		model.addAttribute("ReviewList", ReviewList);
		model.addAttribute("oneday", oneday);
		model.addAttribute("list", list);
	}

	
//	원데이 클래스 예약뷰로 이동 
	@PostMapping("/oneday_reservation")
	public ModelAndView reservation(@ModelAttribute ModelAndView mav,
									@ModelAttribute Reservation reservation,
									@ModelAttribute Oneday oneday,
									@ModelAttribute ReservationRequest reservationrequest,
									@RequestParam(value="onedayclassNo") int onedayclassNo,
									@RequestParam(value="onedayTimeNo" ) int onedayTimeNo,
									HttpSession session
									) {
		log.debug("클래스 넘버={}", onedayclassNo);
		log.debug("타임 넘버={}", onedayTimeNo);
		String memberId = ((Member) session.getAttribute("memberLoggedIn")).getMemberId();
			
//		reservation.setReserMemberId(memberId);
		Oneday oday= onedayService.selectOne(onedayclassNo);
		Oneday one = onedayService.selectOne(onedayclassNo);		
		reservationrequest.setReserMemberId(memberId);
		reservationrequest.setOnedayclassNo(onedayclassNo);
		reservationrequest.setOnedaytimeNo(onedayTimeNo);
		reservationrequest.setOneday(oday);

		System.out.println(reservationrequest);
		System.out.println(reservation);
		session.setAttribute("reservationrequest", reservationrequest);
		
		session.setAttribute("oneday", oday);
		
		mav.addObject("one", one);
		mav.addObject("reservationrequest", reservationrequest);
		
		return mav;
	}
	
	
	
	
//	원데이 클래스 예약 동의뷰로 이동 
	@GetMapping("/oneday_agree")
	public void agree() {
		
		
	}
//	원데이 클래스 예약 결제뷰로 이동 
	@GetMapping("/oneday_pay")
	public ModelAndView pay(@ModelAttribute ModelAndView mav,HttpSession session) {
		
		ReservationRequest reservationrequest = (ReservationRequest) session.getAttribute("reservationrequest");
		log.debug("onedayname ===={}", reservationrequest.getOneday());

		mav.addObject("reservationrequest", reservationrequest);
		mav.addObject("oneday", reservationrequest.getOneday());
		return mav;
		
	}
	
	
	//결제 요청 전 예약가능여부 확인 ajax요청
	@GetMapping("/checkvacancy")
	@ResponseBody
	public String checkVacancy(@RequestParam int onedayNo, @RequestParam int onedaytimeNo) {
		Map<String, Integer> maps =  new HashMap<>();
		maps.put("onedayNo", onedayNo);
		maps.put("onedaytimeNo", onedaytimeNo);
		int reserved = onedayService.checkVacancy(maps);
		maps.put("reserved", reserved);
		return new Gson().toJson(maps);
	}
	
	//결제 성공 시 자동으로 insert처리하기. ajax요청
	@PostMapping("/paycompletion")
	@ResponseBody
	public void insertReserv(@ModelAttribute ModelAndView mav, HttpSession session) {
		
		
		//결제 관련 정보 꺼내기
		ReservationRequest reservRequest = (ReservationRequest)session.getAttribute("reservationrequest");
		log.debug("reservationRequest===={}", reservRequest.toString());
		Member member = (Member)session.getAttribute("memberLoggedIn");
		
		reservRequest.setMemberId(member.getMemberId());
		//예약정보 insert
		int result = onedayService.insertReservation(reservRequest);
		session.setAttribute("reservationRequest", reservRequest);
		session.setAttribute("reservationInsertResult", result);
		String content =  "원데이 클래스 예약 알림: (예약번호 :"+reservRequest.getReservationNo()+")";
		//결제정보 알림 insert
		DingDong dd = new DingDong(-1, member.getMemberId(), content, "/mypage/onedayList" , 1, null);
		int ddResult = mypageService.insertPayDing(dd);
		log.debug("dingdongInsertResult======================", ddResult);
		
	}
	
	
//	원데이 클래스 예약완료 뷰로 이동 
	@GetMapping("/result")
	public ModelAndView result(@ModelAttribute ModelAndView mav, HttpSession session) {
		Oneday oneday = (Oneday)session.getAttribute("oneday");
		
		Member chefInfo = memberService.searchNick(oneday.getMemberId());
		//세션에서 예약정보와 원데이정보 삭제 및 mav에담기.
		mav.addObject("reservationrequest", (ReservationRequest)session.getAttribute("reservationrequest"));
		mav.addObject("oneday", oneday);
		mav.addObject("chefNick", chefInfo);
		
		mav.setViewName("/oneday/oneday_result");
		session.removeAttribute("reservationrequest");
		session.removeAttribute("oneday");
		
		
		return mav;
		
	}
	
	//원데이클래스 Insert 하기
	@PostMapping("/insert.do")
	public ModelAndView insert(@ModelAttribute Oneday oneday, 
											   ModelAndView mav,
											   RedirectAttributes redirectAttributes,
							   @RequestParam(value="onedayTimeM", defaultValue = "0")int onedayTimeM,
							   @RequestParam(value="onedayImgFile", required = false) MultipartFile onedayImg,
							   @RequestParam(value="classdate") String[] onedayTimeList,
							   HttpSession session,
							   HttpServletRequest request) {
		log.debug("원데이클래스 등록 절차를 시작합니다!");
		String memberId = ((Member) session.getAttribute("memberLoggedIn")).getMemberId(); 
		String memberNickName = ((Member) session.getAttribute("memberLoggedIn")).getMemberNick();
		
		//파일 처리
		List<Attachment> addImgList = new ArrayList<>();
		if(!onedayImg.isEmpty()) {
			String originalFileName = onedayImg.getOriginalFilename();
			String renamedFileName = Utils.getRenamedFileName(originalFileName);			
			
			//파일 이동시킴
			String saveDirectory = request.getServletContext().getRealPath("/resources/upload/onedayclass");
			
			try {
				
				onedayImg.transferTo(new File(saveDirectory, renamedFileName));
			} catch (IllegalStateException | IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
			//실제 데이터 -> db 저장
			Attachment addImg = new Attachment();
			addImg.setOriginalFileName(originalFileName);
			addImg.setRenamedFileName(renamedFileName);
			log.debug("addImg={}",addImg);
			addImgList.add(addImg);
			
			oneday.setOnedayImg(renamedFileName);
		}
		//이미지 확인
		log.debug("addImgList={}", addImgList);
		
		//String[]의 
		
		

		List<String> otiList = new ArrayList<String>(Arrays.asList(onedayTimeList));
		
		if(otiList != null) {
			for (int i=0; i<otiList.size(); i++) {
				System.out.println(otiList.get(i));
			}
		}
		
		System.out.println(otiList);
		
		
		
		int result = onedayService.insertOneday(oneday, otiList);
//		원데이클래스 개설 
		log.debug("oneday={}" + oneday);
		
		
		String msg = "";
		Log.debug("result+"+result);
		redirectAttributes.addFlashAttribute("msg", result>0?"원데이 클래스 등록완료!":"원데이클래스 등록실패!");
		
		//requestParam으로 value값, defaultValue 값 => 변수 선언해줌
		
		mav.addObject("memberNickName", memberNickName);
		mav.addObject("memberId", memberId);
		mav.addObject("onedayTimeM", onedayTimeM);
		mav.setViewName("redirect:/oneday/oneday_detail?onedayclassNo="+oneday.getOnedayclassNo());
		
		return mav;
	}
	
	@GetMapping("class_reviewWrite_go")
	public ModelAndView ReiveWrite( @ModelAttribute ModelAndView mav,
													HttpSession session,
									@RequestParam(value="onedayclassNo") int onedayclassNo) {
		String memberId = ((Member) session.getAttribute("memberLoggedIn")).getMemberId();
		log.debug("reviewWrite@ Controller= 리뷰작성페이지로 이동합니다.");
		log.debug("reivewWrite@onedayclassNo ="+ onedayclassNo);
		log.debug("reivewWrite@memberId ="+ memberId);
		
		
		
		mav.addObject("onedayclassNo", onedayclassNo);
		return mav;
	}
	
	
	
	@PostMapping("reviewWrite")
	public ModelAndView ReviewWrite(@ModelAttribute OnedayReview onedayReview, 
									@ModelAttribute ReservationRequest reservationRequest,
									ModelAndView mav, 
									HttpSession session,
									RedirectAttributes redirectAttributes,
									@RequestParam(value="onedayclassNo") int onedayclassNo
									
									) {
		String memberId = ((Member) session.getAttribute("memberLoggedIn")).getMemberId();
		
		log.debug("reviewWrite @ memberId = "+memberId);
		log.debug("reviewWrite @ onedayclassNo = " + onedayclassNo);
		
		
		
		int result = onedayService.insertReview(onedayReview);
		
		log.debug("controller@onedayReview={}", onedayReview);
		
		String msg="";
		redirectAttributes.addFlashAttribute("msg",result>0?"후기 등록완료!":"후기 등록실패!");
		
		mav.addObject("memberId", memberId);
		mav.setViewName("redirect:/oneday/oneday_detail?onedayclassNo="+onedayclassNo);
		return mav;
	}
	

	
	
	
	
	
	
	
}
