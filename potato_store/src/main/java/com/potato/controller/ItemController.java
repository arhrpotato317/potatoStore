package com.potato.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping("/item/*")
public class ItemController {
	
	private static final Logger logger = LoggerFactory.getLogger(ItemController.class);

	// 상품 입고
	@RequestMapping(value = "/initem", method = RequestMethod.GET)
	public void itemInitem() throws Exception {
		logger.info("item initem");
	}
}





































