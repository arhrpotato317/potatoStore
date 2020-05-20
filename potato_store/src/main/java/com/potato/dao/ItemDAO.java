package com.potato.dao;

import java.util.List;
import java.util.Map;

public interface ItemDAO {

	// 전체 상품 리스트
	public List<Map<String, Object>> getAllItemList() throws Exception;
}
