package org.generals.service;

import org.generals.domain.RooftopVO;

public interface RooftopService extends GenericService<RooftopVO, Integer> {
	
	public void authorize(Integer key) throws Exception;
	
}
