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

import com.potato.service.EmpService;

import net.minidev.json.JSONObject;

@Controller
public class EmpController {
	
	private static final Logger logger = LoggerFactory.getLogger(EmpController.class);
	
	@Autowired
	EmpService service;

	// 사원 명부 리스트 가져오기 Ajax
	@RequestMapping(value = "/allEmpAjax", method = RequestMethod.POST)
	@ResponseBody
	public JSONObject getEmpList() throws Exception {
		logger.info("getEmpList");
		
		List<Map<String, Object>> empList = service.getEmpList();
		
		JSONObject allEmpList = new JSONObject();
		allEmpList.put("empList", empList);
		
		return allEmpList;
	}
	
}
