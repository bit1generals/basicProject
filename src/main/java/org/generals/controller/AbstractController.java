package org.generals.controller;

import org.generals.domain.Criteria;
import org.generals.service.GenericService;
import org.generals.service.GenericServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
public abstract class AbstractController<T, K, S extends GenericService> implements GenericController<T, K> {

	public static final String SUCCESS = " Success";
	public static final String FAIL = " Fail";

	@Setter(onMethod_ = { @Autowired })
	private S service;
	

	@Override
	public void list(Criteria cri, Model model) throws Exception {

		log.info("Abstract list Get");
		model.addAttribute("list", service.getList(new Criteria()));

	}

	@Override
	public void view(K bno, Criteria cri, Model model) throws Exception {

		log.info("Abstract view Get");

		model.addAttribute(service.view(bno));
		

	}

	@Override
	public void register(Criteria cri) throws Exception {

		log.info("Abstract register Get");

	}

	@Override
	public void registerPost(T vo, Criteria cri, RedirectAttributes rttr){
		log.info("Abstract registerPost Post");
		
		try {
			service.register(vo);
			buildRedirectAttribute(rttr, methodParse(), SUCCESS);
		} catch (Exception e) {
			e.printStackTrace();
			buildRedirectAttribute(rttr, methodParse(), FAIL);
		}
		
	}

	@Override
	public void modify(K key, Criteria cri) throws Exception {
		log.info("Abstract modify Get");
	}

	@Override
	public void modifyPost(T vo, Criteria cri, RedirectAttributes rttr) {
		log.info("Abstract modifyPost Post");
		log.info(vo);
		try {
			service.modify(vo);
			buildRedirectAttribute(rttr, methodParse(), SUCCESS);
		} catch (Exception e) {
			e.printStackTrace();
			buildRedirectAttribute(rttr, methodParse(), FAIL);
		}
		
	}

	@Override
	public void removePost(K key, Criteria cri) throws Exception {
		log.info("Abstract removePost Post");
	}

	public String methodParse() {
		return new Throwable().getStackTrace()[1].getMethodName().split("P")[0];
	}

	public void buildRedirectAttribute(RedirectAttributes rttr, String method, String result) {
		rttr.addFlashAttribute("msg", method + result);
	}
}
