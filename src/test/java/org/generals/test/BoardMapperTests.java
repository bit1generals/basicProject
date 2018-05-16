package org.generals.test;

import org.generals.controller.AbstractController;
import org.generals.domain.BoardVO;
import org.generals.domain.Criteria;
import org.generals.mapper.BoardMapper;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.web.bind.annotation.ExceptionHandler;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class BoardMapperTests {

	@Setter(onMethod_ = { @Autowired })
	private BoardMapper mapper;

	@Test
	public void testInsertArr() {

		for (int i = 0; i < 100; i++) {
			mapper.insert(new BoardVO("B", "user" + i, "title" + i, "content" + i));
		}

	}

	@Test
	public void testInsert() {
		try {
			BoardVO vo = new BoardVO();
			vo.setTitle("update test title 10");
			vo.setContent("update test content 10");
			vo.setBno(500);
			if(mapper.update(vo) != 1) {
				throw new Exception("update Fail");
			};
		} catch (Exception e) {
			e.getMessage();
		}
	}

	@Test
	public void testRead() {

		log.info(mapper.read(88, new Criteria()));

	}

	@Test
	public void testUpdate() {
		// BoardVO vo = mapper.read(200, new Criteria());
		BoardVO vo = new BoardVO();
		vo.setTitle("update test title 10");
		vo.setContent("update test content 10");

		log.info(mapper.update(vo));

	}

	@Test
	public void testDelete() {
		mapper.delete(88);
		log.info(mapper.read(88, new Criteria()));
	}

	@Test
	public void testGetList() {
		mapper.getList(new Criteria()).forEach(vo -> log.info(vo));
	}
	
	@Test
	public void test123() {
		log.info(this.getClass().getMethods());
	}
	
	
	@Test
	public void testEx(int result, String str) {
		try {
			if(result != 1) {
				throw new Exception(str+"Fail");
			};
		} catch (Exception e) {
			e.getMessage();
		}
	}
}
