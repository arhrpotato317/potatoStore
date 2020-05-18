package com.potato.service;

import java.util.Map;

import javax.servlet.http.HttpSession;

public interface LoginService {
	
	// 로그인
	public Map<String, Object> getLogin(Map<String, Object> map) throws Exception;
	// 로그아웃
	public void logout(HttpSession session) throws Exception;
}
