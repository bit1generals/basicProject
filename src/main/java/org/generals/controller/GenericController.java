package org.generals.controller;

import org.generals.domain.Criteria;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

public interface GenericController<T, K> {
	
	@GetMapping("/list")
	public void list(Criteria cri, Model model) throws Exception;
	
	@GetMapping("/view")
	public void view(K key, Criteria cri, Model model) throws Exception;
	
	@GetMapping("/register")
	public void register(Criteria cri) throws Exception;
	
	@PostMapping("/register")
	public void registerPost(T vo, Criteria cri, RedirectAttributes rttr) throws Exception;
	
	@GetMapping("/modify")
	public void modify(K key, Criteria cri) throws Exception;
	
	@PostMapping("/modify")
	public void modifyPost(T vo, Criteria cri, RedirectAttributes rttr) throws Exception;
	
	@PostMapping("/remove")
	public void removePost(K key, Criteria cri) throws Exception;
	
}
