package org.generals.controller;

import org.generals.domain.BoardVO;
import org.generals.service.QnAService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/qna/*")
@Log4j
public class QnAController extends AbstractController<BoardVO, Integer, QnAService> {

}
