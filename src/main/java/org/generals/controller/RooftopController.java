package org.generals.controller;

import org.generals.domain.RooftopVO;
import org.generals.service.BoardService;
import org.generals.service.RooftopService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/rooftop/*")
@Log4j
public class RooftopController  extends AbstractController<RooftopVO, Integer, RooftopService> {

}
