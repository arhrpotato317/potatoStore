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
		
		// 상품 테이블 클릭 -> 입고내용
		function tableClick(itemTdArr) {
			var itemCode = itemTdArr[0].innerHTML; //상품코드
			var itemName = itemTdArr[1].innerHTML; //상품명
			var madeCompany = itemTdArr[3].innerHTML; //제조사
			var unitName = itemTdArr[5].innerHTML; //단위명
			
			document.getElementById("itemCode").value = itemCode;
			document.getElementById("itemName").value = itemName;
			document.getElementById("madeCompany").value = madeCompany;
			document.getElementById("unitName").value = unitName;
			
			document.getElementById("itemCheck").value = "";
			document.getElementById("inStock").value = "";
			document.getElementById("inStock").readOnly = true;
		}
		
		// 수정버튼 클릭 -> 수량입력 가능
		function inItemEdit() {
			document.getElementById("inStock").readOnly = false;
		}
		
		// 저장버튼 클릭
		function inItemSave() {
			var itemCode = document.getElementById("itemCode").value; //상품코드
			var itemCheck =  document.getElementById("itemCheck").value; //추가,수정 구분코드
			var inStock = document.getElementById("inStock").value; //입고수량
			var data = {
				"itemCode": itemCode,
				"itemCheck": itemCheck,
				"inStock": inStock
			}
			
			ajax.onreadystatechange = inItemSaveAjax;
			ajax.open("POST", "./inItemSaveAjax", true);
			ajax.setRequestHeader('Content-Type', 'application/json');
			ajax.send(JSON.stringify(data));
		}
		function inItemSaveAjax() {
			if(ajax.readyState === XMLHttpRequest.DONE) {
				if(ajax.status === 200) {
					var response = JSON.parse(ajax.responseText);
					
					if(response.hasOwnProperty("getTodayItemOne")) {
						// 입고리스트 추가 로직
						console.log("입고리스트 추가 로직");
						var todayTable = document.getElementById("todayTable");
						var todayTableTr = todayTable.insertRow(todayTable.rows.length);
						todayTableTr.innerHTML = '<tr>\
								<td>'+response.getTodayItemOne.ITEMCD+'</td>\
								<td>'+response.getTodayItemOne.ITEMNAME+'</td>\
								<td>'+response.getTodayItemOne.MADENMCD+'</td>\
								<td>'+response.getTodayItemOne.MADENMNAME+'</td>\
								<td>'+response.getTodayItemOne.ITEMUNITCD+'</td>\
								<td>'+response.getTodayItemOne.ITEMUNITNAME+'</td>\
								<td>'+response.getTodayItemOne.INSAMT+'</td>\
								<td style="display:none;">'+response.getTodayItemOne.INSITEMLISTCD+'</td>\
							</tr>';
							
						alert("입고상품이 추가되었습니다.");
						
						todayTableTr.addEventListener("click", function() {
							todayClick(this.children);
						});
						
					} else if(response.hasOwnProperty("setTodayItemOne")) {
						// 금일 입고리스트 행 수정 로직
						console.log("금일 입고리스트 행 수정 로직");
					}
					
					// 상품 조회 리스트 수량 바로 변경 (Ajax)
					var setItemCode = response.itemStock.ITEMCD;
					var setItemStock = response.itemStock.STOCKAMT;
					
					var cateItemTable = document.getElementById("cateItemTable");
					var cateItemTableTr = cateItemTable.getElementsByTagName("tr");
					for(var i=0; i<cateItemTableTr.length; i++) {
						if(cateItemTableTr[i].firstElementChild.innerText == setItemCode) {
							cateItemTableTr[i].children[6].innerText = setItemStock;
						}
					}
					
				} else {
					alert("실패");
				}
			}
		}
		
		// 금일 입고 리스트 클릭 -> 입고내용
		function todayClick(itemTdArr) {
			var itemCode = itemTdArr[0].innerHTML; //상품코드
			var itemName = itemTdArr[1].innerHTML; //상품명
			var madeCompany = itemTdArr[3].innerHTML; //제조사
			var unitName = itemTdArr[5].innerHTML; //단위명
			var inStock = itemTdArr[6].innerHTML; //입고수량
			var itemCheck = itemTdArr[7].innerHTML; //추가,수정 구분코드
			
			document.getElementById("itemCode").value = itemCode;
			document.getElementById("itemName").value = itemName;
			document.getElementById("madeCompany").value = madeCompany;
			document.getElementById("unitName").value = unitName;
			document.getElementById("inStock").value = inStock;
			document.getElementById("itemCheck").value = itemCheck;
			
			document.getElementById("inStock").readOnly = true;
		}
	</script>
</head>
<body>
	<!-- header -->
	<%@ include file="../include/header.jsp" %>
	
	<div class="container">
		<div class="product_wrap">
			<h1>상품 입고</h1>
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
					<h4>금일 입고 리스트</h4>
					
					<div class="in_table">
						<table id="todayTable">
							<thead>
								<tr>
									<th>상품코드</th>
									<th>상품명</th>
									<th>제조사코드</th>
									<th>제조사명</th>
									<th>단위코드</th>
									<th>단위명</th>
									<th>입고수량</th>
								</tr>
							</thead>
							<tbody id="inItemBody">
								<c:choose>
									<c:when test="${fn:length(todayItemList) > 0}">
										<c:forEach items="${todayItemList}" var="today">
											<tr onclick="todayClick(this.children);">
												<td>${today.ITEMCD}</td>
												<td>${today.ITEMNAME}</td>
												<td>${today.MADENMCD}</td>
												<td>${today.MADENMNAME}</td>
												<td>${today.ITEMUNITCD}</td>
												<td>${today.ITEMUNITNAME}</td>
												<td>${today.INSAMT}</td>
												<td style="display:none;">${today.INSITEMLISTCD}</td>
											</tr>
										</c:forEach>
									</c:when>
								</c:choose>
							</tbody>
						</table>
					</div>
				</div>
				<div class="inner">
					<h4>입고내용</h4>
					
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
					</div>
					<div class="input_box">
						<label for="unitName">단위명</label>
						<input type="text" id="unitName" name="unitName" readonly>
					</div>
					<div class="input_box">
						<label for="inStock">입고수량</label>
						<input type="text" id="inStock" name="inStock" readonly>
					</div>
					
					<div class="btn_wrap">
						<button type="button" class="edit" onclick="inItemEdit();">수정</button>
						<button type="button" class="save" onclick="inItemSave();">저장</button>
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







































