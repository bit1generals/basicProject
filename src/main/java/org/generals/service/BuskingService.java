package org.generals.service;

import java.util.List;

import org.generals.domain.BoardVO;
import org.generals.domain.BuskingVO;
import org.generals.domain.Criteria;
import org.generals.domain.ReserveVO;
import org.generals.mapper.BuskingMapper;
import org.generals.mapper.FileMapper;
import org.generals.mapper.ReserveMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Service
@Log4j
@Transactional
public class BuskingService {

	@Setter(onMethod_ = { @Autowired })
	private BuskingMapper buskingMapper;
	
	@Setter(onMethod_ = { @Autowired })
	private ReserveMapper reserveMapper;
	
	@Setter(onMethod_ = { @Autowired })
	private BoardService boardService;
	
	@Setter(onMethod_ = {@Autowired})
	private FileMapper fileMapper;
	

	public void insertBusking(BuskingVO vo) throws Exception{
		try {
			log.info("check 2 :" + vo);
			log.info("insertBusking in !!!!");
			BoardVO boardVO = vo.getBoardVO();
			boardService.register(boardVO);
			buskingMapper.insertBusking(vo);
			log.info(vo.getRno()); 
			reserveMapper.updateReserveState(vo.getRno(), "Before Busking");
			
			if(vo.getBoardVO().getFiles() != null) {
				log.info("vo getfile ================== " + vo.getBoardVO().getFiles());
				fileMapper.updateBnoBySelect(vo.getBoardVO().getFiles());
			}
		} catch (Exception e) {
			throw new Exception("Busking Register Fail" + e.getMessage());
		}
	}
	
	public List<BoardVO> getBoardList(Criteria cri) throws Exception{
		log.info("getBuskingList === in");
		cri.setBtype("BK");
		List<BoardVO> voList = buskingMapper.selectBoardListbyBtype(cri);
		log.info(voList);
		return voList;
	}
	
	public List<BuskingVO> getBuskingVOList (Criteria cri) throws Exception {
		return buskingMapper.selectBuskingVOList(cri);
	}
	
	public BuskingVO getBuskingVO(Integer key) {
		return buskingMapper.selectBuskingVO(key);
	}
	
	public int getTotal(Criteria cri) {
		return reserveMapper.getTotal(cri);
	}
	
	public void deleteBusking(BuskingVO vo) {
		reserveMapper.updateReserveState(vo.getRno(), "Done");
		buskingMapper.deleteBuskingVO(vo.getBkno());
	}
}