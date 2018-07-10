package org.generals.service;

import org.generals.domain.RooftopVO;

public interface StageService extends GenericService<RooftopVO, Integer> {
	
	public void authorize(Integer key) throws Exception;
	
}
