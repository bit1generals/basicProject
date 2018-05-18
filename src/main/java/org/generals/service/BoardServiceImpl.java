package org.generals.service;

import java.util.List;

import javax.annotation.Resource;

import org.generals.domain.BoardVO;
import org.generals.domain.FileVO;
import org.generals.mapper.BoardMapper;
import org.generals.mapper.FileMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import lombok.Setter;


@Transactional
@Service
public class BoardServiceImpl extends GenericServiceImpl<BoardVO, Integer, BoardMapper>  implements BoardService{

	@Setter(onMethod_ = { @Autowired })
	private FileMapper fileMapper;

	
	@Override
	public void register(BoardVO vo) throws Exception {
		super.register(vo);
		List<FileVO> list = vo.getFiles();
		//list.forEach(fileVO -> mapper.insert(fileVO));
		fileMapper.insertList(list);
	}

	@Override
	public void modify(BoardVO vo) throws Exception {
		super.modify(vo);
	}

	@Override
	public void remove(Integer key) throws Exception {
		super.remove(key);
	}
	
}
