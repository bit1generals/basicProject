package org.generals.mapper;

import java.util.List;

import org.generals.domain.BuskingVO;
import org.generals.domain.Criteria;

public interface BuskingMapper {
	
	public void insertBusking(BuskingVO vo);
	
	public List<BuskingVO> selectBuskingListByState(Criteria cri);
}
