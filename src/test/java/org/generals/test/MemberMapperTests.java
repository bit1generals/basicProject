package org.generals.test;

import org.generals.domain.MemberVO;
import org.generals.mapper.MemberMapper;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class MemberMapperTests {

	@Setter(onMethod_ = { @Autowired })
	private MemberMapper mapper;

	@Test
	public void testInsert() {

		for (int i = 0; i < 100; i++) {
			mapper.insert(new MemberVO("user"+i,"name"+i, "pw" + i, "email" + i));
		}

	}
	@Test
	public void testInsert2() {
		for (int i = 0; i < 100; i++) {
			
		}
	}
	
}
