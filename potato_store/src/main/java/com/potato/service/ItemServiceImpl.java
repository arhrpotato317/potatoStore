package com.potato.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.potato.dao.ItemDAO;

@Service
public class ItemServiceImpl implements ItemService {
	
	@Autowired
	private ItemDAO dao;

	// 전체 상품 리스트
	@Override
	public List<Map<String, Object>> getAllItemList() throws Exception {
		return dao.getAllItemList();
	}

	// 카테고리 리스트
	@Override
	public List<Map<String, Object>> getCateOneList(String upCode) throws Exception {
		return dao.getCateOneList(upCode);
	}

	// 카테고리 조회
	@Override
	public List<Map<String, Object>> getCateList(String cateTwo) throws Exception {
		return dao.getCateList(cateTwo);
	}

	// 금일 입고리스트에 데이터 저장
	@Override
	public void setInItemToday(Map<String, Object> map) throws Exception {
		dao.setInItemToday(map);
	}

	// 상품 입고 시 물품관리테이블 재고수량 변경
	@Override
	public void stockAmtChange(Map<String, Object> map) throws Exception {
		dao.stockAmtChange(map);
	}

	// 금일 입고리스트 조회
	@Override
	public List<Map<String, Object>> getTodayItemList() throws Exception {
		return dao.getTodayItemList();
	}

	// 추가된 금일 입고리스트 행 - 바로조회
	@Override
	public Map<String, Object> getTodayItemList(String insertItemCode) throws Exception {
		return dao.getTodayItemList(insertItemCode);
	}

	// 물품테이블 수량 조회
	@Override
	public Map<String, Object> getItemStock(String itemCode) throws Exception {
		return dao.getItemStock(itemCode);
	}

}


















