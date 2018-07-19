package org.generals.service;

import org.generals.domain.BuskingVO;
import org.generals.domain.ReserveVO;
import org.generals.mapper.BuskingMapper;
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
	
	
	public void insertBusking(BuskingVO vo) throws Exception{
		if (buskingMapper.insertBusking(vo) != 1) {
			throw new Exception("Busking Register Fail");	
		}
	}
}
