package com.potato.dao;

import java.util.Map;

public interface LoginDAO {
	
	// 로그인
	public Map<String, Object> getLogin(Map<String, Object> map) throws Exception;
}
