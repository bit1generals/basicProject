package org.generals.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.generals.domain.FileVO;

public interface FileMapper extends GenericMapper<FileVO, Integer>{

	public int insertList(@Param("flist")List<FileVO> flist);
	
	public int updateBnoBySelect(@Param("flist")List<FileVO> flist); 
	
	public int updateBnoNull(Integer bno);
	
	public int updateBnoByParam(Integer bno, @Param("flist")List<FileVO> flist);
	
}
