package org.generals.service;

import org.generals.domain.BoardVO;
import org.generals.mapper.QnAMapper;
import org.springframework.stereotype.Service;

@Service
public class QnAServiceImpl extends GenericServiceImpl<BoardVO, Integer, QnAMapper> implements QnAService{
}
