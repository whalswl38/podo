<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css" rel="stylesheet" />
<link href="/resources/css/styles.css" rel="stylesheet" />
<%@ include file="/include/header.jsp" %>
<style>
</style>
<!-- 주소검색 -->
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script>
<!-- 아이디 중복체크용 변수 -->
var chkId = false;

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

<!-- 이메일 인증 -->
<!--
var emailCode = "";
function fnEmailValidation() {
   if ($("#email").val().trim().length < 1) {
      return;
   }

   $.ajax({
      url : "emailValidation",
      type : "post",
      dataType : "json",
      data : {
         "email" : $("#email").val()
      },
      success : function(data) {
         console.log(data);
         if (data.resultCode == "1002") {
            return alert("이미 가입되어 있는 이메일 주소입니다.");
         } else if (data.resultCode == "1001") {
            return alert("메일 발송중 에러가 발생했습니다.\n메일을 발송하지 못했습니다.");
         }

         emailCode = data.emailValidationCode;
         alert("메일이 발송 되었습니다.\n메일에 포함된 인증코드를 입력 후 인증 버튼을 눌러주세요.");
      },
      error : function(err) {
         alert("에러가 발생했습니다.\n브라우저 콘솔의 내용을 확인하세요.");
         console.log(err);
      }
   });
}
-->

<!--    
function chkEmailCode() {
    if ($("#emailCodeInput").val() == emailCode) {
        alert("인증되었습니다.");
        $("#emailRes").val("Y");
     } else {
        return alert("인증번호가 일치하지 않습니다.");
     }
  }
-->

<!--아이디 중복체크 start-->
function chkDup() {
	//정규표현식
	var idPwdCheck = /^[a-zA-Z0-9]{4,12}$/;
	var emailCheck = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
	//모든 공백 체크 정규식
	var emptCheck = /\s/g;
	
	if($("#userId").val().trim().length <= 0) {
	    $("#userId").val("");
	    $("#userId").focus();
	    return alert("아이디를 입력해주세요.");
	}
	
	if(emptCheck.test($("#userId").val())){
		$("#userId").val("");
		$("#userId").focus();
		return alert("아이디는 공백을 포함할 수 없습니다.");
	}
	
	if(!idPwdCheck.test($("#userId").val())) {
		chkId = false;
		$("#userId").val("");
		$("#userId").focus();
	    return alert("아이디 형식이 올바르지않습니다.\n아이디는 4~12자리의 영문 대소문자, 숫자로만 입력가능합니다.");
	}
	
	 $.ajax({
			type: "POST",
			url: "/user/userIdCheckAjax.jsp",
			data: { userId : $("#userId").val()},
			datatype: "JSON",
			success: function(obj) {
				//obj를 json방식으로 파싱
				var data = JSON.parse(obj);
				
				if(data.flag == 0){
					//중복된 아이디가 없으면 회원가입 진행
					chkId = true;
					alert("사용가능한 아이디입니다.");
				}else if(data.flag == 1){
					alert("이미 사용중인 아이디입니다.");
					$("#userId").focus();
				}else{
					alert("아이디를 확인하세요.");
					$("#userId").focus();
				}
			},
			error: function(xhr, status, error){
				alert("아이디 중복 체크 오류");
			}
		});
}
<!--아이디 중복체크 end-->

<!-- 이용약관 팝업 start -->
function popupAgree1() {
	window.open("/user/agree1.jsp","이용약관","width=500, height=700, resizable=yes");
}
	//var pop = window.open("views/member/jusoPopup.jsp", "juso",
	            //"width=570,height=420, scrollbars=yes, resizable=yes");
function popupAgree2() {
	window.open("/user/agree2.jsp","개인정보","width=500, height=700, resizable=yes");
}
<!-- 이용약관 팝업 end -->	

<!-- 회원가입 start -->
function fnSubmit() {
	//정규표현식
	var idPwdCheck = /^[a-zA-Z0-9]{4,12}$/;
	var emailCheck = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
	//모든 공백 체크 정규식
	var emptCheck = /\s/g;
	
	
	if($('#sel_userFlag').val()=="선택") {
		  alert("회원 구분을 선택해주세요.");
		  return ;
	}
	
	if($("#userId").val().trim().length <= 0) {
	    $("#userId").val("");
	    $("#userId").focus();
	    return alert("아이디를 입력해주세요.");
	}
	
	if(emptCheck.test($("#userId").val())){
		$("#userId").val("");
		$("#userId").focus();
		return alert("아이디는 공백을 포함할 수 없습니다.");
	}
	
	if(!idPwdCheck.test($("#userId").val())) {
		chkId = false;
		$("#userId").val("");
		$("#userId").focus();
	    return alert("아이디 형식이 올바르지않습니다.\n아이디는 4~12자리의 영문 대소문자, 숫자로만 입력가능합니다.");
	}
	
	if (!chkId) {
		return alert("아이디 중복체크를 해주세요.");
	}
	
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
	
	if($("#userName").val().trim().length <= 0) {
        $("#userName").val("");
        return alert("이름를 입력해주세요.");
    }

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
    
    <!--
	if ($("#emailRes").val() == "N") {
		return alert("이메일 인증을 해주시기 바랍니다.");
	}
	-->
	if($("#zipcode, #addr1, #addr2").val().trim().length <= 0) {
	$("#zipcode, #addr1, #addr2").val("");
	return alert("주소를 입력해주세요.");
	}

	if(!$("#agree1").is(":checked")) {
		return alert("이용약관에 대한 동의에 체크해주세요.");
	}
	
	if(!$("#agree2").is(":checked")) {
		return alert("개인정보 수집 및 이용동의에 체크해주세요.");
	}
	
	$("#userPwd").val($("#userPwd1").val());
	
	$("#userFlag").val($("#sel_userFlag option:selected").val());
	
	document.regForm.submit();
}
<!-- 회원가입 end -->
function fnCancel() {
	document.getElementById("regForm").reset();
}

