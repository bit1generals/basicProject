package org.generals.service;

import java.util.List;

import org.generals.domain.Criteria;
import org.generals.mapper.GenericMapper;
import org.springframework.beans.factory.annotation.Autowired;

import lombok.Setter;

public abstract class GenericServiceImpl<T, K, M extends GenericMapper<T, K>> implements GenericService<T, K> {

	@Setter(onMethod_ = { @Autowired })
	protected M mapper;
	
	@Override
	public int register(T vo) throws Exception {
		
		return mapper.insert(vo);
	}

	@Override
	public T view(K key, Criteria cri) throws Exception {
		return mapper.read(key, cri);
	}

	@Override
	public int modify(T vo) throws Exception {
		return mapper.update(vo);
	}

	@Override
	public int remove(K key) throws Exception {
		return mapper.delete(key);
	}

	@Override
	public List<T> getList(Criteria cri) throws Exception {
		return mapper.getList(cri);
	}

	@Override
	public int getTotal(Criteria cri) throws Exception {
		return mapper.getTotal(cri);
	}

	
}
