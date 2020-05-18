package com.potato.dao;

import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class LoginDAOImpl implements LoginDAO {

	@Autowired
	private SqlSession sql;	
	
	// 로그인
	@Override
	public Map<String, Object> getLogin(Map<String, Object> map) throws Exception {
		return sql.selectOne("login.getLogin", map);
	}

	// 회원가입 아이디 중복체크
	@Override
	public int getIdChk(String insertId) throws Exception {
		return sql.selectOne("login.getIdChk", insertId);
	}

}
