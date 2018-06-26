package org.generals.service;

import java.io.File;
import java.util.List;

import org.generals.controller.FileController;
import org.generals.domain.BoardVO;
import org.generals.domain.FileVO;
import org.generals.mapper.BoardMapper;
import org.generals.mapper.FileMapper;
import org.generals.security.CustomUserDetailsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Service
@Log4j
@Transactional
public class BoardServiceImpl extends GenericServiceImpl<BoardVO, Integer, BoardMapper> implements BoardService {

	@Setter(onMethod_ = { @Autowired })
	private FileMapper fileMapper;

	@Override
	public void register(BoardVO vo) throws Exception {
		super.register(vo);
		if(vo.getFiles() != null) {
			fileMapper.updateBnoBySelect(vo.getFiles());
		}
	}

	@Override
	public void modify(BoardVO vo) throws Exception {
		super.modify(vo);
		fileMapper.updateBnoNull(vo.getBno());
		fileMapper.updateBnoByParam(vo.getBno(), vo.getFiles());
	}

	@Override
	public void remove(Integer key) throws Exception {
		log.info("===============================check");
		BoardVO vo = super.mapper.read(key);
		super.remove(key);
		if (vo.getFiles() != null) {
			List<FileVO> flist = vo.getFiles();
			fileMapper.delete(key);
			for (FileVO fileVO : flist) {
				File file = new File(FileController.ROOT + fileVO.getPath() + fileVO.getFullName());
				File sfile = new File(FileController.ROOT + fileVO.getPath() + "/thumbnails" + fileVO.getFullName());
				if (file.exists()) {
					file.delete();
					sfile.delete();
				}
			}
		}
	}

	@Override
	public void registerAjax(List<FileVO> flist) throws Exception {
		fileMapper.insertList(flist);
	}

}
