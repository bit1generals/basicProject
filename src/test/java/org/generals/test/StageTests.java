package org.generals.test;

import java.util.Date;

import org.generals.domain.BoardVO;
import org.generals.domain.Criteria;
import org.generals.domain.StageVO;
import org.generals.service.StageService;
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
public class StageTests {

	@Setter(onMethod_ = { @Autowired })
	private StageService service;

	/*@Test
	public void testRegister() throws Exception {

		for (int i = 0; i < 1; i++) {
			StageVO stageVO = new StageVO();
			BoardVO boardVO = new BoardVO();

			boardVO.setTitle("Stage Test title" + i);
			boardVO.setContent("Stage Test content" + i);
			boardVO.setBtype("R");
			boardVO.setId("user1");

			stageVO.setBoardVO(boardVO);
			stageVO.setRtname("Stage" + i);
			stageVO.setOpenTime("2018-06-19 15:00:00.00");
			stageVO.setCloseTime("2018-06-19 16:00:00.00");
			stageVO.setOpendate(new Date());
			stageVO.setClosedate(new Date());
			stageVO.setLat(54.34234);
			stageVO.setLng(123.34324);
			stageVO.setMaximum(123);

			service.register(stageVO);
		}
	}*/

	@Test
	public void testList() throws Exception {

		log.info(service.getList(new Criteria()));

	}

}