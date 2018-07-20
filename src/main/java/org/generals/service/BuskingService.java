package org.generals.service;

import java.util.List;

import org.generals.domain.BuskingVO;
import org.generals.domain.Criteria;
import org.generals.mapper.BuskingMapper;
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
	private ReserveService reserveService;
	
	
	public void insertBusking(BuskingVO vo) throws Exception{
		try {
			log.info("getRNO test ====in");
			buskingMapper.insertBusking(vo);
			log.info(vo.getRno());
			reserveService.updateReserveState(vo.getRno(), "Before Busking");
		} catch (Exception e) {
			throw new Exception("Busking Register Fail" + e.getMessage());
		}
	}
	
	public List<BuskingVO> getBuskingList(Criteria cri) throws Exception{
		log.info("getBuskingList === in");
		log.info(cri);
		return buskingMapper.selectBuskingListByState(cri);
	}
}
