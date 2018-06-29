package org.generals.service;

import org.generals.domain.MemberVO;
import org.generals.mapper.MemberMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import lombok.Setter;

@Service
public class MemberServiceImpl extends GenericServiceImpl<MemberVO, String, MemberMapper> implements MemberService{

	@Setter(onMethod_ = { @Autowired })
	private PasswordEncoder encoder;
	
	@Override
	public Boolean checkID(String id) {
		return mapper.checkID(id) != 1 ? false : true;
	}

	@Override
	@Transactional
	public void register(MemberVO vo) throws Exception {
		vo.setPw(encoder.encode(vo.getPw()));
		super.register(vo);
		int result = mapper.insertAuth(vo.getId());
		if(result != 1) {
			throw new Exception("memberJoin Fail");
		}
	}

	@Override
	public MemberVO getMember(String id) {
		return mapper.selectMemberVO(id);
	}

	@Override
	public void modify(MemberVO vo) throws Exception {
		vo.setPw(encoder.encode(vo.getPw()));
		super.modify(vo);		
	}
	
	

}
