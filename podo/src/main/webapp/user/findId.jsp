<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="org.apache.logging.log4j.LogManager" %>
<%@ page import="org.apache.logging.log4j.Logger" %>
<%@ page import="com.sist.common.util.StringUtil" %>
<%@ page import="com.sist.web.util.HttpUtil" %>
<%@ page import="com.sist.web.util.CookieUtil" %>
<%@ page import="com.sist.web.dao.UserDao" %>
<%@ page import="com.sist.web.model.User" %>
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
function fnSubmit() {
		if($("#userName").val().trim().length <= 0) {
	        $("#userName").val("");
	        return alert("이름를 입력해주세요.");
	    }
		
	    if($("#userEmail").val().trim().length <= 0) {
	        $("#userEmail").val("");
	        return alert("이메일을 입력해주세요.");
	    }
	    
	    var obj = new Object();
	    $.ajax({
	    		type: "GET",
	    		url: "/user/userIdFindAjax.jsp",
	    		data: { 
	    				userName : $("#userName").val(), 
	    				userEmail : $("#userEmail").val() 
	    				},
   				dataType:"json",
   		        contentType:"application/json",
	    		success: function(obj) {
					//var data = JSON.parse(obj);
	    			if(obj.id == 'null'){
						return alert("해당정보와 일치하는 아이디가 없습니다.");
					}else{
						alert("입력하신 정보와 일치하는 아이디는 '" + obj.id + "' 입니다.");
					}
				},
				error : function(err){
					alert("에러가 발생했습니다.\n브라우저 콘솔의 내용을 확인하세요.");
					console.log(err);
				}
	   });
}

</script>
</head>
<body class="d-flex flex-column min-vh-100">
<%@ include file="/include/navigation.jsp"%>
	<div class="container">
		<form name="findForm" id="findForm" method="post" action="/user/userFindAjax.jsp" class="form-signin">
			<br/>
		    <h2 class="form-signin-heading m-b3" align="center"><b>아이디 찾기</b></h2><br/>
			<label for="userName" class="sr-only">이름</label>
			<input type="text" id="userName" name="userName" class="form-control" maxlength="20" ><br/>
			<label for="userEmail" class="sr-only">이메일</label>
			<input type="text" id="userEmail" name="userEmail" class="form-control" maxlength="20" ><br/>
			 
			<div class="d-grid gap-2 col-12 mx-auto">
				<button type="button" id="findId" class="btn btn-lg btn-purple" onclick="fnSubmit();">아이디 찾기</button>
				<button type="button" id="cancel" class="btn btn-lg btn-purple" type="submit" onclick="history.back()">취소</button>
			</div>	
		</form>
	</div>
<%@ include file="/include/footer.jsp" %>
</body>
</html>