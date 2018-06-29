package org.generals.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.generals.domain.ArticleVO;
import org.generals.domain.Criteria;
import org.generals.domain.ReserveVO;
import org.generals.domain.RooftopVO;
import org.generals.service.MemberService;
import org.generals.service.ReserveService;
import org.generals.service.RooftopService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.context.annotation.ScopedProxyMode;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RestController
@RequestMapping("/ajax")
@Log4j
@PreAuthorize("isAuthenticated()")
@Scope(proxyMode = ScopedProxyMode.TARGET_CLASS )
public class AjaxController {
	
	@Setter(onMethod_ = { @Autowired })
	private ReserveService reserveService;
	
	@Setter(onMethod_ = { @Autowired })
	private RooftopService rooftopService;
	
	@Setter(onMethod_ = { @Autowired })
	private MemberService memberService;
	
	@PostMapping(value = "/timeData", produces = "application/json")
	public ResponseEntity<List<ReserveVO>> getTimeData(@RequestBody ReserveVO vo) {
		log.info("getTimeData call......");
		log.info("vo : "+vo);
		vo.setState("D");
		List<ReserveVO> timeDataList = reserveService.getTimeData(vo);
		return new ResponseEntity<List<ReserveVO>>(timeDataList, HttpStatus.OK);
	}
	
	@PostMapping(value = "/articleData", produces = "application/json")
	public ResponseEntity<ArticleVO> getArticleData(@RequestBody ReserveVO vo) {
		log.info("getArticleData call........");
		log.info("vo : "+vo);
		log.info("type : "+ vo.getType());
		vo.setState("D");
		ArticleVO articleVO = reserveService.getReserveArticle(vo, vo.getType());
		return new ResponseEntity<ArticleVO>(articleVO, HttpStatus.OK);
	}
	
	@GetMapping(value = "/reserveArticleData", produces = "application/json")
	public ResponseEntity<List<ArticleVO>> getReserveArticleData(Long rno){
		List<ArticleVO> list = reserveService.getArticleList(rno);
		return new ResponseEntity<List<ArticleVO>>(list, HttpStatus.OK);
	}
	
	@GetMapping(value = "/rooftopData", produces = "application/json")
	public ResponseEntity<RooftopVO> getRooftopData(Integer bno) {
		return new ResponseEntity<RooftopVO> (reserveService.getRooftopVO(bno), HttpStatus.OK);
	}
	
	@PreAuthorize("permitAll")
	@GetMapping(value = "/idCheck", produces = "application/json")
	public ResponseEntity<Map<String, Boolean>> getIdCheck(String id) {
		log.info("getIdCheck call........" + id);
		Map<String, Boolean> map = new HashMap<>();
		map.put("result", memberService.checkID(id));
		return new ResponseEntity<Map<String, Boolean>> (map, HttpStatus.OK);
	}
	
	@PostMapping(value = "/rooftopList", produces = "application/json")
	public ResponseEntity<List<RooftopVO>> getRooftopList(@RequestBody Criteria cri) throws Exception {
		log.info("11111111111 : "+ cri);
		return new ResponseEntity<List<RooftopVO>> (rooftopService.getList(cri), HttpStatus.OK);
	}
	
	@PostMapping(value = "/reserveList", produces = "application/json")
	public ResponseEntity<List<ReserveVO>> getReserveList(@RequestBody Criteria cri) {
		return new ResponseEntity<List<ReserveVO>> (reserveService.getList(cri), HttpStatus.OK);
	}

	
	@PostMapping(value = "/rooftopReserveList", produces = "application/json")
	public ResponseEntity<List<ReserveVO>> getRooftopReserveList(@RequestBody Criteria cri) throws Exception {
		
		List<RooftopVO> rooftopList = rooftopService.getList(cri);
		
		//미완성 아직 안만짐.
		return new ResponseEntity<List<ReserveVO>> (reserveService.getList(cri), HttpStatus.OK);
	}
	
}
