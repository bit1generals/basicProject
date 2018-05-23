package org.generals.service;

import java.util.List;

import org.generals.domain.BoardVO;
import org.generals.domain.FileVO;

public interface BoardService extends GenericService<BoardVO, Integer> {

	public void registerAjax(List<FileVO> list) throws Exception;

	
}
