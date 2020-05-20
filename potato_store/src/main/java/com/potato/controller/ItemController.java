package com.potato.controller;

import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.potato.service.ItemService;

import net.minidev.json.JSONObject;

@Controller
@RequestMapping("/item/*")
public class ItemController {
	
	private static final Logger logger = LoggerFactory.getLogger(ItemController.class);
	
	@Autowired
	ItemService service;

	// 상품 입고
	@RequestMapping(value = "/initem", method = RequestMethod.GET)
	public void itemInitem() throws Exception {
		logger.info("item initem");
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
}





































