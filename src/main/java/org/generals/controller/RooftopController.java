package org.generals.controller;

import java.text.DateFormat;
import java.util.Date;
import java.util.Locale;

import org.generals.domain.Criteria;
import org.generals.domain.RooftopVO;
import org.generals.service.RooftopService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/rooftop/*")
@Log4j
public class RooftopController  extends AbstractController<RooftopVO, Integer, RooftopService> {

	@PostMapping("/authorize")
	public String authorize(Integer key, @ModelAttribute("cri")Criteria cri, RedirectAttributes rttr) {
		try {
			service.authorize(key);
			buildRedirectAttribute(rttr,"Authorize", SUCCESS);
		} catch (Exception e) {
			e.printStackTrace();
			buildRedirectAttribute(rttr,"Authorize", FAIL);
		}
		return "redirect:/"+makeBaseUri()+"/list";
	}
	
}
