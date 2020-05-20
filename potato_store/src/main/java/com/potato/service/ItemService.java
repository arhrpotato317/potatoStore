package com.potato.service;

import java.util.List;
import java.util.Map;

public interface ItemService {
	
	// 전체 상품 리스트
	public List<Map<String, Object>> getAllItemList() throws Exception;
	
	// 카테고리 리스트
	public List<Map<String, Object>> getCateOneList(String upCode) throws Exception;
	
	// 카테고리 조회
	public List<Map<String, Object>> getCateList(String cateTwo) throws Exception;
}
