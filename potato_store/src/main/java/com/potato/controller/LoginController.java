package com.potato.controller;

import java.util.HashMap;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.potato.service.LoginService;

import net.minidev.json.JSONObject;
import net.minidev.json.parser.JSONParser;

@Controller
public class LoginController {
	
	private static final Logger logger = LoggerFactory.getLogger(LoginController.class);
	
	@Autowired
	LoginService service;

	// 로그인 처리 Ajax
	@RequestMapping(value = "/loginAjax", method = RequestMethod.POST)
	@ResponseBody
	public JSONObject loginAjax(@RequestBody String ajaxRtn) throws Exception {
		logger.info("loginAjax");
		
		JSONParser jsonParser = new JSONParser();
		JSONObject ajaxCode = (JSONObject) jsonParser.parse(ajaxRtn);
		String userId = (String) ajaxCode.get("userId");
		String userPass = (String) ajaxCode.get("userPass");
		
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("userId", userId);
		paramMap.put("userPass", userPass);
		
		Map<String, Object> loginCheck = service.getLogin(paramMap);
		
		JSONObject loginCheckRtn = new JSONObject();
		
		if(loginCheck == null) {
			// 아이디 비밀번호와 일치하는 정보가 없을 경우
			loginCheckRtn.put("msg", "로그인에 실패하셨습니다.");
		} else {
			loginCheckRtn.put("loginCheck", loginCheck);
		}
		
		return loginCheckRtn;
	}
	
}





































