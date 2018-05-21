package org.generals.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.generals.domain.FileVO;

public interface FileMapper extends GenericMapper<FileVO, Integer>{

	public int insertList(@Param("flist")List<FileVO> flist);
	
	public int updateBnoNull(Integer bno);
	
	public int updateBno(Integer bno, @Param("flist")List<FileVO> flist);

	public int insertUpdate(@Param("flist")List<FileVO> flist);
}
