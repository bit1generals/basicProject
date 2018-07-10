package org.generals.controller;

import java.security.Principal;

import org.generals.domain.Criteria;
import org.generals.domain.RooftopVO;
import org.generals.service.StageService;
import org.springframework.context.annotation.Scope;
import org.springframework.context.annotation.ScopedProxyMode;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/stage/*")
@Log4j
@Scope(proxyMode = ScopedProxyMode.TARGET_CLASS )
public class StageController  extends AbstractController<RooftopVO, Integer, StageService> {

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
	
	@Override
	public void list(Criteria cri, Model model, Principal principal) throws Exception {
		
		if(principal !=null) {
		
			//접근자의 권한을 확인하여 ADMIN이 아니면 Authorize안된 list에 접근 불가
			User user = (User)((Authentication)principal).getPrincipal();
	
			if(!user.getAuthorities().contains(new SimpleGrantedAuthority("ROLE_ADMIN"))) {
				cri.setState("Y");
			}
		}else {
			cri.setState("Y");
		}
		super.list(cri, model, principal);
		
	}
	

	
}
