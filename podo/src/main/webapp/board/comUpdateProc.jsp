<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="org.apache.logging.log4j.LogManager" %>
<%@ page import="org.apache.logging.log4j.Logger" %>
<%@ page import="com.sist.common.util.StringUtil" %>
<%@ page import="com.sist.web.util.HttpUtil" %>
<%@ page import="com.sist.web.util.CookieUtil" %>
<%@ page import="com.sist.web.dao.BoardDao" %>
<%@ page import="com.sist.web.model.Board" %>
<%
	Logger logger = LogManager.getLogger("/board/comUpdateProc.jsp");
	HttpUtil.requestLogString(request, logger);
	
	String cookieUserId = CookieUtil.getValue(request, "USER_ID");
	
	boolean bSuccess = false;
	String errorMessage = "";
	
	int jobSeq = HttpUtil.get(request, "jobSeq", 0);
	String searchType = HttpUtil.get(request, "searchType", "");
	String searchValue = HttpUtil.get(request, "searchValue", "");
	int curPage = HttpUtil.get(request, "curPage", 1);
	
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
	
	if(jobSeq > 0 && !StringUtil.isEmpty(jobFlag) && !StringUtil.isEmpty(jobTitle) && !StringUtil.isEmpty(carFlag) &&
		!StringUtil.isEmpty(schoFlag) && !StringUtil.isEmpty(recruNum) && !StringUtil.isEmpty(workerFlag) &&
		!StringUtil.isEmpty(jobSal) && !StringUtil.isEmpty(jobArea) && !StringUtil.isEmpty(jobContent) && !StringUtil.isEmpty(expDate)){
		BoardDao boardDao = new BoardDao();
		Board board = boardDao.jobDetail(jobSeq);
		
		if(board != null){
			if(StringUtil.equals(cookieUserId, board.getUserId())){
				board.setJobSeq(jobSeq);
				board.setJobFlag(jobFlag);
				board.setJobTitle(jobTitle);
				board.setJobContent(jobContent);
				board.setCarFlag(carFlag);
				board.setSchoFlag(schoFlag);
				board.setRecruNum(recruNum);
				board.setWorkerFlag(workerFlag);
				board.setJobSal(jobSal);
				board.setJobArea(jobArea);
				board.setJobContent(jobContent);
				board.setExpDate(expDate);
				
				if(boardDao.jobUpdate(board) > 0) {
					bSuccess = true;
				} else {
					errorMessage = "공고 수정 중 오류가 발생하였습니다.";
				}
			} else {
				errorMessage = "공고가 존재하지 않습니다.";
			}
		}
	} else {
		errorMessage = "공고 수정 항목이 올바르지 않습니다.";
	}
%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/include/header.jsp" %>
<script>
$(document).ready(function(){
	<%
		if(bSuccess == true){
	%>
		//정상적으로 처리
		alert("공고가 수정되었습니다.");
		document.seqForm.action = "/board/comList.jsp";
		document.seqForm.submit();
	<%
		} else {
	%>	
		//오류 처리
		alert("<%=errorMessage%>");
		location.href = "/board/comList.jsp";
	<%
		}
	%>		
	});
</script>
</head>
<body>
<%@ include file="/include/navigation.jsp" %>
<form name="seqForm" id="seqForm" method="post">
	<input type="hidden" name="bbsSeq" value="<%=jobSeq%>"/>
	<input type="hidden" name="searchType" value="<%=searchType%>" />
	<input type="hidden" name="searchValue" value="<%=searchValue%>" />
	<input type="hidden" name="curPage" value="<%=curPage%>" />
</form>
</body>
</html>