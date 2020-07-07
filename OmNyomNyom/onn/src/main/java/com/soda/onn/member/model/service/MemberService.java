package com.soda.onn.member.model.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import com.soda.onn.member.model.vo.Member;

public interface MemberService {

	int insertMember(Member member);

	Member selectMember(Map<String, String> map);

	Member selectOne(String memberId);

	List<Member> selectMemberList(RowBounds rowBounds);

	int selectMemberListCnt();

	int updateDingdong(int dingdongNo);;

	int insertDingdong(String memberId);
	

	int selectDingdongListCnt();

	List<Map<String, String>> dingdongListTest(Map<String, String> paramMap);

	Member memberInfo(String memberId);

	int updateInfo(Map<String, Object> params);

	Member searchNick(String memberId);




	

	


	

	

}
