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

}
