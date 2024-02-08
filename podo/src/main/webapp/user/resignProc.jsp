<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="org.apache.logging.log4j.LogManager" %>
<%@ page import="org.apache.logging.log4j.Logger" %>
<%@ page import="com.sist.common.util.StringUtil" %>
<%@ page import="com.sist.web.util.HttpUtil" %>
<%@ page import="com.sist.web.util.CookieUtil" %>
<%@ page import="com.sist.web.dao.UserDao" %>
<%@ page import="com.sist.web.model.User" %>
<%@ page import="java.util.List" %>
<%
	Logger logger = LogManager.getLogger("/board/comDelete.jsp");
	HttpUtil.requestLogString(request, logger);
	
	String cookieUserId = CookieUtil.getValue(request, "USER_ID");
	
	boolean success = false;
	String errorMessage = "";
	String redirectUrl = "";
	
	UserDao userDao =  new UserDao();
	User user =  new User();
	user.setUserId(cookieUserId);
	
	if(userDao.userResign(user) > 0){
		success = true;
		CookieUtil.deleteCookie(request, response,"/", "USER_ID");
		redirectUrl = "/";   
	} else {
		errorMessage = "탈퇴 중 오류가 발생했습니다.";
	}
%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/include/header.jsp" %>
<script>
$(document).ready(function() {
	<%
	if(success == true){
	%>
		alert("탈퇴 처리되었습니다.");
		location.href = "<%=redirectUrl%>";
	<%
	} else {
	%>
		alert("<%=errorMessage%>");
	<%
	}
	%>
});
</script>
</head>
<body>

</body>
</html>