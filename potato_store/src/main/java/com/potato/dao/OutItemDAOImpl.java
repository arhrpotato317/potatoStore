package com.potato.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class OutItemDAOImpl implements OutItemDAO {

	@Autowired
	private SqlSession sql;
	
	// 출고관리 테이블에 추가하기
	@Override
	public void outItemInsert(Map<String, Object> map) throws Exception {
		sql.insert("outitem.outItemInsert", map);
	}
	
	// 금일 출고리스트 조회
	@Override
	public List<Map<String, Object>> todayOutItem() throws Exception {
		return sql.selectList("outitem.todayOutItem");
	}
	
	// 추가된 금일 출고리스트 행 - 바로조회
	@Override
	public Map<String, Object> todayOutItem(String insertOutItemCode) throws Exception {
		return sql.selectOne("outitem.todayOutItem", insertOutItemCode);
	}

	// 상품 조회 리스트 수량 최종 결과
	@Override
	public Map<String, Object> resultAmt(String itemCode) throws Exception {
		return sql.selectOne("outitem.resultAmt", itemCode);
	}
	
	// 출고 테이블 정보 수정
	@Override
	public void outItemUpdate(Map<String, Object> map) throws Exception {
		sql.update("outitem.outItemUpdate", map);
	}

}
