package org.generals.service;

import java.util.List;

import org.generals.domain.FileVO;
import org.generals.mapper.FileMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.Setter;

@Service
public class FileServiceImpl implements FileService{
	
	@Setter(onMethod_ = { @Autowired })
	private FileMapper mapper;

	@Override
	public void register(List<FileVO> flist) throws Exception {
		mapper.insertList(flist);
	}

	@Override
	public void modify(Integer bno, List<FileVO> flist) throws Exception {
		mapper.updateBnoNull(bno);
		mapper.updateBno(bno, flist);
	}

	@Override
	public void registerUpdate(List<FileVO> flist) throws Exception {
		mapper.insertUpdate(flist);
	}

	
	
	
}
