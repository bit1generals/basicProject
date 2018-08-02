package org.generals.mapper;

import java.util.List;

import org.generals.domain.BoardVO;
import org.generals.domain.BuskingVO;
import org.generals.domain.Criteria;
import org.generals.domain.ReserveVO;

public interface BuskingMapper {
	
	public void insertBusking(BuskingVO vo);
	
	public List<BoardVO> selectBoardListbyBtype(Criteria cri);
	
	public List<BuskingVO> selectBuskingList(Criteria cri);
	
	public List<ReserveVO> selectReserveListByState(String state);
	
	public List<BuskingVO> selectBuskingVOList (Criteria cri);
	
	public BuskingVO selectBuskingVO(Integer key);
	
	public void deleteBuskingVO(Integer bkno);
}
