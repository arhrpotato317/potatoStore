package com.potato.service;

import java.util.List;
import java.util.Map;

public interface EmpService {
	
	// 사원 목록 가져오기
	public List<Map<String, Object>> getEmpList() throws Exception;
}
