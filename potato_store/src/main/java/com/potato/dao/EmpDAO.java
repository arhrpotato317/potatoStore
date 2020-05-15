package com.potato.dao;

import java.util.List;
import java.util.Map;

public interface EmpDAO {
	
	// 사원명부 리스트
	public List<Map<String, Object>> getEmpList() throws Exception;
	public List<Map<String, Object>> getEmpList(Map<String, Object> map) throws Exception;
}
