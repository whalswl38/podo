<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="org.apache.logging.log4j.LogManager" %>
<%@ page import="org.apache.logging.log4j.Logger" %>
<%@ page import="com.sist.web.util.HttpUtil" %>
<%@ page import="com.sist.web.util.CookieUtil" %>
<%@ page import="com.sist.common.util.StringUtil" %>
<%@ page import="com.sist.web.dao.UserDao" %>
<%@ page import="com.sist.web.model.User" %>
<%
Logger logger = LogManager.getLogger("userProc.jsp");
HttpUtil.requestLogString(request, logger);

String msg = "";
String redirectUrl = "";

String userFlag = HttpUtil.get(request, "userFlag");
String userId = HttpUtil.get(request, "userId");
String userPwd = HttpUtil.get(request, "userPwd");
String userName = HttpUtil.get(request, "userName");
String userEmail = HttpUtil.get(request, "userEmail");
String userPhone = HttpUtil.get(request, "userPhone");
String zipcode = HttpUtil.get(request, "zipcode");
String addr1 = HttpUtil.get(request, "addr1");
String addr2 = HttpUtil.get(request, "addr2");

String cookieUserId = CookieUtil.getValue(request, "USER_ID");

UserDao userDao = new UserDao();

if(StringUtil.isEmpty(cookieUserId)){
	//회원가입
	if(!StringUtil.isEmpty(userId) && !StringUtil.isEmpty(userPwd) && !StringUtil.isEmpty(userName) && !StringUtil.isEmpty(userEmail)){
		if(userDao.userIdSelectCount(userId) > 0){
			//아이디 중복
			msg = "이미 사용중인 아이디입니다.";
			redirectUrl = "/user/join.jsp";
		} else {
			//회원가입가능
			User user = new User();
			
			user.setUserId(userId);
			user.setUserPwd(userPwd);
			user.setUserName(userName);
			user.setUserEmail(userEmail);
			user.setUserPhone(userPhone);
			user.setZipcode(zipcode);
			user.setAddr1(addr1);
			user.setAddr2(addr2);
			user.setUserStatus("Y");
			user.setUserFlag(userFlag);
			
			if(userDao.userInsert(user) > 0){
				msg = "회원가입이 완료 되었습니다.";
				redirectUrl = "/";
			}else{
				msg = "회원가입 중 오류가 발생했습니다.";
				redirectUrl = "/user/join.jsp";
			}
		}
	} else {
		//입력값이 넘어오지 않은경우
		msg = "입력값이 넘어오지 않음";
		redirectUrl = "/user/join.jsp";
	}
} else {
	//회원정보 수정
	
	logger.debug("cookieUser id : " + cookieUserId);
	User user = userDao.userSelect(cookieUserId);
	if(user != null){
		if(StringUtil.equals(user.getUserId(), userId) && StringUtil.equals(user.getUserStatus(), "Y")){
			if(!StringUtil.isEmpty(userId) && !StringUtil.isEmpty(userPwd) 
	            && !StringUtil.isEmpty(userName) && !StringUtil.isEmpty(userEmail) && !StringUtil.isEmpty(userPhone) 
	            && !StringUtil.isEmpty(zipcode) && !StringUtil.isEmpty(addr1) && !StringUtil.isEmpty(addr2)){
				
				user.setUserId(userId);
				user.setUserPwd(userPwd);
				user.setUserName(userName);
				user.setUserEmail(userEmail);
				user.setUserPhone(userPhone);
				user.setZipcode(zipcode);
				user.setAddr1(addr1);
				user.setAddr2(addr2);
				
				if(userDao.userUpdate(user) > 0){
					msg = "회원 정보가 수정 되었습니다..";
					redirectUrl = "/user/userUpdate.jsp";
				}else{
					msg = "회원 정보 수정중 오류가 발생했습니다.";
					redirectUrl = "/user/userUpdate.jsp";
				}
			}else{
					msg ="회원 수정 정보가 올바르지 않습니다.";
					redirectUrl = "/user/userUpdate.jsp";
			}
		}else{
			CookieUtil.deleteCookie(request, response, "/", "USER_ID");
			
			msg = "정지된 사용자입니다.";
			redirectUrl ="/";
		}
	}else{
		msg = "사용중인 회원이 아닙니다.";
		redirectUrl ="/";
	}
}
%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/include/header.jsp" %>
<script>
	$(document).ready(function(){
		alert("<%=msg%>");
		location.href = "<%=redirectUrl%>";
	});
</script>
</head>
<body>
</body>
</html>