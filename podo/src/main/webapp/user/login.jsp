<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css" rel="stylesheet" />
<link href="/resources/css/styles.css" rel="stylesheet" />
<%@ include file="/include/header.jsp" %>
<style>
	.form-signin {
	  max-width: 330px;
	  padding: 15px;
	  margin: 0 auto;
	}
	.form-signin .form-signin-heading,
	.form-signin .checkbox {
	  margin-bottom: 10px;
	}
	.form-signin .checkbox {
	  font-weight: 400;
	}
	.form-signin .form-control {
	  position: relative;
	  -webkit-box-sizing: border-box;
	  -moz-box-sizing: border-box;
	  box-sizing: border-box;
	  height: auto;
	  padding: 10px;
	  font-size: 20px;
	}
	.form-signin .form-control:focus {
	  z-index: 2;
	}
	.form-signin input[type="text"] {
	  margin-bottom: 5px;
	  border-bottom-right-radius: 0;
	  border-bottom-left-radius: 0;
	}
	.form-signin input[type="password"] {
	  margin-bottom: 10px;
	  border-top-left-radius: 0;
	  border-top-right-radius: 0;
	}
</style>
<script>
$(document).ready(function(){
	$("#userId").focus();
	
	$("#btnLogin").on("click",function(){
		fn_loginCheck();
	});
	
	$("#btnReg").on("click",function(){
		location.href = "user/userRegForm.jsp";
	});
});

function fn_loginCheck(){
	if($.trim($("#userId").val()).length <= 0){
			alert("아이디를 입력하세요.");
			$("#userId").val("");
			$("#userId").focus();
			return;
		}
	
	if($.trim($("#userPwd").val()).length <=0){
			alert("비밀번호를 입력하세요.");
			$("#userPwd").val("");
			$("#userPwd").focus();
			return;
		}
	document.loginForm.submit();
}
</script>
</head>
<body class="d-flex flex-column min-vh-100">
	<%@ include file="/include/navigation.jsp" %>
	<div class="container">
		<form name="loginForm" id="loginForm" method="post" action="/user/loginProc.jsp" class="form-signin">
			<br/>
		    <h2 class="form-signin-heading m-b3" align="center"><b>로그인</b></h2><br/>
			<label for="userId" class="sr-only">아이디</label>
			<input type="text" id="userId" name="userId" class="form-control" maxlength="20" placeholder="아이디"><br/>
			<label for="userPwd" class="sr-only">비밀번호</label>
			<input type="password" id="userPwd" name="userPwd" class="form-control" maxlength="20" placeholder="비밀번호"><br/>
			<div align="center" class="">
		        <a class="" id="find" style="text-decoration: none; color: #4d377b" onclick="location.href='/user/findId.jsp'">아이디 찾기</a>
		        <span class="">/</span>
		        <a class="" id="find" style="text-decoration: none; color: #4d377b" onclick="location.href='/user/findPwd.jsp'">비밀번호 찾기</a>
	        </div><br/>  
	        <div class="d-grid gap-2 col-12 mx-auto">
				<button type="button" id="btnLogin" class="btn btn-lg btn-purple">로그인</button>
		    	<button type="button" id="btnReg" class="btn btn-lg btn-purple" onclick="location.href='/user/join.jsp'">회원가입</button>
	    	</div>
		</form>
	</div>
	<%@ include file="/include/footer.jsp" %>
</body>
</html>