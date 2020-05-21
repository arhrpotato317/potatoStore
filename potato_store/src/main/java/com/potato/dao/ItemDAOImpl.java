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

	// 금일 입고리스트에 데이터 저장
	@Override
	public void setInItemToday(Map<String, Object> map) throws Exception {
		sql.insert("item.setInItemToday", map);
	}

	// 상품 입고 시 물품관리테이블 재고수량 변경
	@Override
	public void stockAmtChange(Map<String, Object> map) throws Exception {
		sql.update("item.stockAmtChange", map);
	}

	// 금일 입고리스트 조회
	@Override
	public List<Map<String, Object>> getTodayItemList() throws Exception {
		return sql.selectList("item.getTodayItemList");
	}

	// 추가된 금일 입고리스트 행 - 바로조회
	@Override
	public Map<String, Object> getTodayItemList(String insertItemCode) throws Exception {
		return sql.selectOne("item.getTodayItemList", insertItemCode);
	}

	// 물품테이블 수량 조회
	@Override
	public Map<String, Object> getItemStock(String itemCode) throws Exception {
		return sql.selectOne("item.getItemStock", itemCode);
	}

}














