<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="org.apache.logging.log4j.LogManager" %>
<%@ page import="org.apache.logging.log4j.Logger" %>
<%@ page import="com.sist.web.util.HttpUtil" %>
<%@ page import="com.sist.web.util.CookieUtil" %>
<%@ page import="com.sist.common.util.StringUtil" %>
<%@ page import="com.sist.web.dao.UserDao" %>
<%@ page import="com.sist.web.model.User" %>
<%
	//HTTP로그
	Logger logger = LogManager.getLogger("userIdFindAjax.jsp");
	HttpUtil.requestLogString(request, logger);

	String userId = HttpUtil.get(request, "userId"); 
	String userName = HttpUtil.get(request, "userName"); 
	String userEmail = HttpUtil.get(request, "userEmail"); 
	
	if (!StringUtil.isEmpty(userName) && !StringUtil.isEmpty(userEmail)) {
		UserDao userDao = new UserDao();
		String id = userDao.userFindId(userName, userEmail);
		response.getWriter().write("{\"id\":\""+id+"\"}");
	}
%>
