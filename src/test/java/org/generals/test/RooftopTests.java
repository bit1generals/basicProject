package org.generals.test;

import java.util.Date;

import org.generals.domain.BoardVO;
import org.generals.domain.Criteria;
import org.generals.domain.RooftopVO;
import org.generals.service.RooftopService;
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
public class RooftopTests {

	@Setter(onMethod_ = { @Autowired })
	private RooftopService service;

	@Test
	public void testRegister() throws Exception {

		for (int i = 0; i < 100000; i++) {
			RooftopVO rooftopVO = new RooftopVO();
			BoardVO boardVO = new BoardVO();

			boardVO.setTitle("RoofTop Test title" + i);
			boardVO.setContent("RoofTop Test content" + i);
			boardVO.setBtype("R");
			boardVO.setId("user1");

			rooftopVO.setBoardVO(boardVO);
			rooftopVO.setRtname("RoofTop" + i);
			rooftopVO.setOpenTime("2018-06-19 15:00:00.00");
			rooftopVO.setCloseTime("2018-06-19 16:00:00.00");
			rooftopVO.setOpendate(new Date());
			rooftopVO.setClosedate(new Date());
			rooftopVO.setLat(54.34234);
			rooftopVO.setLng(123.34324);
			rooftopVO.setMaximum(123);

			service.register(rooftopVO);
		}
	}

	@Test
	public void testList() throws Exception {

		log.info(service.getList(new Criteria()));

	}

}
