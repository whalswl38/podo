<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="org.apache.logging.log4j.LogManager" %>
<%@ page import="org.apache.logging.log4j.Logger" %>
<%@ page import="com.sist.web.util.HttpUtil" %>
<%@ page import="com.sist.web.util.CookieUtil" %>
<%@ page import="com.sist.common.util.StringUtil" %>
<%@ page import="com.sist.web.dao.UserDao" %>
<%@ page import="com.sist.web.model.User" %>
<%
	Logger logger = LogManager.getLogger("userUpdate.jsp");
	HttpUtil.requestLogString(request, logger);

	User user = null;
	String cookieUserId = CookieUtil.getValue(request, "USER_ID");

	if(!StringUtil.isEmpty(cookieUserId)){
		logger.debug("cookieUserId : " + cookieUserId);
	
		UserDao userDao = new UserDao();
		user = userDao.userSelect(cookieUserId);

		if(user == null){

        CookieUtil.deleteCookie(request, response, "/", "USER_ID");
      	response.sendRedirect("/");
		}else{
			if(!StringUtil.equals(user.getUserStatus(), "Y")){
	  			CookieUtil.deleteCookie(request, response, "USER_ID");
	   			user = null;
	   			response.sendRedirect("/");
			}
		}
	}
		if(user != null){
%>
<!DOCTYPE html>
<html>
<head>
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css" rel="stylesheet" />
<link href="/resources/css/styles.css" rel="stylesheet" />
<%@ include file="/include/header.jsp" %>
<!-- 주소검색 -->
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script>
<!-- 주소검색 start -->
function execDaumPostcode() {
    new daum.Postcode({
        oncomplete: function(data) {
            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
            // 각 주소의 노출 규칙에 따라 주소를 조합한다.
            // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
            var addr = ''; // 주소 변수
            var extraAddr = ''; // 참고항목 변수

            //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
            if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                addr = data.roadAddress;
            } else { // 사용자가 지번 주소를 선택했을 경우(J)
                addr = data.jibunAddress;
            }

            // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
            if(data.userSelectedType === 'R'){
                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                if(data.bname !== '' && /[동|로|가]$/g.test
                		(data.bname)){
                    extraAddr += data.bname;
                }
                // 건물명이 있고, 공동주택일 경우 추가한다.
                if(data.buildingName !== '' && data.apartment === 'Y'){
                    extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                if(extraAddr !== ''){
                    extraAddr = ' (' + extraAddr + ')';
                }
                // 조합된 참고항목을 해당 필드에 넣는다.
                
                //document.getElementById("sample6_extraAddress").value = extraAddr;
            } else {
                //document.getElementById("sample6_extraAddress").value = '';
            }

            // 우편번호와 주소 정보를 해당 필드에 넣는다.
            document.getElementById('zipcode').value = data.zonecode;
            document.getElementById("addr1").value = addr;
            // 커서를 상세주소 필드로 이동한다.
            document.getElementById("addr2").focus();
        }
    }).open();
}
<!-- 주소검색 end --> 

<!-- 회원가입 start -->
function fnSubmit() {
	//정규표현식
	var idPwdCheck = /^[a-zA-Z0-9]{4,12}$/;
	var emailCheck = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
	//모든 공백 체크 정규식
	var emptCheck = /\s/g;
	
	if($("#userPwd1").val().trim().length <= 0) {
	    $("#userPwd1").val("");
	    $("#userPwd1").focus();
	    return alert("비밀번호를 입력해주세요.");
	}
	
	if(emptCheck.test($("#userPwd1").val())){
		$("#userPwd1").val("");
		$("#userPwd1").focus();
		return alert("비밀번호는 공백을 포함할 수 없습니다.");
	}
	
	if(!idPwdCheck.test($("#userPwd1").val())) {
		$("#userPwd1").val("");
		$("#userPwd1").focus();
	    return alert("비밀번호 형식이 올바르지않습니다.\n비밀번호는 4~12자리의 영문 대소문자, 숫자로만 입력가능합니다.");
	}
	
	if($("#userPwd2").val().trim().length <= 0) {
	    $("#userPwd2").val("");
	    $("#userPwd2").focus();
	    return alert("비밀번호 확인을 입력해주세요.");
	}
	
	if($("#userPwd1").val() != $("#userPwd2").val()) {
		$("#userPwd2").val("");
		$("#userPwd2").focus();
	    return alert("비밀번호가 일치하지않습니다.");
	}

	$("#userPwd").val($("#userPwd1").val());
	
    if($("#userPhone").val().trim().length <= 0) {
        $("#userPhone").val("");
        return alert("휴대폰 번호를 입력해주세요.");
    }

    if($("#userEmail").val().trim().length <= 0) {
        $("#userEmail").val("");
        return alert("이메일을 입력해주세요.");
    }

    if(!emailCheck.test($("#userEmail").val())) {
        $("#userEmail").val("");
        return alert("이메일 형식이 올바르지않습니다.");
    }
    
	if($("#zipcode, #addr1, #addr2").val().trim().length <= 0) {
	$("#zipcode, #addr1, #addr2").val("");
	return alert("주소를 입력해주세요.");
	}
	
	document.updateForm.submit();
}

function fnCancel() {
	document.getElementById("updateForm").reset();
}
<!-- 회원가입 end -->
</script>
</head>
<body class="d-flex flex-column min-vh-100">
<%@ include file="/include/navigation.jsp" %>
	<br/>
	<h2 class="" align="center"><b>회원정보수정</b></h2>
	<div class="container"> 
		<div class="form-join"> 
			<form id="updateForm" name="updateForm" action="/user/userProc.jsp" method="post"> 
				<div class="form-join d-flex justify-content-center">
					<div class="col-sm-1 control-label">
						<label id="flag">회원구분</label>
					</div>
					<div class="col-sm-4">
<%
						String msg = null;
						if("C".equals(user.getUserFlag())) {
							msg = "기업회원";
						} else {
							msg = "개인회원";
						}
%>
							<%=msg%> 
					</div>
				</div>
			
				<div class="form-join d-flex justify-content-center">
					<div class="col-sm-1 control-label">
						<label>아이디</label>
					</div>
					<div class="col-sm-4"> 
						<%=user.getUserId()%>
					</div>
				</div>
			          
				<div class="form-join d-flex justify-content-center">
					<div class="col-sm-1 control-label">
						<label id="pwd">비밀번호</label>
					</div>
					<div class="col-sm-4">
						<input type="password" class="form-control" name="userPwd1" id="userPwd1" placeholder="4 ~ 20자의 영문, 숫자와 특수문자만 사용가능">
					</div>
				</div>
			          
				<div class="form-join d-flex justify-content-center">
					<div class="col-sm-1 control-label">
						<label id="pwdCheck">비밀번호확인</label>
					</div>
					<div class="col-sm-4">
						<input type="password" class="form-control" name="userPwd2" id="userPwd2">
					</div>
				</div>
			         
				<div class="form-join d-flex justify-content-center">
					<div class="col-sm-1 control-label">
						<label id="name">이름</label>
					</div>
					<div class="col-sm-4">
						<input type="text" class="form-control" name="userName" id="userName" value="<%=user.getUserName()%>">
					</div>
				</div>        
			          
				<div class="form-join d-flex justify-content-center">
					<div class="col-sm-1 control-label">
						<label id="email">이메일</label>
					</div>
					<div class="col-sm-4">
						<input type="email" class="form-control" name="userEmail" id="userEmail" value="<%=user.getUserEmail()%>">
					</div>
				</div>   
			          
				<div class="form-join d-flex justify-content-center">
					<div class="col-sm-1 control-label">
						<label id="phone">휴대전화</label>
					</div>
					<div class="col-sm-4">
						<input type="text" class="form-control" name="userPhone" id="userPhone" value="<%=user.getUserPhone()%>">
					</div>
				</div>
				
				<div class="form-join d-flex justify-content-center">
					<div class="col-sm-1 control-label">
						<label id="postcode">우편번호</label>
					</div>
					<div class="col-sm-14">
						<input type="text" id="zipcode" name="zipcode" class="form-control" value="<%=user.getZipcode()%>">
					</div>
					<div class="col-sm-1-1">
						<input type="button" onclick="execDaumPostcode();" value="우편번호찾기" class="btn btn-purple">
					</div>
				</div>   
			   
				<div class="form-join d-flex justify-content-center" >
					<div class="col-sm-1 control-label">
						<label id="address">주소</label>
					</div>
					<div class="col-sm-4">
						<input type="text" id="addr1" name="addr1" class="form-control" value="<%=user.getAddr1()%>">
					</div>   
				</div>
			      
				<div class="form-join d-flex justify-content-center"> 
					<div class="col-sm-1 control-label">
						<label id="detailAddress">상세주소</label>
					</div>
					<div class="col-sm-4"> 
						<input type="text" id="addr2" name="addr2" class="form-control" value="<%=user.getAddr2()%>">
					</div>
				</div>
			          
				<input type="hidden" id="userId" name="userId" value="<%=user.getUserId() %>" />
				<input type="hidden" id="userPwd" name="userPwd" value=""> 
				<div class="col-sm-12 text-center" >
					<button type="button" id="btnReg" class="btn btn-lg btn-success" onclick="fnSubmit()">수정</button>&nbsp;&nbsp;
					<button type="button" id="btnReset" class="btn btn-lg btn-warning" onclick="fnCancel()">취소</button>
				</div>
			</form>  
		</div>
	</div>
<%@ include file="/include/footer.jsp" %>
</body>
</html>
<%
	}
%>