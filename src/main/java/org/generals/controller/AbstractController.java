package org.generals.controller;

import java.security.Principal;

import org.generals.domain.Criteria;
import org.generals.domain.PageMaker;
import org.generals.service.GenericService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.context.annotation.ScopedProxyMode;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
public abstract class AbstractController<T, K, S extends GenericService> implements GenericController<T, K> {

	public static final String SUCCESS = " Success";
	public static final String FAIL = " Fail";

	@Setter(onMethod_ = { @Autowired })
	protected S service;
	
	@Override
	public void list(@ModelAttribute("cri")Criteria cri, Model model, Principal principal) throws Exception {
		
		log.info("Abstract list Get");
		
		initContext(cri, model);
		
		model.addAttribute("list", service.getList(cri));
		
	}

	@Override
	public void view(K key, @ModelAttribute("cri")Criteria cri, Model model) throws Exception {

		log.info("Abstract view Get");

		model.addAttribute(service.view(key));
	}

	@Override
	public void register(@ModelAttribute("cri")Criteria cri) throws Exception {

		log.info("Abstract register Get");

	}

	@Override
	public String registerPost(T vo, @ModelAttribute("cri")Criteria cri, RedirectAttributes rttr){
		log.info("Abstract registerPost Post");
		log.info("register post vo : "+ vo);
		
		try {
			service.register(vo);
			buildRedirectAttribute(rttr, methodParse(), SUCCESS);
		} catch (Exception e) {
			e.printStackTrace();
			buildRedirectAttribute(rttr, methodParse(), FAIL);
		}
		return "redirect:/"+makeBaseUri()+"/list";
	}


	@Override
	public void modify(K key, @ModelAttribute("cri")Criteria cri, Model model) throws Exception {
		log.info("Abstract modify Get");
		model.addAttribute(service.view(key));
	}

	@Override
	public String modifyPost(T vo, @ModelAttribute("cri")Criteria cri, RedirectAttributes rttr) {
		log.info("Abstract modifyPost Post");
		log.info("Modify Post VO: "+vo);
		try {
			service.modify(vo);
			buildRedirectAttribute(rttr, methodParse(), SUCCESS);
		} catch (Exception e) {
			e.printStackTrace();
			buildRedirectAttribute(rttr, methodParse(), FAIL);
		}
		return "redirect:/"+makeBaseUri()+"/list";
	}

	@Override
	public String removePost(K key, @ModelAttribute("cri")Criteria cri, Model model, RedirectAttributes rttr) throws Exception {
		log.info("Abstract removePost Post");
		try {
			service.remove(key);
			buildRedirectAttribute(rttr, methodParse(), SUCCESS);
		} catch (Exception e) {
			e.printStackTrace();
			buildRedirectAttribute(rttr, methodParse(), FAIL);
		}
		return "redirect:/"+makeBaseUri()+"/list";
	}

	public String methodParse() {
		return new Throwable().getStackTrace()[1].getMethodName().split("P")[0];
	}

	public void buildRedirectAttribute(RedirectAttributes rttr, String method, String result) {
		rttr.addFlashAttribute("msg", method + result);
	}
	
	
	protected String makeBaseUri() {
		return this.getClass().getSimpleName().split("C")[0].toLowerCase();
	}
	
	
	protected void initContext(Criteria cri, Model model) throws Exception {
		 cri.setBtype(this.getClass().getSimpleName().substring(0, 1));
		 model.addAttribute("pm", new PageMaker(cri, service.getTotal(cri)));
	}

}
