package com.potato.service;

import java.util.List;
import java.util.Map;

public interface OutItemService {
	
	// 출고관리 테이블에 추가하기
	public void outItemInsert(Map<String, Object> map) throws Exception;
	
	// 금일 출고리스트 조회
	public List<Map<String, Object>> todayOutItem() throws Exception;
	
	// 추가된 금일 출고리스트 행 - 바로조회
	public Map<String, Object> todayOutItem(String insertOutItemCode) throws Exception;
	
	// 상품 조회 리스트 수량 최종 결과
	public Map<String, Object> resultAmt(String itemCode) throws Exception;
	
	// 출고 테이블 정보 수정
	public void outItemUpdate(Map<String, Object> map) throws Exception;
	
}
