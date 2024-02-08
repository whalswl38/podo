<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="org.apache.logging.log4j.LogManager" %>
<%@ page import="org.apache.logging.log4j.Logger" %>
<%@ page import="com.sist.web.util.HttpUtil" %>
<%@ page import="com.sist.web.util.CookieUtil" %>
<%@ page import="com.sist.common.util.StringUtil" %>
<%@ page import="com.sist.mail.GmailSend" %>
<%@ page import="com.sist.web.dao.UserDao" %>
<%@ page import="com.sist.web.model.User" %>

<%
Logger logger = LogManager.getLogger("userIdFindAjax.jsp");
HttpUtil.requestLogString(request, logger);

String mail = HttpUtil.get(request, "mail"); 
String content = HttpUtil.get(request, "content"); 
String title= HttpUtil.get(request, "title"); 
String id = HttpUtil.get(request, "id"); 
String verifyNum = HttpUtil.get(request, "verifyNum"); 
GmailSend gmail = new GmailSend();
UserDao userDao = new UserDao();

int result = 0;

//받아온 ID로 user 검색
User user= userDao.userSelect(id);

// 검색값이 있을때,
if(!StringUtil.isEmpty(user)){
		//값이 있고, 받아온 email == 검색값의 email 같을때,
		if(mail.equals(user.getUserEmail())){
			user.setUserPwd(verifyNum);
			if(userDao.userUpdatePwd(user) == 1)
				result = gmail.send(title, content,mail);
			if(result != 250){
				response.getWriter().write("{\"result\": " + "\"" + result + "\"" + ",\"errMsg\": \"발송에 실패하였습니다.\"}");
			}else{
				response.getWriter().write("{\"result\": " + "\"" + result + "\"" + ",\"errMsg\": \"발송성공\"}");
			}
		//mail 이 일치하지 않을때,
		}else{
			response.getWriter().write("{\"result\": " + "\"" + result+ "\"" + ",\"errMsg\": \"이메일을 확인해주세요\"}");
		};
//아이디가 없을 때, 
}else{
	response.getWriter().write("{\"result\": " + "\"" + result + "\"" + ",\"errMsg\": \"아이디를 확인해주세요\"}");
}
%>