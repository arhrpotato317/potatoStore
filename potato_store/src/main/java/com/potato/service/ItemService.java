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
	
	// 금일 입고리스트에 데이터 저장
	public void setInItemToday(Map<String, Object> map) throws Exception;
	
	// 상품 입고 시 물품관리테이블 재고수량 변경
	public void stockAmtChange(Map<String, Object> map) throws Exception;
	
	// 금일 입고리스트 조회
	public List<Map<String, Object>> getTodayItemList() throws Exception;
	
	// 추가된 금일 입고리스트 행 - 바로조회
	public Map<String, Object> getTodayItemList(String insertItemCode) throws Exception;
	
	// 물품테이블 수량 조회
	public Map<String, Object> getItemStock(String itemCode) throws Exception;
}
