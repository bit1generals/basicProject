package org.generals.service;

import java.util.List;

import org.generals.domain.Criteria;
import org.generals.mapper.GenericMapper;
import org.springframework.beans.factory.annotation.Autowired;

import lombok.Setter;

public class GenericServiceImpl<T, K, M extends GenericMapper<T, K>> implements GenericService<T, K> {

	@Setter(onMethod_ = { @Autowired })
	protected M mapper;
	
	@Override
	public void register(T vo) throws Exception {
		if(mapper.insert(vo) != 1) {
			throw new Exception("insert fail");
		}
	}

	@Override
	public T view(K key) throws Exception {
		return mapper.read(key);
	}

	@Override
	public void modify(T vo) throws Exception {
		if(mapper.update(vo) != 1) {
			throw new Exception("update fail");
		}
	}

	@Override
	public void remove(K key) throws Exception {
		if(mapper.delete(key) != 1) {
			throw new Exception("remove fail");
		}
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
