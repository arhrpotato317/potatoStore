<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<html>
<head>
	<title>Potato Store</title>
	<script type="text/javascript">
		var ajax = new XMLHttpRequest();
		
		// 전체 상품 리스트 팝업 Ajax
		function allItemPop() {
			document.querySelector('.pop_back').style.display = 'block';
			document.querySelector('.allItem').style.display = 'block';
			document.getElementById("allItemBody").innerHTML = "";
			
			ajax.onreadystatechange = allItemAjax;
			ajax.open("POST", "./allItemAjax", true);
			ajax.send();
		}
		function allItemAjax() {
			if(ajax.readyState === XMLHttpRequest.DONE) {
				if(ajax.status === 200) {
					var response = JSON.parse(ajax.responseText);
					var resultHtml = "";
					for(var i=0; i<response.allItemList.length; i++) {
						resultHtml += '<tr>\
								<td>'+response.allItemList[i].CDNO+'</td>\
								<td>'+response.allItemList[i].CDLVL+'</td>\
								<td>'+response.allItemList[i].UPCD+'</td>\
								<td>'+response.allItemList[i].CDNAME+'</td>\
								<td><input type="checkbox" '+response.allItemList[i].USEYN+' disabled></td>\
							</tr>';
					}
					document.getElementById("allItemBody").innerHTML = resultHtml;
				} else {
					alert("실패");
				}
			}
		}
		
		// 첫번째 카테고리에 따른 두번째 카테고리 리스트 Ajax
		function cateOneChange() {
			var cateOne = document.getElementById("cateOne").value;
			var data = {
				"cateOne": cateOne
			}
			
			ajax.onreadystatechange = cateOneChangeAjax;
			ajax.open("POST", "./cateOneChangeAjax", true);
			ajax.setRequestHeader('Content-Type', 'application/json');
			ajax.send(JSON.stringify(data));
		}
		function cateOneChangeAjax() {
			if(ajax.readyState === XMLHttpRequest.DONE) {
				if(ajax.status === 200) {
					var response = JSON.parse(ajax.responseText);
					var resultHtml = "";
					for(var i=0; i<response.cateOneChange.length; i++) {
						resultHtml += '<option value="'+response.cateOneChange[i].CDNO+'">'+response.cateOneChange[i].CDNAME+'</option>';
					}
					document.getElementById("cateTwo").innerHTML = resultHtml;
				} else {
					alert("실패");
				}
			}
		}
		
		// 카테고리 조회 결과 Ajax
		function submitCate() {
			var cateTwo = document.getElementById("cateTwo").value;
			var data = {
				"cateTwo": cateTwo
			}
			
			ajax.onreadystatechange = submitCateAjax;
			ajax.open("POST", "./submitCateAjax", true);
			ajax.setRequestHeader('Content-Type', 'application/json');
			ajax.send(JSON.stringify(data));
		}
		function submitCateAjax() {
			if(ajax.readyState === XMLHttpRequest.DONE) {
				if(ajax.status === 200) {
					var response = JSON.parse(ajax.responseText);
					
					if(response.submitCate.length == 0) {
						alert("조회된 결과가 없습니다.");
						return false;
					}
					
					var resultHtml = "";
					for(var i=0; i<response.submitCate.length; i++) {
						resultHtml += '<tr>\
								<td>'+response.submitCate[i].ITEMCD+'</td>\
								<td>'+response.submitCate[i].ITEMNAME+'</td>\
								<td>'+response.submitCate[i].MADENMCD+'</td>\
								<td>'+response.submitCate[i].MADENMNAME+'</td>\
								<td>'+response.submitCate[i].ITEMUNITCD+'</td>\
								<td>'+response.submitCate[i].ITEMUNITNAME+'</td>\
								<td>'+response.submitCate[i].STOCKAMT+'</td>\
								<td><input type="checkbox" '+response.submitCate[i].STOCKYN+' disabled></td>\
								<td><input type="checkbox" '+response.submitCate[i].USEYN+' disabled></td>\
							</tr>';
					}
					document.getElementById("cateItemBody").innerHTML = resultHtml;
					
					// 상품 테이블 클릭
					var itemTable = document.getElementById("cateItemTable");
					var itemTableTr = itemTable.getElementsByTagName("tr");
					for(var i=0; i<itemTableTr.length; i++) {
						itemTableTr[i].addEventListener("click", function() {
							tableClick(this.children);
						});
					}
				} else {
					alert("실패");
				}
			}
		}
		
		// 상품 테이블 클릭 -> 출고내용
		function tableClick(itemTdArr) {
			var itemCode = itemTdArr[0].innerHTML; //상품코드
			var itemName = itemTdArr[1].innerHTML; //상품명
			var madeCompanyCode = itemTdArr[2].innerHTML; //제조사코드
			var madeCompany = itemTdArr[3].innerHTML; //제조사
			var unitName = itemTdArr[5].innerHTML; //단위명
			
			document.getElementById("itemCode").value = itemCode;
			document.getElementById("itemName").value = itemName;
			document.getElementById("madeCompany").value = madeCompany;
			document.getElementById("madeCompanyCode").value = madeCompanyCode;
			document.getElementById("unitName").value = unitName;
			
			// 빈칸 세팅
			document.getElementById("itemCheck").value = "";
			document.getElementById("outUserId").value = ""; //회원아이디
			document.getElementById("userName").value = ""; //회원이름
			document.getElementById("invoiceNum").value = ""; //송장번호
			document.getElementById("outStock").value = ""; //변경 출고수량
			document.getElementById("oldStock").value = ""; //기존 출고수량
			document.getElementById("checkYn").checked = false; //검수여부
			document.getElementById("delivYn").checked = false; //변경 배송여부
			document.getElementById("readyDelivYn").checked = false; //기존 배송여부
			document.getElementById("addrCompany").selectedIndex = "0"; //배송회사
			
			// 입력 가능 세팅
			document.getElementById("outUserId").readOnly = true;
			document.getElementById("userName").readOnly = true;
			document.getElementById("invoiceNum").readOnly = true;
			document.getElementById("outStock").readOnly = true;
			document.getElementById("checkYn").disabled = true;
			document.getElementById("delivYn").disabled = true;
		}
		
		// 수정버튼 클릭 -> 입력 가능
		function outItemEdit() {
			document.getElementById("outUserId").readOnly = false;
			document.getElementById("userName").readOnly = false;
			document.getElementById("invoiceNum").readOnly = false;
			document.getElementById("outStock").readOnly = false;
			document.getElementById("checkYn").disabled = false;
			document.getElementById("delivYn").disabled = false;
		}
		
		// 저장버튼 클릭
		function outItemSave() {
			var itemCode = document.getElementById("itemCode").value; //상품코드
			var itemCheck = document.getElementById("itemCheck").value; //추가,수정 구분코드
			var itemName = document.getElementById("itemName").value; //상품명
			var madeCompany = document.getElementById("madeCompany").value; //제조사
			var madeCompanyCode = document.getElementById("madeCompanyCode").value; //제조사 코드
			var unitName = document.getElementById("unitName").value; //단위명
			var outUserId = document.getElementById("outUserId").value; //회원아이디
			var userName = document.getElementById("userName").value; //회원이름
			var invoiceNum = document.getElementById("invoiceNum").value; //송장번호
			var outStock = document.getElementById("outStock").value; //변경 출고수량
			var oldStock = document.getElementById("oldStock").value; //기존 출고수량
			var checkYn = document.getElementById("checkYn").checked; //검수여부
			var delivYn = document.getElementById("delivYn").checked; //변경 배송여부
			var readyDelivYn = document.getElementById("readyDelivYn").checked; //기존 배송여부
			var addrCompany = document.getElementById("addrCompany").value; //배송회사
			
			if(itemCode == '' || itemName == '' || madeCompany == '' || unitName == '') {
				alert("상품 조회 리스트에서 상품을 선택해주세요.");
				return false;
			}
			
			if(outUserId == '' || userName == '' || invoiceNum == '' || outStock == '' || addrCompany.selectedIndex == '0') {
				alert("수정 버튼을 눌러 입력을 완성해주세요.");
				return false;
			}
			
			var data = {
				"itemCode": itemCode,
				"itemCheck": itemCheck,
				"itemName": itemName,
				"madeCompany": madeCompany,
				"madeCompanyCode": madeCompanyCode,
				"unitName": unitName,
				"outUserId": outUserId,
				"userName": userName,
				"invoiceNum": invoiceNum,
				"outStock": outStock,
				"oldStock": oldStock,
				"checkYn": checkYn,
				"delivYn": delivYn,
				"readyDelivYn": readyDelivYn,
				"addrCompany": addrCompany
			}
			
			ajax.onreadystatechange = outItemSaveAjax;
			ajax.open("POST", "./outItemSaveAjax", true);
			ajax.setRequestHeader('Content-Type', 'application/json');
			ajax.send(JSON.stringify(data));
		}
		function outItemSaveAjax() {
			if(ajax.readyState === XMLHttpRequest.DONE) {
				if(ajax.status === 200) {
					var response = JSON.parse(ajax.responseText);
					
					if(response.hasOwnProperty("getTodayOutItemOne")) {
						// 출고리스트 추가 로직
						
						// 검수여부, 사용여부
						var checkYn, delivYn = "";
						if(response.getTodayOutItemOne.CHECKYN == 'Y') {
							checkYn = "checked";
						}
						if(response.getTodayOutItemOne.DELIVYN == 'Y') {
							delivYn = "checked";
						}
						
						var todayTable = document.getElementById("inItemBody");
						var todayTableTr = todayTable.insertRow(todayTable.rows.length);
						todayTableTr.innerHTML = '<tr>\
							<td>'+response.getTodayOutItemOne.ITEMCD+'</td>\
							<td>'+response.getTodayOutItemOne.ITEMNAME+'</td>\
							<td>'+response.getTodayOutItemOne.MADENMCD+'</td>\
							<td>'+response.getTodayOutItemOne.MADENMNAME+'</td>\
							<td>'+response.getTodayOutItemOne.ITEMUNITNAME+'</td>\
							<td>'+response.getTodayOutItemOne.DELIVAMT+'</td>\
							<td>'+response.getTodayOutItemOne.ID+'</td>\
							<td>'+response.getTodayOutItemOne.INSUSER+'</td>\
							<td>'+response.getTodayOutItemOne.RELCD+'</td>\
							<td>'+response.getTodayOutItemOne.ADDRCD+'</td>\
							<td>'+response.getTodayOutItemOne.ADDRNAME+'</td>\
							<td>'+response.getTodayOutItemOne.MOBILETELNO+'</td>\
							<td>'+response.getTodayOutItemOne.HOMETELNO+'</td>\
							<td><input type="checkbox" '+checkYn+' disabled></td>\
							<td><input type="checkbox" '+delivYn+' disabled></td>\
							<td style="display:none;"><input type="hidden" value="'+response.getTodayOutItemOne.DELIVNO+'"></td>\
							<td style="display:none;"><input type="hidden" value="'+response.getTodayOutItemOne.DELIVCORPCD+'"></td>\
							<td style="display:none;"><input type="hidden" value="'+response.getTodayOutItemOne.OUTITEMLISTCD+'"></td>\
						</tr>';
						
						alert("출고상품이 추가되었습니다.");
						
						// 빈칸 세팅
						document.getElementById("outUserId").value = ""; //회원아이디
						document.getElementById("userName").value = ""; //회원이름
						document.getElementById("invoiceNum").value = ""; //송장번호
						document.getElementById("outStock").value = ""; //변경 출고수량
						document.getElementById("oldStock").value = ""; //기존 출고수량
						document.getElementById("checkYn").checked = false; //검수여부
						document.getElementById("delivYn").checked = false; //변경 배송여부
						document.getElementById("readyDelivYn").checked = false; //기존 배송여부
						document.getElementById("addrCompany").selectedIndex = "0"; //배송회사
						
						// 입력 가능 세팅
						document.getElementById("outUserId").readOnly = true;
						document.getElementById("userName").readOnly = true;
						document.getElementById("invoiceNum").readOnly = true;
						document.getElementById("outStock").readOnly = true;
						document.getElementById("checkYn").disabled = true;
						document.getElementById("delivYn").disabled = true;
						
						todayTableTr.addEventListener("click", function() {
							todayClick(this.children);
						});
						
					} else if(response.hasOwnProperty("setTodayOutItemOne")) {
						// 출고리스트 수정 로직
						var itemTable = document.getElementById("inItemBody");
						var itemTableTr = itemTable.rows;
						
						for(var i=0; i<itemTableTr.length; i++) {
							if(itemTableTr[i].children[17].firstChild.value == response.setTodayOutItemOne.OUTITEMLISTCD) {
								itemTableTr[i].children[15].firstChild.value = response.setTodayOutItemOne.DELIVNO; // 송장번호 즉시 변경
								itemTableTr[i].children[5].innerText = response.setTodayOutItemOne.DELIVAMT; // 출고수량 즉시 변경
								
								// 검수여부 즉시 변경
								if(response.setTodayOutItemOne.CHECKYN == 'Y') {
									itemTableTr[i].children[13].firstChild.checked = true;
								} else {
									itemTableTr[i].children[13].firstChild.checked = false;
								}
								
								// 배송여부 즉시 변경
								if(response.setTodayOutItemOne.DELIVYN == 'Y') {
									itemTableTr[i].children[14].firstChild.checked = true;
								} else {
									itemTableTr[i].children[14].firstChild.checked = false;
								}
								
								itemTableTr[i].children[16].firstChild.value = response.setTodayOutItemOne.DELIVCORPCD; // 배송회사 즉시 변경
							}
						}
						
						alert("출고상품이 수정되었습니다.");
						
						// 빈칸 세팅
						document.getElementById("itemCheck").value = "";
						document.getElementById("outUserId").value = ""; //회원아이디
						document.getElementById("userName").value = ""; //회원이름
						document.getElementById("invoiceNum").value = ""; //송장번호
						document.getElementById("outStock").value = ""; //변경 출고수량
						document.getElementById("oldStock").value = ""; //기존 출고수량
						document.getElementById("checkYn").checked = false; //검수여부
						document.getElementById("delivYn").checked = false; //변경 배송여부
						document.getElementById("readyDelivYn").checked = false; //기존 배송여부
						document.getElementById("addrCompany").selectedIndex = "0"; //배송회사
						
						// 입력 가능 세팅
						document.getElementById("outUserId").readOnly = true;
						document.getElementById("userName").readOnly = true;
						document.getElementById("invoiceNum").readOnly = true;
						document.getElementById("outStock").readOnly = true;
						document.getElementById("checkYn").disabled = true;
						document.getElementById("delivYn").disabled = true;
					}
					
					// 상품 조회 리스트 수량 최종 결과
					var itemTable = document.getElementById("cateItemBody");
					var itemTableTr = itemTable.rows;
					
					for(var i=0; i<itemTableTr.length; i++) {
						if(itemTableTr[i].firstElementChild.innerHTML == response.resultAmt.ITEMCD) {
							itemTableTr[i].children[6].innerText = response.resultAmt.STOCKAMT;
						}
					}
				}
			}
		}
		
		// 금일 출고 리스트 클릭 -> 출고내용
		function todayClick(itemTdArr) {
			var itemCode = itemTdArr[0].innerHTML; //상품코드
			var itemName = itemTdArr[1].innerHTML; //상품명
			var madeCompany = itemTdArr[3].innerHTML; //제조사
			var unitName = itemTdArr[4].innerHTML; //단위명
			var outUserId = itemTdArr[6].innerHTML; //회원아이디
			var userName = itemTdArr[7].innerHTML; //회원이름
			var invoiceNum = itemTdArr[15].firstChild.value; //송장번호
			var outStock = itemTdArr[5].innerHTML; //출고수량
			var checkYn = itemTdArr[13].firstChild.checked; //검수여부
			var delivYn = itemTdArr[14].firstChild.checked; //배송여부
			var itemCheck = itemTdArr[17].firstChild.value; //추가,수정 구분코드
			var delivCompany = itemTdArr[16].firstChild.value; //배송회사
			
			document.getElementById("itemCode").value = itemCode;
			document.getElementById("itemCheck").value = itemCheck;
			document.getElementById("itemName").value = itemName;
			document.getElementById("madeCompany").value = madeCompany;
			document.getElementById("unitName").value = unitName;
			document.getElementById("outUserId").value = outUserId;
			document.getElementById("userName").value = userName;
			document.getElementById("invoiceNum").value = invoiceNum;
			document.getElementById("outStock").value = outStock;
			document.getElementById("oldStock").value = outStock;
			document.getElementById("checkYn").checked = checkYn; //검수여부
			document.getElementById("delivYn").checked = delivYn; //검수여부
			document.getElementById("readyDelivYn").checked = delivYn; //검수여부
			document.getElementById("addrCompany").value = delivCompany; //배송회사
			
			// 입력 가능 세팅
			document.getElementById("outUserId").readOnly = true;
			document.getElementById("userName").readOnly = true;
			document.getElementById("invoiceNum").readOnly = true;
			document.getElementById("outStock").readOnly = true;
			document.getElementById("checkYn").disabled = true;
			document.getElementById("delivYn").disabled = true;
		}
	</script>
