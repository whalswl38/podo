<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="org.apache.logging.log4j.LogManager" %>
<%@ page import="org.apache.logging.log4j.Logger" %>
<%@ page import="com.sist.common.util.StringUtil" %>
<%@ page import="com.sist.web.util.HttpUtil" %>
<%@ page import="com.sist.web.util.CookieUtil" %>
<%@ page import="com.sist.web.dao.BoardDao" %>
<%@ page import="com.sist.web.model.Board" %>
<%@ page import="java.util.List" %>
<%
	Logger logger = LogManager.getLogger("/board/writeProc.jsp");
	HttpUtil.requestLogString(request, logger);
	
	String cookieUserId = CookieUtil.getValue(request, "USER_ID");
	
	boolean success_flag = false;
	
	String errorMessage = "";
	
	String jobFlag = HttpUtil.get(request, "jobFlag", "");
	String jobTitle = HttpUtil.get(request, "jobTitle", "");
	String carFlag = HttpUtil.get(request, "carFlag", "");
	String schoFlag = HttpUtil.get(request, "schoFlag", "");
	int recruNum = HttpUtil.get(request, "recruNum", 0);
	String workerFlag = HttpUtil.get(request, "workerFlag", "");
	String jobSal = HttpUtil.get(request, "jobSal", "");
	String jobArea = HttpUtil.get(request, "jobArea", "");
	String jobContent = HttpUtil.get(request, "jobContent", "");
	String expDate = HttpUtil.get(request, "expDate", "");
	
	if(!StringUtil.isEmpty(cookieUserId)){
		if(!StringUtil.isEmpty(jobFlag) && !StringUtil.isEmpty(jobTitle) && !StringUtil.isEmpty(carFlag) &&
			!StringUtil.isEmpty(schoFlag) && !StringUtil.isEmpty(recruNum) && !StringUtil.isEmpty(workerFlag) &&
			!StringUtil.isEmpty(jobSal) && !StringUtil.isEmpty(jobArea) && !StringUtil.isEmpty(jobContent) && !StringUtil.isEmpty(expDate)){
			
			Board board = new Board();
			BoardDao boardDao = new BoardDao();
			
			board.setUserId(cookieUserId);
			board.setJobFlag(jobFlag);
			board.setJobTitle(jobTitle);
			board.setCarFlag(carFlag);
			board.setSchoFlag(schoFlag);
			board.setRecruNum(recruNum);
			board.setWorkerFlag(workerFlag);
			board.setJobSal(jobSal);
			board.setJobArea(jobArea);
			board.setJobContent(jobContent);
			board.setExpDate(expDate);
	
			if(boardDao.jobInsert(board) > 0){
				success_flag = true;
			}else{
				errorMessage = "공고등록에 실패했습니다.";
			}
			
		}else{
			errorMessage = "공고등록에 필요한 값이 올바르지 않습니다.";
		}
	}else{
		errorMessage = "로그인 후 이용해주세요.";
	}
%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/include/header.jsp" %>
<script>
$(document).ready(function(){
	<%
			if(success_flag == true){
	%>
			alert("게시물이 등록되었습니다.");
			location.href = "/board/comList.jsp";
	<%
			}else{
	%>	
			alert("<%=errorMessage%>");
			location.href = "/board/write.jsp";
	<%
			}
	%>
});
</script>
</head>
<body>

</body>
</html>