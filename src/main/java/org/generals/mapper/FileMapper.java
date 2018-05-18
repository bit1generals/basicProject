package org.generals.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.generals.domain.FileVO;

public interface FileMapper extends GenericMapper<FileVO, Integer>{

	public int insertList(@Param("flist")List<FileVO> flist);
	
}
