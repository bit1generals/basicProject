package org.generals.controller;

import java.security.Principal;

import org.generals.domain.Criteria;
import org.generals.service.BuskingService;
import org.generals.service.ReserveService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.context.annotation.ScopedProxyMode;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/busking")
@Log4j
@Scope(proxyMode = ScopedProxyMode.TARGET_CLASS )
@PreAuthorize("isAuthenticated()")
public class BuskingController {
	
	@Setter(onMethod_ = {@Autowired})
	BuskingService buskingService;
	
	@Setter(onMethod_ = {@Autowired})
	ReserveService reserveService;
	
	@GetMapping("/list")
	public void list(Model model, Criteria cri) {
		
	
	}
	
	
	@GetMapping("/register")
	public void register(Model model, Criteria cri, Principal prin) {
		log.info("========================");
		log.info(prin.getName());
		cri.setId(prin.getName());
		log.info(cri);
		model.addAttribute("reserveVOList", reserveService.getReserveByid(cri));
	}
}
