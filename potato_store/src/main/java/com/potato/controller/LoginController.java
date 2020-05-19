package com.potato.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
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
	public JSONObject loginAjax(@RequestBody String ajaxRtn, HttpSession session) throws Exception {
		logger.info("loginAjax");
		
		// 기존 세션값 제거
		if(session.getAttribute("login") != null) {
			session.removeAttribute("login");
		}
		
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
			// 인터셉터 설정 - 세션에 'login'이름으로 객체를 저장
			session.setAttribute("login", loginCheck);
		}
		
		return loginCheckRtn;
	}
	
	// 로그아웃
	@RequestMapping(value = "/logout", method = RequestMethod.GET)
	public String logout(HttpSession session) throws Exception {
		logger.info("logout");
		service.logout(session);
		return "redirect:/";
	}
	
	// 회원가입 아이디 중복체크 Ajax
	@RequestMapping(value = "/idChkAjax", method = RequestMethod.POST)
	@ResponseBody
	public int idChkAjax(@RequestParam("insertId") String insertId) throws Exception {
		logger.info("idChkAjax");
		int idChkCnt = service.getIdChk(insertId);
		return idChkCnt;
	}
	
	// 회원가입 처리 Ajax
	@RequestMapping(value = "/submitJoinAjax", method = RequestMethod.POST)
	@ResponseBody
	public JSONObject submitJoinAjax(@RequestBody String ajaxRtn) throws Exception {
		logger.info("submitJoinAjax");

		JSONParser jsonParser = new JSONParser();
		JSONObject ajaxCode = (JSONObject) jsonParser.parse(ajaxRtn);
		String insertId = (String) ajaxCode.get("insertId");
		String insertPass = (String) ajaxCode.get("insertPassChk");
		String insertName = (String) ajaxCode.get("insertName");
		
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("insertId", insertId);
		paramMap.put("insertPass", insertPass);
		paramMap.put("insertName", insertName);
		
		service.insertJoin(paramMap);

		JSONObject joinRtn = new JSONObject();
		joinRtn.put("msg", "success");

		return joinRtn;
	}
	
}





































