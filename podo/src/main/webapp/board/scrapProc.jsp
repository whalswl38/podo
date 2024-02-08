<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.sist.web.dao.ScrapDao" %>
<%@ page import="com.sist.web.model.User" %>
<%@ page import="org.apache.logging.log4j.LogManager" %>
<%@ page import="org.apache.logging.log4j.Logger" %>
<%@ page import="com.sist.web.util.HttpUtil" %>
<%@ page import="com.sist.web.util.CookieUtil" %>
<%@ page import="com.sist.common.util.StringUtil" %>
<% 
	Logger logger = LogManager.getLogger("scrapProc.jsp");
	HttpUtil.requestLogString(request, logger);
	String userId = HttpUtil.get(request, "userId"); 
	String jobSeq = HttpUtil.get(request, "jobSeq"); 
	
	logger.info("userId=" + userId);
	logger.info("jobSeq=" + jobSeq);
	
	ScrapDao scrapDao = new ScrapDao();
		logger.info("1");
	if (scrapDao.selectScrap(jobSeq, userId) > 0) {
		logger.info("2");
		int cnt  = scrapDao.deleteScrap(jobSeq, userId);
		logger.info("cnt="+cnt);
		if(cnt > 0 ){
			response.getWriter().write("{\"result\":\""+100+"\"}");
		}
	}else{
		logger.info("4");
		int cnt  = scrapDao.insertScrap(jobSeq, userId);
		logger.info("5");
		if(cnt > 0 ){
			response.getWriter().write("{\"result\":\""+250+"\"}");
		}
		logger.info("6");
	}
	
%>