package com.potato.service;

import java.util.List;
import java.util.Map;

public interface ItemService {
	
	// 전체 상품 리스트
	public List<Map<String, Object>> getAllItemList() throws Exception;
}
