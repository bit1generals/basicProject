package org.generals.service;

import java.util.List;

import org.generals.domain.FileVO;

public interface FileService {

	public void register(List<FileVO> list) throws Exception;
	
	public void modify(Integer bno, List<FileVO> list) throws Exception;
	
	public void registerUpdate(List<FileVO> list) throws Exception;
	
}
