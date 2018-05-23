package org.generals.test;

import java.util.ArrayList;
import java.util.List;

import org.generals.domain.FileVO;
import org.generals.mapper.FileMapper;
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
public class FileMapperTests {

	@Setter(onMethod_ = { @Autowired })
	private FileMapper mapper;
	
	@Test
	public void testUpdate() {
		
		List<FileVO> flist = new ArrayList<>();
		FileVO vo = new FileVO();
		vo.setUuid("04ce3126-595c-4ff3-80fb-8dd15ee9a180");
		flist.add(vo);
		Integer bno = 105;
		
		
		//log.info(mapper.insertUpdate(flist, bno));
	}
}