</head>
<body>
	<!-- header -->
	<%@ include file="../include/header.jsp" %>
	
	<div class="container">
		<div class="product_wrap">
			<h1>상품 출고</h1>
			<button type="button" onclick="allItemPop();" class="btn_allItem">전체 상품 확인하기</button>
			
			<div class="inner_wrap">
				<div class="inner">
					<h4>상품 조회 리스트</h4>
					
					<div class="input_wrap">
						<div class="input_box">
							<label>카테고리</label>
							<select id="cateOne" onchange="cateOneChange();">
								<option>--- 선택 ---</option>
								<c:forEach items="${cateOneList}" var="one">
									<option value="${one.CDNO}">${one.CDNAME}</option>
								</c:forEach>
							</select>
							<select id="cateTwo">
								<option>--- 선택 ---</option>
							</select>
						</div>
						<button type="button" onclick="submitCate();">조회</button>
					</div>
					
					<div class="in_table">
						<table id="cateItemTable">
							<thead>
								<tr>
									<th>상품코드</th>
									<th>상품명</th>
									<th>제조사코드</th>
									<th>제조사명</th>
									<th>단위코드</th>
									<th>단위명</th>
									<th>재고수량</th>
									<th>재고여부</th>
									<th>사용여부</th>
								</tr>
							</thead>
							<tbody id="cateItemBody"></tbody>
						</table>
					</div>
				</div>
				<div class="inner">
					<h4>금일 출고 리스트</h4>
					
					<div class="in_table">
						<table id="todayTable">
							<thead>
								<tr>
									<th>상품코드</th>
									<th>상품명</th>
									<th>제조사 코드</th>
									<th>제조사명</th>
									<th>단위명</th>
									<th>출고수량</th>
									<th>회원아이디</th>
									<th>회원이름</th>
									<th>관계</th>
									<th>우편번호</th>
									<th>주소</th>
									<th>휴대전화</th>
									<th>집전화</th>
									<th>검수여부</th>
									<th>배송여부</th>
								</tr>
							</thead>
							<tbody id="inItemBody">
								<c:choose>
									<c:when test="${fn:length(todayOutItemList) > 0}">
										<c:forEach items="${todayOutItemList}" var="today">
											<tr onclick="todayClick(this.children);">
												<td>${today.ITEMCD}</td>
												<td>${today.ITEMNAME}</td>
												<td>${today.MADENMCD}</td>
												<td>${today.MADENMNAME}</td>
												<td>${today.ITEMUNITNAME}</td>
												<td>${today.DELIVAMT}</td>
												<td>${today.ID}</td>
												<td>${today.INSUSER}</td>
												<td>${today.RELCD}</td>
												<td>${today.ADDRCD}</td>
												<td>${today.ADDRNAME}</td>
												<td>${today.MOBILETELNO}</td>
												<td>${today.HOMETELNO}</td>
												
												<c:if test="${today.CHECKYN == 'Y'}">
													<td><input type="checkbox" checked disabled></td>
												</c:if>
												<c:if test="${today.CHECKYN == 'N'}">
													<td><input type="checkbox" disabled></td>
												</c:if>
												<c:if test="${today.DELIVYN == 'Y'}">
													<td><input type="checkbox" checked disabled></td>
												</c:if>
												<c:if test="${today.DELIVYN == 'N'}">
													<td><input type="checkbox" disabled></td>
												</c:if>
												
												<td style="display:none;"><input type="hidden" value="${today.DELIVNO}"></td>
												<td style="display:none;"><input type="hidden" value="${today.DELIVCORPCD}"></td>
												<td style="display:none;"><input type="hidden" value="${today.OUTITEMLISTCD}"></td>
											</tr>
										</c:forEach>
									</c:when>
								</c:choose>
							</tbody>
						</table>
					</div>
				</div>
				<div class="inner">
					<h4>출고내용</h4>
					
					<div class="input_box">
						<label for="itemCode">상품코드</label>
						<input type="text" id="itemCode" name="itemCode" readonly>
						<input type="hidden" id="itemCheck" name="itemCheck">
					</div>
					<div class="input_box">
						<label for="itemName">상품명</label>
						<input type="text" id="itemName" name="itemName" readonly>
					</div>
					<div class="input_box">
						<label for="madeCompany">제조사</label>
						<input type="text" id="madeCompany" name="madeCompany" readonly>
						<input type="hidden" id="madeCompanyCode" name="madeCompanyCode">
					</div>
					<div class="input_box">
						<label for="unitName">단위명</label>
						<input type="text" id="unitName" name="unitName" readonly>
					</div>
					<div class="input_box">
						<label for="outUserId">회원아이디</label>
						<input type="text" id="outUserId" name="outUserId" readonly>
					</div>
					<div class="input_box">
						<label for="userName">회원이름</label>
						<input type="text" id="userName" name="userName" readonly>
					</div>
					<div class="input_box">
						<label for="invoiceNum">송장번호</label>
						<input type="text" id="invoiceNum" name="invoiceNum" readonly>
					</div>
					<div class="input_box">
						<label for="outStock">출고수량</label>
						<input type="text" id="outStock" name="outStock" readonly>
						<input type="hidden" id="oldStock" name="oldStock">
					</div>
					<div class="input_box">
						<label for="checkYn">검수여부</label>
						<input type="checkbox" id="checkYn" name="checkYn" disabled>
					</div>
					<div class="input_box">
						<label for="delivYn">배송여부</label>
						<input type="checkbox" id="delivYn" name="delivYn" disabled>
						<input type="checkbox" id="readyDelivYn" name="readyDelivYn" style="display:none;">
					</div>
					<div class="input_box">
						<label for="addrCompany">배송회사</label>
						<select id="addrCompany">
							<option>--- 선택 ---</option>
							<c:forEach items="${addrCompanyList}" var="company">
								<option value="${company.CDNO}">${company.CDNAME}</option>
							</c:forEach>
						</select>
					</div>
					
					<div class="btn_wrap">
						<button type="button" class="edit" onclick="outItemEdit();">수정</button>
						<button type="button" class="save" onclick="outItemSave();">저장</button>
					</div>
				</div>
			</div>
			
		</div>
	</div>
	
	<!-- 전체 상품 리스트 팝업 -->
	<div class="popup allItem">
		<h3>전체 상품 리스트</h3>
		<button type="button" class="pop_close" onclick="popClose(this);">닫기</button>
		
		<div class="in_table">
			<table>
				<thead>
					<tr>
						<th>코드번호</th>
						<th>코드레벨</th>
						<th>상위코드</th>
						<th>코드이름</th>
						<th>사용여부</th>
					</tr>
				</thead>
				<tbody id="allItemBody"></tbody>
			</table>
		</div>
	</div>
	
</body>
</html>







































