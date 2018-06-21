package org.generals.service;

import java.io.File;
import java.util.List;

import org.generals.controller.FileController;
import org.generals.domain.BoardVO;
import org.generals.domain.Criteria;
import org.generals.domain.FileVO;
import org.generals.domain.RooftopVO;
import org.generals.mapper.BoardMapper;
import org.generals.mapper.FileMapper;
import org.generals.mapper.RooftopMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
@Transactional
public class RooftopServiceImpl extends GenericServiceImpl<RooftopVO, Integer, RooftopMapper> implements RooftopService {

	@Setter(onMethod_ = { @Autowired })
	private RooftopMapper rooftopMapper;
	@Setter(onMethod_ = { @Autowired })
	private BoardService boardService;

	@Override
	public void register(RooftopVO rooftopVO) throws Exception {
		boardService.register(rooftopVO.getBoardVO());
		rooftopMapper.insert(rooftopVO);
	}

	@Override
	public void modify(RooftopVO vo) throws Exception {
		boardService.modify(vo.getBoardVO());
		rooftopMapper.update(vo);
	}

	@Override
	public void remove(Integer key) throws Exception {
		boardService.remove(key);
		rooftopMapper.delete(key);
	}

	@Override
	public RooftopVO view(Integer key) throws Exception {
		RooftopVO rooftopVO = rooftopMapper.read(key);
		rooftopVO.setBoardVO(boardService.view(key));
		return rooftopVO;
	}

	@Override
	public List<RooftopVO> getList(Criteria cri) throws Exception {
		return rooftopMapper.getList(cri);
	}

	@Override
	public int getTotal(Criteria cri) throws Exception {
		return rooftopMapper.getTotal(cri);
	}

	public void authorize(Integer key) throws Exception{
		int result = rooftopMapper.updateStatebyBno(key);
		if(result != 1) {
			throw new Exception("Authorize Fail");
		}
	}

}