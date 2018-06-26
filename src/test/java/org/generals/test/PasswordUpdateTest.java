package org.generals.test;

import java.util.List;

import org.generals.domain.Criteria;
import org.generals.domain.MemberVO;
import org.generals.mapper.MemberMapper;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({"file:src/main/webapp/WEB-INF/spring/root-context.xml", "file:src/main/webapp/WEB-INF/spring/security-context.xml"})
@Log4j
public class PasswordUpdateTest {

	@Setter(onMethod_ = { @Autowired })
	private MemberMapper mapper;
	

	@Setter(onMethod_ = { @Autowired })
	private PasswordEncoder encoder;
	
	@Test
	public void updateTest() {
		
		List<MemberVO> list = mapper.getList(new Criteria());
		list.forEach(vo -> {
			vo.setPw(encoder.encode(vo.getPw()));
			mapper.updatePW(vo);
		});
		
	}

}
