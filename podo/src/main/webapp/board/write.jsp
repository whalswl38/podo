<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="org.apache.logging.log4j.LogManager" %>
<%@ page import="org.apache.logging.log4j.Logger" %>
<%@ page import="com.sist.web.util.HttpUtil" %>
<%@ page import="com.sist.web.util.CookieUtil" %>
<%@ page import="com.sist.common.util.StringUtil" %>
<%@ page import="com.sist.web.dao.UserDao" %>
<%@ page import="com.sist.web.model.User" %>
<%
	Logger logger = LogManager.getLogger("/board/write.jsp");
	HttpUtil.requestLogString(request, logger);
	
	String cookieUserId = CookieUtil.getValue(request, "USER_ID");
	
	UserDao userDao =  new UserDao();
	User user = userDao.userSelect(cookieUserId);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<%@ include file="/include/header.jsp" %>
<script>
function fnSubmit() {  
	
	<!-- val 값이 '선택'인 경우 옵션을 선택하지 않은 경우 -->
	if($("#job_Flag").val() == "선택") {
	  alert("직무를 선택 해주세요.");
	  return;
	}
	
	if($("#jobTitle").val().trim().length <= 0) {
        $("#jobTitle").val("");
        return alert("공고제목을 입력해주세요.");
    }

	if($("#car_Flag").val() == "선택") {
	  alert("경력을 선택해주세요.");
	  return;
	}
	
	if($("#scho_Flag").val() == "선택") {
	  alert("학력을 선택해주세요.");
	  return;
	}
	
	if($("#recruNum").val().trim().length <= 0) {
		alert("모집인원을 입력해주세요.");
		$("#recruNum").val("");
        return;
    }
	
	if($("#worker_Flag").val() == "선택") {
	  alert("근무형태를 선택해주세요.");
	  return;
	}
	
	if($("#jobSal").val().trim().length <= 0) {
		alert("급여를 입력해주세요.");
		$("#jobSal").val("");
        return;
    }
	
	if($("#job_Area").val() == "선택") {
	  alert("근무지역을 선택해주세요.");
	  return ;
	}
	
	if($("#jobContent").val().trim().length <= 0) {
		alert("근무상세내용을 입력해주세요.");
		$("#jobContent").val("");
        return;
    }
	
	if($("#datepicker").val().trim().length <= 0) {
		alert("마감일을 선택해주세요.");
		$("#datepicker").val("");
        return;
    }
	
	$("#jobFlag").val($("#job_Flag option:selected").val());
	$("#carFlag").val($("#car_Flag option:selected").val());
	$("#schoFlag").val($("#scho_Flag option:selected").val());
	$("#workerFlag").val($("#worker_Flag option:selected").val());
	$("#jobArea").val($("#job_Area option:selected").val());
	$("#expDate").val($("#datepicker").val()); 
	  		  
	document.writeForm.submit();
}

<!-- 취소 버튼을 눌렀을때 폼 초기화-->
function fnCancel() {
	document.getElementById("writeForm").reset();
}
</script>
</head>

