package org.generals.controller;

import org.springframework.context.annotation.Scope;
import org.springframework.context.annotation.ScopedProxyMode;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/bbs/*")
@Log4j
@Scope(proxyMode = ScopedProxyMode.TARGET_CLASS )
public class BbsController extends BaseBoardController{

	
}
