package com.soda.onn.member.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import com.soda.onn.member.model.vo.Member;

@Repository
public class MemberDAOImpl  implements MemberDAO{

	
	@Autowired
	private SqlSessionTemplate sqlSession;

	@Override
	public int insertMember(Member member) {
		return sqlSession.insert("member.insertMember", member);
	}

	@Override
	public Member selectMember(Map<String, String> map) {
		return sqlSession.selectOne("member.selectMember",map);
	}

	@Override
	public Member selectOne(String memberId) {
		return sqlSession.selectOne("member.selectOne",memberId);
	}

	@Override
	public List<Member> selectMemberList(RowBounds rowBounds) {
		return sqlSession.selectList("member.selectMemberList",null,rowBounds);
	}

	@Override
	public int selectMemberListCnt() {
		return Integer.parseInt(sqlSession.selectOne("member.selectMemberListCnt"));
	}
	
	@Override
	public int updateDingdong(int dingdongNo) {
		return sqlSession.update("member.updateDingdong", dingdongNo);
	}

	@Override
	public int insertDingdong(String memberId) {
		return sqlSession.insert("member.insertDingdong", memberId);
	}
	

	@Override
	public int selectDingdongListCnt() {
		return Integer.parseInt(sqlSession.selectOne("member.selectDingdongListCnt"));
	}

	@Override
	public List<Map<String, String>> dingdongListTest(Map<String, String> paramMap) {
		return sqlSession.selectList("member.dingdongListTest", paramMap);
	}

	@Override
	public Member memberInfo(String memberId) {
		return sqlSession.selectOne("member.memberInfo", memberId);
	}

	@Override
	public int updateInfo(Map<String, Object> params) {
		return sqlSession.update("member.updateInfo", params);
	}

	@Override
	public Member searchNick(String memberId) {
		return sqlSession.selectOne("member.searchNick", memberId);
	}


	
}
