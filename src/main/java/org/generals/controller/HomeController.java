package org.generals.controller;

import java.text.DateFormat;
import java.util.Date;
import java.util.Locale;

import org.generals.domain.RooftopVO;
import org.generals.service.RooftopService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.annotation.Scope;
import org.springframework.context.annotation.ScopedProxyMode;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@Scope( proxyMode = ScopedProxyMode.TARGET_CLASS )
public class HomeController extends AbstractController<RooftopVO, Integer, RooftopService> {
	
	@PreAuthorize("permitAll")
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Model model) {
		
		return "home";
	}
	
}
