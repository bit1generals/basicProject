package org.generals.mapper;

import org.generals.domain.MemberVO;

public interface MemberMapper extends GenericMapper<MemberVO, String>{

	public int checkID(String id);
	
	public int insertAuth(String id);
	
	public int updatePW(MemberVO vo);
	
	public MemberVO selectMemberVO(String id);
}
