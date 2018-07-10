package org.generals.service;

import java.io.File;
import java.util.List;

import org.generals.controller.FileController;
import org.generals.domain.BoardVO;
import org.generals.domain.Criteria;
import org.generals.domain.FileVO;
import org.generals.domain.ReserveVO;
import org.generals.domain.StageVO;
import org.generals.mapper.BoardMapper;
import org.generals.mapper.FileMapper;
import org.generals.mapper.StageMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
@Transactional
public class StageServiceImpl extends GenericServiceImpl<StageVO, Integer, StageMapper> implements StageService {

	@Setter(onMethod_ = { @Autowired })
	private StageMapper stageMapper;
	@Setter(onMethod_ = { @Autowired })
	private BoardService boardService;

	@Override
	public void register(StageVO stageVO) throws Exception {
		boardService.register(stageVO.getBoardVO());
		stageMapper.insert(stageVO);
	}

	@Override
	public void modify(StageVO vo) throws Exception {
		boardService.modify(vo.getBoardVO());
		stageMapper.update(vo);
	}

	@Override
	public void remove(Integer key) throws Exception {
		boardService.remove(key);
		stageMapper.delete(key);
	}

	@Override
	public StageVO view(Integer key) throws Exception {
		StageVO stageVO = stageMapper.read(key);
		stageVO.setBoardVO(boardService.view(key));
		return stageVO;
	}

	@Override
	public List<StageVO> getList(Criteria cri) throws Exception {
		log.info("Stage Service - getList Call!!!!!!");
		return stageMapper.getList(cri);
	}

	@Override
	public int getTotal(Criteria cri) throws Exception {
		return stageMapper.getTotal(cri);
	}

	public void authorize(Integer key) throws Exception{
		int result = stageMapper.updateStatebyBno(key);
		if(result != 1) {
			throw new Exception("Authorize Fail");
		}
	}
	
	public List<ReserveVO> getSchdule(Criteria cri) {
		return stageMapper.selectStagebyBoarderid(cri);
	}

}