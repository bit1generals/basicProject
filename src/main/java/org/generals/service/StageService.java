package org.generals.service;

import java.util.List;

import org.generals.domain.Criteria;
import org.generals.domain.ReserveVO;
import org.generals.domain.StageVO;

public interface StageService extends GenericService<StageVO, Integer> {
	
	public void authorize(Integer key) throws Exception;

	public List<ReserveVO> getSchdule(Criteria cri);
	
	public List<StageVO> getAllList();
}
