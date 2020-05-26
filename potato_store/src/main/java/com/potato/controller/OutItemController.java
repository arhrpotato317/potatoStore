package com.potato.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.potato.service.ItemService;
import com.potato.service.OutItemService;

import net.minidev.json.JSONObject;
import net.minidev.json.parser.JSONParser;

@Controller
@RequestMapping("/item/*")
public class OutItemController {
	
	private static final Logger logger = LoggerFactory.getLogger(OutItemController.class);
	
	@Autowired
	ItemService inService;
	
	@Autowired
	OutItemService outService;

	// 상품 출고
	@RequestMapping(value = "/outitem", method = RequestMethod.GET)
	public void itemOutitem(Model model) throws Exception {
		logger.info("item outitem");
		
		// 상품 첫화면 - 첫번째 카테고리 리스트
		List<Map<String, Object>> cateOneList = inService.getCateOneList("C0001");
		model.addAttribute("cateOneList", cateOneList);
		
		// 금일 출고리스트 조회
		List<Map<String, Object>> todayOutItemList = outService.todayOutItem();
		model.addAttribute("todayOutItemList", todayOutItemList);
		
		// 배송회사 리스트 조회
		List<Map<String, Object>> addrCompanyList = inService.getCateOneList("C0080");
		model.addAttribute("addrCompanyList", addrCompanyList);
	}
	
	// 금일 출고리스트 Ajax (저장버튼)
	@RequestMapping(value = "/outItemSaveAjax", method = RequestMethod.POST)
	@ResponseBody
	public JSONObject outItemSaveAjax(@RequestBody String ajaxRtn) throws Exception {
		logger.info("item outItemSaveAjax");
		
		JSONParser jsonParser = new JSONParser();
		JSONObject ajaxOneCode = (JSONObject)jsonParser.parse(ajaxRtn);
		
		String itemCode = (String) ajaxOneCode.get("itemCode"); //상품코드
		String itemCheck = (String) ajaxOneCode.get("itemCheck"); //추가,수정 구분코드
		String outUserId = (String) ajaxOneCode.get("outUserId"); //회원아이디
		String userName = (String) ajaxOneCode.get("userName"); //회원이름
		int outStock = Integer.parseInt((String) ajaxOneCode.get("outStock")); //변경 출고수량
		String checkYn = ""; //검수여부
		String delivYn = ""; //변경 배송여부
		String readyDelivYn = ""; //기존 배송여부
		String addrCompany = (String) ajaxOneCode.get("addrCompany"); //배송회사
		String invoiceNum = (String) ajaxOneCode.get("invoiceNum"); //송장번호
		
		if((Boolean) ajaxOneCode.get("checkYn") == true) {
			checkYn = "Y";
		} else {
			checkYn = "N";
		}
		
		if((Boolean) ajaxOneCode.get("delivYn") == true) {
			delivYn = "Y";
		} else {
			delivYn = "N";
		}
		
		if((Boolean) ajaxOneCode.get("readyDelivYn") == true) {
			readyDelivYn = "Y";
		} else {
			readyDelivYn = "N";
		}
		
		// DB테이블 저장 Map
		Map<String, Object> paramMap = new HashMap<String, Object>(); 
		paramMap.put("itemCode", itemCode);
		paramMap.put("userId", outUserId);
		paramMap.put("userName", userName);
		paramMap.put("delivAmt", outStock);
		paramMap.put("checkYn", checkYn);
		paramMap.put("delivYn", delivYn);
		paramMap.put("delivcorpCd", addrCompany);
		paramMap.put("delivNo", invoiceNum);
		
		// Ajax로 보내 줄 JSON
		JSONObject todayOutItemList = new JSONObject();
		
		if(itemCheck.length() == 0) {
			// 출고리스트 추가 로직
			
			// 배송여부가 체크되어 있을 시
			if(delivYn.equals("Y")) {
				// 출고수량만큼 물품테이블 재고수량 변경
				paramMap.put("updateStock", outStock);
				paramMap.put("upDown", "down");
				inService.stockAmtChange(paramMap);
			}
			
			// 금일 출고리스트 Insert
			outService.outItemInsert(paramMap);
			String insertOutItemCode = (String) paramMap.get("OUTITEMLISTCD"); // insert 상품코드
			
			// 추가된 금일 출고리스트 행 - 바로조회 Ajax
			Map<String, Object> getTodayOutItemOne = outService.todayOutItem(insertOutItemCode);
			todayOutItemList.put("getTodayOutItemOne", getTodayOutItemOne);
			
		} else {
			// 출고리스트 수정 로직
		}
		
		// 상품 조회 리스트 수량 최종 결과
		Map<String, Object> resultAmt = outService.resultAmt(itemCode);
		todayOutItemList.put("resultAmt", resultAmt);
		
		return todayOutItemList;
	}
}





































