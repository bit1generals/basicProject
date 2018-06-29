package org.generals.service;

import org.generals.domain.MemberVO;

public interface MemberService extends GenericService<MemberVO, String> {
	
	public Boolean checkID(String id);
	
	public MemberVO getMember(String id);
}
