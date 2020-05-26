package com.potato.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.potato.dao.OutItemDAO;

@Service
public class OutItemServiceImpl implements OutItemService {

	@Autowired
	private OutItemDAO dao;
	
	// 출고관리 테이블에 추가하기
	@Override
	public void outItemInsert(Map<String, Object> map) throws Exception {
		dao.outItemInsert(map);
	}
	
	// 금일 출고리스트 조회
	@Override
	public List<Map<String, Object>> todayOutItem() throws Exception {
		return dao.todayOutItem();
	}
	
	// 추가된 금일 출고리스트 행 - 바로조회
	@Override
	public Map<String, Object> todayOutItem(String insertOutItemCode) throws Exception {
		return dao.todayOutItem(insertOutItemCode);
	}

	// 상품 조회 리스트 수량 최종 결과
	@Override
	public Map<String, Object> resultAmt(String itemCode) throws Exception {
		return dao.resultAmt(itemCode);
	}

}