<body>
<%@ include file="/include/navigation.jsp" %>
	<br/>
	<h2 class="" align="center"><b>공고등록</b></h2>
	<br/>
	<div class="container">
	<form name="writeForm" id="writeForm" action="/board/writeProc.jsp" method="post">
		<div class="form-join d-flex justify-content-center">
			<div class="col-sm-1 control-label">
				<label>회사명</label>
			</div>
			<div class="col-sm-4">
				<b><%=user.getUserName()%></b>
			</div>
		</div>
		
		<div class="form-join d-flex justify-content-center">
			<div class="col-sm-1 control-label">
				<label>직무 선택</label>
			</div>
			<div class="col-sm-4"> 
				<select id="job_Flag" class="form-select form-select mb-3" aria-label=".form-select-lg example">
					<option selected>선택</option>
					<option value="게임개발">게임개발</option>
					<option value="서버개발">서버개발</option>
					<option value="데이터분석">데이터분석</option>
					<option value="백엔드">백엔드</option>
					<option value="프론트엔드">프론트엔드</option>
					<option value="앱개발">앱개발</option>
					<option value="웹개발">웹개발</option>
					<option value="정보보안">정보보안</option>
				</select>
				<input type="hidden" id="jobFlag" name="jobFlag">
			</div>
		</div>
			          
		<div class="form-join d-flex justify-content-center">
			<div class="col-sm-1 control-label">
				<label>공고제목</label>
			</div>
			<div class="col-sm-4">
				<input type="text" class="form-control" name="jobTitle" id="jobTitle">
			</div>
		</div> 
	          
		<div class="form-join d-flex justify-content-center">
			<div class="col-sm-1 control-label">
				<label id="">경력</label>
			</div>
			<div class="col-sm-4">
				<select id="car_Flag" class="form-select form-select mb-3" aria-label=".form-select-lg example">
					<option selected>선택</option>
					<option value="신입">신입</option>
					<option value="경력">경력</option>
					<option value="경력무관">경력무관</option>
				</select>
				<input type="hidden" id="carFlag" name="carFlag">
			</div>
		</div>        
	          
		<div class="form-join d-flex justify-content-center">
			<div class="col-sm-1 control-label">
				<label>학력</label>
			</div>
			<div class="col-sm-4">
				<select id="scho_Flag" class="form-select form-select mb-3" aria-label=".form-select-lg example">
					<option selected>선택</option>
					<option value="고졸이상">고졸이상</option>
					<option value="2년제 대졸이상">2년제 대졸이상</option>
					<option value="4년제 대졸이상">4년제 대졸이상</option>
					<option value="학력무관">학력무관</option>
				</select>
				<input type="hidden" id="schoFlag" name="schoFlag">
			</div>
		</div>   
	          
		<div class="form-join d-flex justify-content-center">
			<div class="col-sm-1 control-label">
				<label>모집인원</label>
			</div>
			<div class="col-sm-4">
				<input type="text" class="form-control" name="recruNum" id="recruNum">
			</div>
		</div>
		
		<div class="form-join d-flex justify-content-center">
			<div class="col-sm-1 control-label">
				<label>근무형태</label>
			</div>
			<div class="col-sm-4">
				<select id="worker_Flag" class="form-select form-select mb-3" aria-label=".form-select-lg example">
					<option selected>선택</option>
					<option value="정규직">정규직</option>
					<option value="계약직">계약직</option>
				</select>
				<input type="hidden" id="workerFlag" name="workerFlag">
			</div>
		</div>
		<div class="form-join d-flex justify-content-center">
			<div class="col-sm-1 control-label">
				<label>급여</label>
			</div>
			<div class="col-sm-4">
				<input type="text" class="form-control" name="jobSal" id="jobSal">
			</div>
		</div>

		<div class="form-join d-flex justify-content-center">
			<div class="col-sm-1 control-label">
				<label>근무지역</label>
			</div>
			<div class="col-sm-4">
				<select id="job_Area" class="form-select form-select mb-3" aria-label=".form-select-lg example">
					<option selected>선택</option>
					<option value="서울시 전체">서울시 전체</option>
					<option value="서울시 강남구">서울시 강남구</option>
					<option value="서울시 강동구">서울시 강동구</option>
					<option value="서울시 강북구">서울시 강북구</option>
					<option value="서울시 강서구">서울시 강서구</option>
					<option value="서울시 관악구">서울시 관악구</option>
					<option value="서울시 광진구">서울시 광진구</option>
					<option value="서울시 구로구">서울시 구로구</option>
					<option value="서울시 금천구">서울시 금천구</option>
					<option value="서울시 노원구">서울시 노원구</option>
					<option value="서울시 도봉구">서울시 도봉구</option>
					<option value="서울시 동대문구">서울시 동대문구</option>
					<option value="서울시 동작구">서울시 동작구</option>
					<option value="서울시 마포구">서울시 마포구</option>
					<option value="서울시 서대문구">서울시 서대문구</option>
					<option value="서울시 서초구">서울시 서초구</option>
					<option value="서울시 성동구">서울시 성동구</option>
					<option value="서울시 성북구">서울시 성북구</option>
					<option value="서울시 송파구">서울시 송파구</option>
					<option value="서울시 양천구">서울시 양천구</option>
					<option value="서울시 영등포구">서울시 영등포구</option>
					<option value="서울시 용산구">서울시 용산구</option>
					<option value="서울시 은평구">서울시 은평구</option>
					<option value="서울시 종로구">서울시 종로구</option>
					<option value="서울시 중구">서울시 중구</option>
					<option value="서울시 중랑구">서울시 중랑구</option>
				</select>
				<input type="hidden" id="jobArea" name="jobArea">
			</div>
		</div>
		
		<div class="form-join d-flex justify-content-center">
			<div class="col-sm-1 control-label">
				<label>근무상세내용</label>
			</div>
			<div class="col-sm-4">
 				<textarea class="form-control" rows="10" name="jobContent" id="jobContent" style="ime-mode:active;" required></textarea>
			</div>
		</div>
		
		<div class="form-join d-flex justify-content-center">
			<div class="col-sm-1 control-label">
				<label>마감일</label>
			</div>
			<div class="col-sm-4">
				<input type="date" id="datepicker" class="form-control" min="yyy" max="zzz">
				<input type="hidden" id="expDate" name="expDate">
			</div>
		</div>
        
		<br/>
		<div class="form-group row" align="center">
			<div class="col-sm-12">
				<button type="button" id="btnWrite" class="btn btn-purple" title="등록" onclick="fnSubmit();">등록</button>
				<button type="button" id="btnCancel" class="btn btn-secondary" title="취소" onclick="fnCancel();">취소</button>
			</div>
		</div>
      <br/>
   </form>
</div>
<%@ include file="/include/footer.jsp" %>
</body>
</html>