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
	
	// 사원 목록 가져오기
	@Override
	public List<Map<String, Object>> getEmpList() throws Exception {
		return dao.getEmpList();
	}

}
