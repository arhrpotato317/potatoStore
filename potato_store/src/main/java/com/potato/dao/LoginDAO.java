package com.potato.dao;

import java.util.Map;

public interface LoginDAO {
	
	// 로그인
	public Map<String, Object> getLogin(Map<String, Object> map) throws Exception;
	
	// 회원가입 아이디 중복체크
	public int getIdChk(String insertId) throws Exception;
	
	// 회원가입
	public void insertJoin(Map<String, Object> map) throws Exception;
}