</script> 

</head>
<body class="d-flex flex-column min-vh-100">
<%@ include file="/include/navigation.jsp" %>
	<br/>
	<h2 class="" align="center"><b>회원가입</b></h2>
	<div class="container"> 
		<div class="form-join"> 
			<form id="regForm" name="regForm" action="/user/userProc.jsp" method="post"> 
				<div class="form-join d-flex justify-content-center">
					<div class="col-sm-1 control-label">
						<label>회원구분</label>
					</div>
					<div class="col-sm-4">
						<select id="sel_userFlag" class="form-select form-select mb-3" aria-label=".form-select-lg example">
							<option selected>선택</option>
							<option value="U">개인회원</option>
							<option value="C">기업회원</option>
						</select>
						<input type="hidden" id="userFlag" name="userFlag">
					</div>
				</div>
			
				<div class="form-join d-flex justify-content-center">
					<div class="col-sm-1 control-label">
						<label>아이디</label>
					</div>
					<div class="col-sm-14"> 
						<input type="text" class="form-control" name="userId" id="userId" value="" placeholder="4 ~ 20자의 영문, 숫자만 사용가능">
					</div>
					<div class="col-sm-1">
						<input type="button" onclick="chkDup();" value="중복체크" class="btn btn-purple">
					</div>
				</div>

				<div class="form-join d-flex justify-content-center">
					<div class="col-sm-1 control-label">
						<label>비밀번호</label>
					</div>
					<div class="col-sm-4">
						<input type="password" class="form-control" name="userPwd1" id="userPwd1" placeholder="4 ~ 20자의 영문, 숫자만 사용가능">
					</div>
				</div>
			          
				<div class="form-join d-flex justify-content-center">
					<div class="col-sm-1 control-label">
						<label>비밀번호확인</label>
					</div>
					<div class="col-sm-4">
						<input type="password" class="form-control" name="userPwd2" id="userPwd2">
					</div>
				</div>
			         
				<div class="form-join d-flex justify-content-center">
					<div class="col-sm-1 control-label">
						<label>이름</label>
					</div>
					<div class="col-sm-4">
						<input type="text" class="form-control" name="userName" id="userName" value="">
					</div>
				</div>        
			          
				<div class="form-join d-flex justify-content-center">
					<div class="col-sm-1 control-label">
						<label>이메일</label>
					</div>
					<div class="col-sm-4">
						<input type="email" class="form-control" name="userEmail" id="userEmail" value="" placeholder="(ex)email@podo.com">
					</div>
				</div>   
			          
				<div class="form-join d-flex justify-content-center">
					<div class="col-sm-1 control-label">
						<label>휴대전화</label>
					</div>
					<div class="col-sm-4">
						<input type="text" class="form-control" name="userPhone" id="userPhone" value="" placeholder="'-'빼고 숫자만 입력">
					</div>
				</div>
				
				<div class="form-join d-flex justify-content-center">
					<div class="col-sm-1 control-label">
						<label>우편번호</label>
					</div>
					<div class="col-sm-14">
						<input type="text" id="zipcode" name="zipcode" class="form-control" value="">
					</div>
					<div class="col-sm-1-1">
						<input type="button" onclick="execDaumPostcode();" value="우편번호찾기" class="btn btn-purple">
					</div>
				</div>   
			   
				<div class="form-join d-flex justify-content-center" >
					<div class="col-sm-1 control-label">
						<label>주소</label>
					</div>
					<div class="col-sm-4">
						<input type="text" id="addr1" name="addr1" class="form-control" value="">
					</div>   
				</div>
			      
				<div class="form-join d-flex justify-content-center"> 
					<div class="col-sm-1 control-label">
						<label>상세주소</label>
					</div>
					<div class="col-sm-4"> 
						<input type="text" id="addr2" name="addr2" class="form-control" value="">
					</div>
				</div>
			          
			    <div class="text-center">
			        <label class="">
			            <input id="agree1" type="checkbox" class="form-check-input">
			            <span>이용약관 동의</span>
			        </label>
			        <span>(필수)</span>
			    	<a class="" style="width: 90pt; height: 26pt;" value="전문보기" onclick="popupAgree1()">약관보기</a><br/>
			        <label class="">
			            <input id="agree2" type="checkbox" class="form-check-input">
			            <span>개인정보 수집∙이용 동의</span>
			        </label>
			        <span>(필수)</span> 
				    <a class="" style="width: 90pt; height: 26pt;" value="전문보기" onclick="popupAgree2()">약관보기</a>
				</div>
				<input type="hidden" id="userPwd" name="userPwd" value="" /><br/>
				<div class="col-sm-12 text-center" >
					<button type="button" id="btnReg" class="btn btn-lg btn-success" onclick="fnSubmit()">회원가입</button>&nbsp;&nbsp;
					<button type="button" id="btnReset" class="btn btn-lg btn-warning" onclick="fnCancel()">취소</button>
				</div>
			</form>  
		</div>
	</div>
<%@ include file="/include/footer.jsp" %>
</body>
</html>