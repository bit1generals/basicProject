package org.generals.controller;

import java.security.Principal;

import org.generals.domain.Criteria;
import org.generals.domain.MemberVO;
import org.generals.service.MemberService;
import org.springframework.context.annotation.Scope;
import org.springframework.context.annotation.ScopedProxyMode;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.userdetails.User;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/member/*")
@Log4j
@Scope(proxyMode = ScopedProxyMode.TARGET_CLASS )
public class MemberController extends AbstractController<MemberVO, String, MemberService>{

	@GetMapping("/login")
	@PreAuthorize("permitAll")
	public void login() {
		log.info("Member login Get");
	}
	
	@GetMapping("/join")
	@PreAuthorize("permitAll")
	public void join() {
		log.info("Member join Get");
	}

	@PostMapping("/join")
	@PreAuthorize("permitAll")
	public String joinPost(MemberVO vo, RedirectAttributes rttr) {
		log.info("Member join Post");
		try {
			service.register(vo);
			buildRedirectAttribute(rttr, methodParse(),SUCCESS);
		} catch (Exception e) {
			e.printStackTrace();
			buildRedirectAttribute(rttr, methodParse(),FAIL);
		}
		return "redirect:/";
	}
	
	@GetMapping("/myPage")
	public void myPage(Principal principal, Model model) {
		log.info("myPage Get");
		User user = (User)((Authentication)principal).getPrincipal();
		model.addAttribute("memberVO", service.getMember(user.getUsername()));
	}
	
	@PostMapping("/myPage")
	public String modifyPost(MemberVO vo, RedirectAttributes rttr) {
		log.info("myPage Post");
		log.info("Check!!! : "+vo);
		try {
			service.modify(vo);
			buildRedirectAttribute(rttr, methodParse(),SUCCESS);
		} catch (Exception e) {
			e.printStackTrace();
			buildRedirectAttribute(rttr, methodParse(),FAIL);
		}
		return "redirect:/member/myPage";
	}
	
}
