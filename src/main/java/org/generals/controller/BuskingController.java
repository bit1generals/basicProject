package org.generals.controller;

import java.util.List;

import org.generals.domain.Criteria;
import org.generals.domain.PageMaker;
import org.generals.domain.ReserveVO;
import org.springframework.context.annotation.Scope;
import org.springframework.context.annotation.ScopedProxyMode;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/busking")
@Log4j
@Scope(proxyMode = ScopedProxyMode.TARGET_CLASS )
@PreAuthorize("isAuthenticated()")
public class BuskingController {
	
	@GetMapping("/list")
	public void list(Model model, Criteria cri) {
		
	
	}
	
	
	@GetMapping("/register")
	public void register(Model model, Criteria cri) {
		
	
	}
}
