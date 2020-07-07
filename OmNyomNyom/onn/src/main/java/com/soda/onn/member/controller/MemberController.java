package com.soda.onn.member.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.soda.onn.common.base.PageBar;
import com.soda.onn.member.model.service.MemberService;
import com.soda.onn.member.model.vo.Member;

import lombok.extern.slf4j.Slf4j;
//import oracle.net.aso.i;

@Slf4j
@RequestMapping("/member")
@Controller
public class MemberController {

	@Autowired
	private MemberService memberService;

	@Autowired
	private BCryptPasswordEncoder bcrypt;
	
	//로그인요청
	@GetMapping("/login")
	public String login(@RequestParam("loginId") String memberId,
	    			    @RequestParam("loginPassword") String memberPwd,
	    			    HttpSession session,
	    			    RedirectAttributes redirectAttributes){
		log.debug("로그인 접근");
		Member member = memberService.selectOne(memberId);
		
		if(member != null) {
			log.debug("회원객체 존재");
			
			if(bcrypt.matches(memberPwd, member.getMemberPwd())) {
				session.setAttribute("memberLoggedIn", member);
				log.debug(member.getMemberNick()+"("+member.getMemberId()+")님이 로그인을 했습니다.");
			}else 
				session.setAttribute("msg", "입력한 아이디 또는 비밀번호가 일치하지 않습니다.");
			
			
		}else 
			session.setAttribute("msg", "입력한 아이디 또는 비밀번호가 일치하지 않습니다.");
		
		
		return "redirect:/";
	}

	
	@GetMapping("/logout")
	public String logout(HttpSession session) {
		Member member = (Member)session.getAttribute("memberLoggedIn");
		log.debug(member.getMemberNick()+"("+member.getMemberId()+")님이 로그아웃 하셨습니다.");
		
		session.removeAttribute("memberLoggedIn");
		
		return "redirect:/";
	}
	
	
	//회원가입용 AJAX 메소드
	@GetMapping("/enroll.do")
	@ResponseBody
	public Boolean enroll(@RequestParam("") String col,
					   @RequestParam("") String value) {
		
		Boolean chkBool = true;
		Map<String, String> map = new HashMap<String, String>();
		map.put(col, value);
		Member member = memberService.selectMember(map);
		if(member != null)
			chkBool = false;
			
		return chkBool;
	}	
	
	//회원가입요청
	@PostMapping("/enroll")
	public String enroll(Member member,
						 RedirectAttributes redirectAttributes) {
		
		ModelAndView mav = new ModelAndView();
		log.debug("member={}",member);
		String memberPwd = member.getMemberPwd();
		

		String bcryptPwd = bcrypt.encode(memberPwd);
		member.setMemberPwd(bcryptPwd);

		//회원추가
		int result = memberService.insertMember(member);
		
		String msg = "";
		if(result>0) msg = "회원가입에 성공하셨습니다!";
		else msg = "회원가입에 실패하셨습니다.";
		
		redirectAttributes.addFlashAttribute("msg", msg);
		//홈페이지로 보내주기
		return "redirect:/";
	}

	
	//회원가입 ajax 메소드
	@GetMapping("/checkMember/{key}/{value}")
	@ResponseBody
	public Map<String, String> checkId2(@PathVariable("key") String key, 
										@PathVariable("value") String value,
			Model model) {
		
		System.out.println("key = " + key);
		System.out.println("value = " + value);
		
		Map<String, String> map = new HashMap<String, String>();
		map.put(key, value);
		
		log.debug("회원가입 Ajax 진입");
		Member checkMember = memberService.selectMember(map);
			
		String isUsable = "";
		if(checkMember != null) {
			isUsable = "ok";
		}
		System.out.println("ok인가 아닌가 " + isUsable);
		map.put("isUsable", isUsable);
		
		return map;
	}
	
	//회원이 알림 읽었을 경우 (1 : 안 읽음, 0 : 읽음) 알림 읽음을 1 -> 0 변환
	@PutMapping("/dingdong/{memberId}")
	@ResponseBody
	public void dingdongAjax(@PathVariable("memberId") String memberId,
							 @RequestParam("dingdongNo") int dingdongNo){
		
		System.out.println("회원이 알림을 읽었습니다.");
		log.debug("memberId={}", memberId);
		log.debug("dongdongNo={}", dingdongNo);
		
		
		int dingdongRead = memberService.updateDingdong(dingdongNo);
	}
	
	//회원에게 알림이 추가 됐을 경우
	@PostMapping("/dingdong/{memberId}")
	@ResponseBody
	public void insertDingdong(@PathVariable("memberId") String memberId) {
		
		System.out.println("회원에게 알림이 추가 됐습니다.");
		log.debug("memberId={}", memberId);
		int dingdongPlus = memberService.insertDingdong(memberId);
		
	}
	
	//회원 알림
//	@GetMapping("dingdong/{size}")
//	@ResponseBody
//	public Map<String, Object> dingdongList(@PathVariable("size") String size,
//													@RequestParam(value="cPage", defaultValue="1") int cPage,
//													@RequestParam("memberId") String memberId,
//													HttpServletRequest request){
//		
//				System.out.println("회원 알림 메소드에 들어왔습니다");
//				
//				
//				Map<String, Object> resultMap =  new HashMap<String, Object>(); //값 가져온것, 페이징, rowbounds 넣기 위한 맵
//				Map<String, Object> pagingMap = new HashMap<String, Object>(); //페이징 처리하는 맵
//				Map<String, String> paramMap = new HashMap<String, String>();//파라미터 넣을 맵
//				List<DingDong> list = new ArrayList<DingDong>();
//
//				
//				System.out.println("dingdongList memberId = " + memberId);
//				System.out.println("dingdingList size = " + size);
//				
//				paramMap.put("memberId", memberId);
//				paramMap.put("size", size);
//				
//				
//				int NUMPERPAGE = 0;
//				int PAGEBARSIZE = 0;
//				
//					if(size.equals("small")) {
//						NUMPERPAGE = 5;
//						PAGEBARSIZE = 1;
//					}
//					else {
//						NUMPERPAGE = 15;
//						PAGEBARSIZE = 10;
//					}
//					
//				int pageStart = ((cPage - 1)/PAGEBARSIZE) * PAGEBARSIZE +1;
//				int pageEnd = pageStart+PAGEBARSIZE-1;
//					
//				RowBounds rowBounds = new RowBounds((cPage-1)*NUMPERPAGE, NUMPERPAGE);		
//				
//				int totalCount = memberService.selectDingdongListCnt();
//				System.out.println(totalCount);
//				
//				int totalPage =  (int)Math.ceil((double)totalCount/NUMPERPAGE);
//				String url = request.getRequestURL().toString()+"이 페이지에대한 링크";
//				String paging = PageBar.Paging(url, cPage, pageStart, pageEnd, totalPage);
//				
//				pagingMap.put("paging",paging);
//				
//				List<Map<String, String>> mapList = memberService.dingdongListTest(paramMap);
//				List<DingDong> reulstList = memberService.dingdongList(memberId, size);
//	
//				System.out.println(reulstList);
//				System.out.println(mapList);
//
//				resultMap.put("list", reulstList);
//				resultMap.put("mapList", mapList);
//				resultMap.put("pagingMap", pagingMap);
//				resultMap.put("rowBounds", rowBounds);
//					
//				return resultMap;
//	}
	
	
	@GetMapping("/memberInfo")
	public String memberInfo(@RequestParam("memberId") String memberId) {
		
		Member memberInfo = memberService.memberInfo(memberId);
		
		
		return null;
	}

}