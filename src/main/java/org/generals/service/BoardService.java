package org.generals.service;

import org.generals.domain.BoardVO;
import org.generals.mapper.BoardMapper;
import org.springframework.stereotype.Service;

@Service
public class BoardService extends GenericServiceImpl<BoardVO, Integer, BoardMapper> {

}
