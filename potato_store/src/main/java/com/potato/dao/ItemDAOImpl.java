package com.potato.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class ItemDAOImpl implements ItemDAO {
	
	@Autowired
	private SqlSession sql;

	// 전체 상품 리스트
	@Override
	public List<Map<String, Object>> getAllItemList() throws Exception {
		return sql.selectList("item.getAllItemList");
	}

	// 카테고리 리스트
	@Override
	public List<Map<String, Object>> getCateOneList(String upCode) throws Exception {
		return sql.selectList("item.getCateOneList", upCode);
	}

	// 카테고리 조회
	@Override
	public List<Map<String, Object>> getCateList(String cateTwo) throws Exception {
		return sql.selectList("item.getCateList", cateTwo);
	}

}
