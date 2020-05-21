package com.potato.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.potato.service.ItemService;

import net.minidev.json.JSONObject;
import net.minidev.json.parser.JSONParser;

@Controller
@RequestMapping("/item/*")
public class ItemController {
	
	private static final Logger logger = LoggerFactory.getLogger(ItemController.class);
	
	@Autowired
	ItemService service;

	// 상품 입고
	@RequestMapping(value = "/initem", method = RequestMethod.GET)
	public void itemInitem(Model model) throws Exception {
		logger.info("item initem");
		
		// 상품 첫화면 - 첫번째 카테고리 리스트
		List<Map<String, Object>> cateOneList = service.getCateOneList("C0001");
		model.addAttribute("cateOneList", cateOneList);
		
		// 금일 입고리스트 조회
		List<Map<String, Object>> todayItemList = service.getTodayItemList();
		model.addAttribute("todayItemList", todayItemList);
	}
	
	// 전체 상품 리스트 Ajax
	@RequestMapping(value = "/allItemAjax", method = RequestMethod.POST)
	@ResponseBody
	public JSONObject allItemAjax() throws Exception {
		logger.info("item allItemAjax");
		
		List<Map<String, Object>> allItemList = service.getAllItemList();
		
		JSONObject itemList = new JSONObject();
		itemList.put("allItemList", allItemList);
		
		return itemList;
	}
	
	// 첫번째 카테고리에 따른 두번째 카테고리 리스트 Ajax
	@RequestMapping(value = "/cateOneChangeAjax", method = RequestMethod.POST)
	@ResponseBody
	public JSONObject cateOneChangeAjax(@RequestBody String ajaxRtn) throws Exception {
		logger.info("item cateOneChangeAjax");
		
		JSONParser jsonParser = new JSONParser();
		JSONObject ajaxOneCode = (JSONObject)jsonParser.parse(ajaxRtn);
		String cateOne = (String) ajaxOneCode.get("cateOne");
		
		List<Map<String, Object>> cateOneChange = service.getCateOneList(cateOne);
		
		JSONObject cateTwoList = new JSONObject();
		cateTwoList.put("cateOneChange", cateOneChange);
		
		return cateTwoList;
	}
	
	// 카테고리 조회 결과 Ajax
	@RequestMapping(value = "/submitCateAjax", method = RequestMethod.POST)
	@ResponseBody
	public JSONObject submitCateAjax(@RequestBody String ajaxRtn) throws Exception {
		logger.info("item submitCateAjax");
		
		JSONParser jsonParser = new JSONParser();
		JSONObject ajaxOneCode = (JSONObject)jsonParser.parse(ajaxRtn);
		String cateTwo = (String) ajaxOneCode.get("cateTwo");
		
		List<Map<String, Object>> submitCate = service.getCateList(cateTwo);
		
		JSONObject cateList = new JSONObject();
		cateList.put("submitCate", submitCate);
		
		return cateList;
	}
	
	// 금일 입고리스트 Ajax (저장버튼)
	@RequestMapping(value = "/inItemSaveAjax", method = RequestMethod.POST)
	@ResponseBody
	public JSONObject inItemSaveAjax(@RequestBody String ajaxRtn) throws Exception {
		logger.info("item inItemSaveAjax");
		
		JSONParser jsonParser = new JSONParser();
		JSONObject ajaxOneCode = (JSONObject)jsonParser.parse(ajaxRtn);
		String itemCode = (String) ajaxOneCode.get("itemCode"); //상품코드
		String itemCheck = (String) ajaxOneCode.get("itemCheck"); //추가,수정 구분코드
		int inStock = Integer.parseInt((String) ajaxOneCode.get("inStock")); //변경 입고수량
		
		JSONObject todayItemList = new JSONObject();
		
		if(itemCheck.length() == 0) {
			// 입고리스트 추가 로직
			Map<String, Object> paramMap = new HashMap<String, Object>();
			paramMap.put("itemCode", itemCode);
			paramMap.put("inStock", inStock);
			paramMap.put("updateStock", inStock);
			
			// 입고수량만큼 물품테이블 재고수량 증가
			paramMap.put("upDown", "up");
			service.stockAmtChange(paramMap);
			
			// 금일 입고리스트 Insert
			service.setInItemToday(paramMap);
			String insertItemCode = (String) paramMap.get("INSITEMLISTCD"); // insert 상품코드
			
			// 추가된 금일 입고리스트 행 - 바로조회 Ajax
			Map<String, Object> getTodayItemOne = service.getTodayItemList(insertItemCode);
			// 전체 상품 조회 수량변경 Ajax
			Map<String, Object> itemStock = service.getItemStock(itemCode);
			
			todayItemList.put("getTodayItemOne", getTodayItemOne);
			todayItemList.put("itemStock", itemStock);
			
		} else {
			// 입고리스트 수정 로직
			int oldStock = Integer.parseInt((String) ajaxOneCode.get("oldStock")); //변경 전 입고수량
			
			Map<String, Object> paramMap = new HashMap<String, Object>();
			paramMap.put("itemCode", itemCode);
			paramMap.put("itemCheck", itemCheck);
			paramMap.put("inStock", inStock);
			
			// 입고수량 변경만큼 물품테이블 재고수량 변경
			if(oldStock > inStock) {
				// 수정한 수량이 더 적다면 차액을 -
				int updateStock = oldStock - inStock;
				paramMap.put("updateStock", updateStock);
				paramMap.put("upDown", "down");
			} else {
				// 수정한 수량이 더 적다면 차액을 +
				int updateStock = inStock - oldStock;
				paramMap.put("updateStock", updateStock);
				paramMap.put("upDown", "up");
			}
			service.stockAmtChange(paramMap);
			
			// 금일 입고리스트 update
			service.setTodayItemStock(paramMap);
			
			// 전체 상품 조회 수량변경 Ajax
			Map<String, Object> itemStock = service.getItemStock(itemCode);
			
			todayItemList.put("setTodayItemOne", paramMap);
			todayItemList.put("itemStock", itemStock);
		}
		
		return todayItemList;
	}
}





































