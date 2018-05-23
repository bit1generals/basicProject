package org.generals.service;

import java.util.List;

import org.generals.domain.Criteria;

public interface GenericService<T, K> {

	public void register(T vo) throws Exception;

	public T view(K key) throws Exception;

	public void modify(T vo) throws Exception;

	public void remove(K key) throws Exception;

	public List<T> getList(Criteria cri) throws Exception;
	
	public int getTotal(Criteria cri) throws Exception;

}
