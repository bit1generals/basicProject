package org.generals.controller;

import org.generals.domain.MemberVO;
import org.generals.service.MemberService;
import org.springframework.context.annotation.Scope;
import org.springframework.context.annotation.ScopedProxyMode;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/member/*")
@Log4j
@PreAuthorize("isAuthenticated()")
@Scope( proxyMode = ScopedProxyMode.TARGET_CLASS )
public class MemberController extends AbstractController<MemberVO, String, MemberService>{

	@GetMapping("/login")
	@PreAuthorize("permitAll")
	public void login() {
		log.info("Member login Get");
	}
	@PostMapping("/login")
	@PreAuthorize("permitAll")
	public void loginPost(MemberVO vo) {
		log.info("Member login Post");
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
		return "redirect:/";
	}
}
