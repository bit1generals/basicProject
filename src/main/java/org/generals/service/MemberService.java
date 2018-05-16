package org.generals.service;

import org.generals.domain.MemberVO;
import org.generals.mapper.MemberMapper;
import org.springframework.stereotype.Service;

@Service
public class MemberService extends GenericServiceImpl<MemberVO, String, MemberMapper> {

}
