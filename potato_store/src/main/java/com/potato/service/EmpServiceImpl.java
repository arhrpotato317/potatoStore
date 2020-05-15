package com.potato.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.potato.dao.EmpDAO;

@Service
public class EmpServiceImpl implements EmpService {

	@Autowired
	private EmpDAO dao;
	
	// 사원명부 리스트
	@Override
	public List<Map<String, Object>> getEmpList() throws Exception {
		return dao.getEmpList();
	}

	@Override
	public List<Map<String, Object>> getEmpList(Map<String, Object> map) throws Exception {
		return dao.getEmpList(map);
	}

}
