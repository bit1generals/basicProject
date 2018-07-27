package org.generals.controller;

import java.text.DateFormat;
import java.util.Date;
import java.util.Locale;

import org.generals.domain.StageVO;
import org.generals.service.StageService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.context.annotation.ScopedProxyMode;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import lombok.Setter;

@Controller
@Scope( proxyMode = ScopedProxyMode.TARGET_CLASS )
public class HomeController extends AbstractController<StageVO, Integer, StageService> {
	
	@Setter(onMethod_ = { @Autowired })
	private StageService stageService;
	
	@PreAuthorize("permitAll")
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Model model) {
		model.addAttribute("stageVO", stageService.getAllList());
		return "home";
	}
	@PreAuthorize("permitAll")
	@RequestMapping(value = "/test", method = RequestMethod.GET)
	public void test(Model model) {
		
	}
}
