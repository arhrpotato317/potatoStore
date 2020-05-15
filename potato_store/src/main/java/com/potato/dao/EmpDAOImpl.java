package com.potato.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class EmpDAOImpl implements EmpDAO {

	@Autowired
	private SqlSession sql;
	
	// 사원명부 리스트
	@Override
	public List<Map<String, Object>> getEmpList() throws Exception {
		return sql.selectList("emp.getEmpList");
	}

	@Override
	public List<Map<String, Object>> getEmpList(Map<String, Object> map) throws Exception {
		return sql.selectList("emp.getEmpList", map);
	}

}
