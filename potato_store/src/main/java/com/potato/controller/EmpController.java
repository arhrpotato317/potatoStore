package com.potato.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.potato.service.EmpService;

import net.minidev.json.JSONObject;
import net.minidev.json.parser.JSONParser;

@Controller
public class EmpController {
	
	private static final Logger logger = LoggerFactory.getLogger(EmpController.class);
	
	@Autowired
	EmpService service;

	// 사원명부 리스트 Ajax
	@RequestMapping(value = "/allEmpAjax", method = RequestMethod.POST)
	@ResponseBody
	public JSONObject allEmpAjax() throws Exception {
		logger.info("allEmpAjax");
		
		List<Map<String, Object>> empList = service.getEmpList();
		
		JSONObject allEmpList = new JSONObject();
		allEmpList.put("empList", empList);
		
		return allEmpList;
	}
	
	@RequestMapping(value = "/oneEmpAjax", method = RequestMethod.POST)
	@ResponseBody
	public JSONObject oneEmpAjax(@RequestBody String ajaxRtn) throws Exception {
		logger.info("oneEmpAjax");
		
		// JSON형식의 문자열을 JSON객체로 파싱
		JSONParser jsonParser = new JSONParser();
		JSONObject ajaxCode = (JSONObject) jsonParser.parse(ajaxRtn);
		String empNo = (String) ajaxCode.get("empNo");
		String empDeptNo = (String) ajaxCode.get("empDeptNo");
		
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("empNo", empNo);
		paramMap.put("empDeptNo", empDeptNo);
		
		List<Map<String, Object>> empList = service.getEmpList(paramMap);
		
		JSONObject oneEmpList = new JSONObject();
		oneEmpList.put("empList", empList);
		
		return oneEmpList;
	}
}








































