package com.soda.onn.member.model.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.soda.onn.member.model.dao.MemberDAO;
import com.soda.onn.member.model.vo.Member;

@Service
public class MemberServiceImpl implements MemberService{

	@Autowired
	private MemberDAO memberDAO;
	
	@Override
	public int insertMember(Member member) {
		return memberDAO.insertMember(member);
	}

	@Override
	public Member selectMember(Map<String, String> map) {
		return memberDAO.selectMember(map);
	}

	@Override
	public Member selectOne(String memberId) {
		return memberDAO.selectOne(memberId);
	}

	@Override
	public List<Member> selectMemberList(RowBounds rowBounds) {
		return memberDAO.selectMemberList(rowBounds);
	}

	@Override
	public int selectMemberListCnt() {
		return memberDAO.selectMemberListCnt();
	}


	@Override
	public int updateDingdong(int dingdongNo) {
		return memberDAO.updateDingdong(dingdongNo);
	}

	
	@Override
	public int insertDingdong(String memberId) {
		return memberDAO.insertDingdong(memberId);
		
	}


	@Override
	public int selectDingdongListCnt() {
		return memberDAO.selectDingdongListCnt();
	}

	@Override
	public List<Map<String, String>> dingdongListTest(Map<String, String> paramMap) {
		return memberDAO.dingdongListTest(paramMap);
	}

	@Override
	public Member memberInfo(String memberId) {
		return memberDAO.memberInfo(memberId);
	}

	@Override
	public int updateInfo(Map<String, Object> params) {
		return memberDAO.updateInfo(params);
	}

	@Override
	public Member searchNick(String memberId) {
		return memberDAO.searchNick(memberId);
	}

	
}
