package org.generals.service;

import org.generals.domain.MemberVO;
import org.generals.mapper.MemberMapper;
import org.springframework.stereotype.Service;

@Service
public class MemberServiceImpl extends GenericServiceImpl<MemberVO, String, MemberMapper> implements MemberService{

	@Override
	public Boolean checkID(String id) {
		return mapper.checkID(id) != 1 ? false : true;
	}
	

}
