package org.generals.mapper;

import java.util.List;

import org.generals.domain.Criteria;
import org.generals.domain.ReserveVO;
import org.generals.domain.StageVO;

public interface StageMapper extends GenericMapper<StageVO, Integer>{

	public int updateStatebyBno(Integer key);
	
	public List<ReserveVO> selectStagebyBoarderid(Criteria cri);
}
