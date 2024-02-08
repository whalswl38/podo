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
<script>

function fnResign() {
	if(confirm("탈퇴하시겠습니까?") == true){
		location.href = "/user/resignProc.jsp";
	}
}
</script>
</head>
<body class="d-flex flex-column min-vh-100">
<%@ include file="/include/navigation.jsp" %>
	<br>
	<h2 align="center"><b>마이페이지</b></h2>
	<div class="container">
	<br>
		<div style="width:100%" align="center"> 
				<div class="form-join d-flex justify-content-center">
					<div class="col-sm-1 control-label">
						<label id="flag">회원구분</label>
					</div>
					<div class="col-sm-2">
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
					<div class="col-sm-2"> 
						<%=user.getUserId()%>
					</div>
				</div>
			         
				<div class="form-join d-flex justify-content-center">
					<div class="col-sm-1 control-label">
						<label id="name">이름</label>
					</div>
					<div class="col-sm-2">
						<%=user.getUserName()%>
					</div>
				</div>        
			          
				<div class="form-join d-flex justify-content-center">
					<div class="col-sm-1 control-label">
						<label id="email">이메일</label>
					</div>
					<div class="col-sm-2">
						<%=user.getUserEmail()%>
					</div>
				</div>   
			          
				<div class="form-join d-flex justify-content-center">
					<div class="col-sm-1 control-label">
						<label id="phone">휴대전화</label>
					</div>
					<div class="col-sm-2">
						<%=user.getUserPhone()%>
					</div>
				</div>
				
				<div class="form-join d-flex justify-content-center">
					<div class="col-sm-1 control-label">
						<label id="postcode">우편번호</label>
					</div>
					<div class="col-sm-2">
						<%=user.getZipcode()%>
					</div>
				</div>   
			   
				<div class="form-join d-flex justify-content-center" >
					<div class="col-sm-1 control-label">
						<label id="address">주소</label>
					</div>
					<div class="col-sm-2">
						<%=user.getAddr1()%>
					</div>   
				</div>
			      
				<div class="form-join d-flex justify-content-center"> 
					<div class="col-sm-1 control-label">
						<label id="detailAddress">상세주소</label>
					</div>
					<div class="col-sm-2"> 
						<%=user.getAddr2()%>
					</div>
				</div>
			    <br>      
				<input type="hidden" id="userId" name="userId" value="<%=user.getUserId() %>" /> 
				<div class="col-sm-12 text-center" >
					<button type="button" id="btnReg" class="btn btn-lg btn-success" onclick="location.href='/user/userUpdate.jsp'">수정</button>&nbsp;&nbsp;
					<button type="button" id="btnReset" class="btn btn-lg btn-warning" onclick="fnResign()">탈퇴</button>
				</div><br>
		</div>
	</div>
<%@ include file="/include/footer.jsp" %>
</body>
</html>
<%
	}
%>