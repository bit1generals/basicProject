package org.generals.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.generals.domain.Criteria;

public interface GenericMapper<T, K> {
		
	public List<T> getList(Criteria cri);
	
	public int insert(T vo);
	
	public T read(K key);
	
	public int update(T vo);
	
	public int delete(K key);
	
	public int getTotal(Criteria cri);
}
