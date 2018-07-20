package org.generals.controller;

import java.security.Principal;
import java.util.List;

import org.generals.domain.BuskingVO;
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
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

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
		try {
			log.info("in busking/list");
			cri.setState("Before Busking");
			List<BuskingVO> buskingVOList = buskingService.getBuskingList(cri);
			log.info(buskingVOList);
			model.addAttribute("buskingVOList", buskingVOList);
		} catch (Exception e) {
			e.printStackTrace();
		}
	
	}
	
	@GetMapping("/register")
	public void register(Model model, Criteria cri, Principal prin) {
		cri.setId(prin.getName());
		model.addAttribute("reserveVOList", reserveService.getReserveByid(cri));
	}
	
	@PostMapping("/register")
	public String registerPost(BuskingVO vo, RedirectAttributes rttr) {
		try {
			buskingService.insertBusking(vo);
			rttr.addFlashAttribute("msg", "Register Success");
		} catch (Exception e) {
			rttr.addFlashAttribute("msg", e.getMessage());
		}
		return "redirect:./list";
	}
}