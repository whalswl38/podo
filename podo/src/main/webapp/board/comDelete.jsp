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
	Logger logger = LogManager.getLogger("/board/comDelete.jsp");
	HttpUtil.requestLogString(request, logger);
	
	String cookieUserId = CookieUtil.getValue(request, "USER_ID");
	
	boolean success = false;
	String errorMessage = "";
	
	int jobSeq = HttpUtil.get(request, "jobSeq", 0);
	
	if(jobSeq > 0){
		BoardDao boardDao =  new BoardDao();
		Board board = boardDao.jobDetail(jobSeq);
		
		if(board != null){
			if(StringUtil.equals(cookieUserId, board.getUserId())){
				if(boardDao.jobDelete(jobSeq) > 0){
					success = true;
				} else {
					errorMessage = "공고 삭제 중 오류가 발생했습니다.";
				}
			} else {
				errorMessage = "로그인 사용자의 게시물이 아닙니다.";
			}
		} else {
			errorMessage = "해당 공고가 존재하지 않습니다.";
		}
	} else {
		errorMessage = "공고 번호가 올바르지 않습니다.";
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
		alert("해당 공고가 삭제되었습니다.");
	<%
	} else {
	%>
		alert("<%=errorMessage%>");
	<%
	}
	%>
	location.href = "/board/comList.jsp"
});
</script>
</head>
<body>
<%@ include file="/include/navigation.jsp" %>
<%@ include file="/include/footer.jsp" %>
</body>
</html>