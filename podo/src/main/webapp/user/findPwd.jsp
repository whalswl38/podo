<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css" rel="stylesheet" />
<link href="/resources/css/styles.css" rel="stylesheet" />
<%@ include file="/include/header.jsp" %>
<%@ page import="com.sist.mail.GmailSend" %>

<style>
</style>
<script>
$(document).ready(function(){
	$("#sendMail").on("click", function(){// 메일 입력 유효성 검사
		var mail = $("#userEmail").val(); //사용자의 이메일 입력값. 
		var id = $("#userId").val(); //사용자의 아이디 입력값.
		
		if(mail == '' || id ==''){
			alert("아이디 또는 이메일이 입력되지않았습니다.");
			return;
		}
		//임시비밀번호를 위한 난수 발생
		var verifyNum = Math.floor(Math.random() * 1000000);
		
		$.ajax({
		  		type: "GET",
		  		url: "/user/mailSendProc.jsp",
		  		data: { 
		  				mail : $("#userEmail").val(), 
		  				content : "임시 비밀번호는 " + verifyNum + " 입니다.",
		  				title : "podo 임시 비밀번호 발급",
		  				id : $("#userId").val(),
		  				verifyNum : verifyNum
		  		},
						dataType:"json",
				        contentType:"application/json",
		  		success: function(obj) {
		  			if(obj.result != 250){
					alert(obj.errMsg);
		  			}else {
		   			alert("임시 비밀번호가 발급되었습니다.\n이메일을 확인해주세요.") 
		  			}
			},
			error : function(err){
				alert("에러가 발생했습니다.\n브라우저 콘솔의 내용을 확인하세요.");
				console.log(err);
			}
		 });
	});
});
</script>
</head>
<body class="d-flex flex-column min-vh-100">
<%@ include file="/include/navigation.jsp" %>
	<br/><br/>
	<h2 align="center"><b>비밀번호 찾기</b></h2><br/>
	<div class="container">
	<form name="findPwdForm" id="findPwdForm" class="form-signin" action="" method="POST">
   		<div class="form-join d-flex justify-content-center">
			<div class="col-sm-1 control-label">
				<label>아이디</label>
			</div>
			<div class="col-sm-3"> 
				<input style="width:310px" type="text" class="form-control" name="userId" id="userId">
			</div>
		</div>
   		<div class="form-join d-flex justify-content-center">
			<div class="col-sm-1 control-label">
				<label>이메일</label>
			</div>
			<div> 
				<input style="width:250px" type="text" class="form-control" name="userEmail" id="userEmail">
			</div>
			<div>
				<input type="button" id="sendMail" name="sendMail" value="전송" class="btn btn-purple">
			</div>
		</div>
		<br/><br/>
		<div class="col-sm-12 text-center">
			<button type="button" id="btnReg" class="btn btn-lg btn-purple" onclick="history.back()">취소</button>
		</div>	
	</form>
</div>
<%@ include file="/include/footer.jsp" %>
</body>
</html>