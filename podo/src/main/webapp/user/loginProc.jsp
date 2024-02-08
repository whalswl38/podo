<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="org.apache.logging.log4j.LogManager" %>
<%@ page import="org.apache.logging.log4j.Logger" %>
<%@ page import="com.sist.web.util.HttpUtil" %>
<%@ page import="com.sist.web.util.CookieUtil" %>
<%@ page import="com.sist.web.dao.UserDao" %>
<%@ page import="com.sist.web.model.User" %>
<%@ page import="com.sist.common.util.StringUtil" %>

<%
Logger logger = LogManager.getLogger("loginProc.jsp");
   
   HttpUtil.requestLogString(request, logger);
   
   String userId = HttpUtil.get(request, "userId");
   String userPwd = HttpUtil.get(request, "userPwd");
   String cookieUserId = CookieUtil.getValue(request, "USER_ID");
   
   String msg = "";
   String redirectUrl = "";
   
   User user = null;
   UserDao userDao = new UserDao();
   
   logger.debug("userId : " + userId);
   logger.debug("userPwd : " + userPwd);
   
   if(StringUtil.isEmpty(cookieUserId)){   
	  //로그인이 안되어 있을 경우
      if(!StringUtil.isEmpty(userId) && !StringUtil.isEmpty(userPwd)){
         user = userDao.userSelect(userId);
         
         if(user != null){
            if(StringUtil.equals(userPwd, user.getUserPwd())){
               if(StringUtil.equals(user.getUserStatus(), "Y")){
            	   if(StringUtil.equals(user.getUserFlag(), "U")){
	                  CookieUtil.addCookie(response, "/", "USER_ID", userId);
	                  CookieUtil.addCookie(response, "/", "USER_FLAG", user.getUserFlag());
	                  msg = userId + "(개인회원)님 안녕하세요.";
	                  redirectUrl = "/";       
            	   } else {
 	                  CookieUtil.addCookie(response, "/", "USER_ID", userId);
	                  CookieUtil.addCookie(response, "/", "USER_FLAG", user.getUserFlag());
	                  msg = userId + "(기업회원)님 안녕하세요.";
 	                  redirectUrl = "/";  
            	   }
               }else{
                  msg = "정지된 사용자 입니다.";
                  redirectUrl = "/";
               }
            }else{
               msg = "비밀번호가 일치하지 않습니다.";
               redirectUrl = "/";
            }
         }else{
            msg = "아이디가 존재하지 않습니다.";
            redirectUrl = "/";
         }
      }else{
         //아이디나 비밀번호가 입력되지 않은 경우
         msg = "아이디나 비밀번호가 입력되지 않았습니다.";
         redirectUrl = "/";
      }
   }else{
      //쿠키정보가 있을 경우
      logger.debug("쿠키 정보가 있을 경우................");
      
      if(!StringUtil.isEmpty(userId)){
         user = userDao.userSelect(userId);
         
         if(user != null){
            if(StringUtil.equals(userPwd, user.getUserPwd())){
               if(StringUtil.equals(user.getUserStatus(), "Y")){
   				if(!StringUtil.equals(cookieUserId, userId)){
					CookieUtil.deleteCookie(request, response, "USER_ID");
					CookieUtil.addCookie(response, "USER_ID", userId);
				}
                  msg = "사용자입니다.";
                  redirectUrl = "/";                  
               }else{
                  CookieUtil.deleteCookie(request, response, "USER_ID");
                  msg = "정지된 사용자 입니다.";
                  redirectUrl = "/";
               }
            }else{
               CookieUtil.deleteCookie(request, response, "USER_ID");
               msg = "비밀번호가 잘못되었습니다.";
               redirectUrl = "/";
            }               
         }else{
            CookieUtil.deleteCookie(request, response, "USER_ID");
            msg = "사용자가 아닙니다.";
            redirectUrl = "/";
         }
      }else{
         CookieUtil.deleteCookie(request, response, "USER_ID");
         msg = "사용자 아이디 입력이 잘못되었습니다.";
         redirectUrl = "/";
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