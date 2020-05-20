package com.potato.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.potato.dao.ItemDAO;

@Service
public class ItemServiceImpl implements ItemService {
	
	@Autowired
	private ItemDAO dao;

	// 전체 상품 리스트
	@Override
	public List<Map<String, Object>> getAllItemList() throws Exception {
		return dao.getAllItemList();
	}

	// 카테고리 리스트
	@Override
	public List<Map<String, Object>> getCateOneList(String upCode) throws Exception {
		return dao.getCateOneList(upCode);
	}

	// 카테고리 조회
	@Override
	public List<Map<String, Object>> getCateList(String cateTwo) throws Exception {
		return dao.getCateList(cateTwo);
	}

}
