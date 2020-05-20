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

}
