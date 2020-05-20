package com.potato.controller;

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
}





































