package com.potato.service;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.potato.dao.LoginDAO;

@Service
public class LoginServiceImpl implements LoginService {

	@Autowired
	private LoginDAO dao;
	
	// 로그인
	@Override
	public Map<String, Object> getLogin(Map<String, Object> map) throws Exception {
		return dao.getLogin(map);
	}
}
