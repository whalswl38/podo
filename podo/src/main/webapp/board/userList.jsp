<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="org.apache.logging.log4j.LogManager" %>
<%@ page import="org.apache.logging.log4j.Logger" %>
<%@ page import="com.sist.common.util.StringUtil" %>
<%@ page import="com.sist.web.util.HttpUtil" %>
<%@ page import="com.sist.web.dao.BoardDao" %>
<%@ page import="com.sist.web.model.Board" %>
<%@ page import="com.sist.web.model.Paging" %>
<%@ page import="com.sist.web.model.BoardFileConfig" %>
<%@ page import="java.util.List" %>
<%
	Logger logger = LogManager.getLogger("/board/userList.jsp");
	HttpUtil.requestLogString(request, logger);
	String cookieUserFlag = CookieUtil.getValue(request, "USER_FLAG");

	if("C".equals(cookieUserFlag) || "".equals(cookieUserFlag))
	response.sendRedirect("/user/loginOut.jsp");
	
	//조회항목(1:직무구분, 2:공고명, 3:공고내용)
	String searchType = HttpUtil.get(request, "searchType", "");
	//조회값
	String searchValue = HttpUtil.get(request, "searchValue", "");
	//현재 페이지
	int curPage = HttpUtil.get(request, "curPage", 1);
	
	int totalCount = 0;
	List<Board> list = null;
	
	Paging paging = null;
	
	Board board = new Board();
	board.setUserId(CookieUtil.getValue(request, "USER_ID"));
	
	BoardDao boardDao = new BoardDao();
	
	if(!StringUtil.isEmpty(searchType) && !StringUtil.isEmpty(searchValue)){
		if(StringUtil.equals(searchType, "1")){
			//직무구분 조회
			board.setJobFlag(searchValue);
		}else if(StringUtil.equals(searchType, "2")){
			//제목 조회
			board.setJobTitle(searchValue);
		}else if(StringUtil.equals(searchType, "3")){
			//내용 조회
			board.setJobContent(searchValue);
		}
	}else{
		searchType = "";
		searchValue = "";
	}
	
	totalCount = boardDao.jobTotalCount(board);
	
	logger.debug("=====================================");
	logger.debug("게시판 총 게시물 수 : " + totalCount);
	logger.debug("=====================================");
	
	if(totalCount > 0){
		paging = new Paging(totalCount, BoardFileConfig.LIST_COUNT, BoardFileConfig.PAGE_COUNT, curPage);
		
		board.setStartRow(paging.getStartRow());
		board.setEndRow(paging.getEndRow());
		
		list = boardDao.userJobList(board);
	}	
%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/include/header.jsp" %>
<script>
$(document).ready(function(){
	$("#_searchType").change(function(){
		$("#_searchValue").val("");
	});
	
    $("#btnSearch").on("click", function(){
    	if($("#_searchType").val() != ""){
    		if($.trim($("#_searchValue").val()) == ""){
    			alert("검색하실 단어를 입력해주세요.");
    			$("#_searchValue").val("");
    			$("#_searchValue").focus();
    			return;
    		}
    	} 
    	document.comListForm.jobSeq.value = "";
    	document.comListForm.searchType.value = $("#_searchType").val();
    	document.comListForm.searchValue.value = $("#_searchValue").val();
    	document.comListForm.action = "/board/userList.jsp";
    	document.comListForm.submit();
    });
});

function fn_list(curPage){
	document.comListForm.jobSeq.value = "";
	document.comListForm.curPage.value = curPage;
	document.comListForm.action = "/board/userList.jsp";
	document.comListForm.submit();
}

function fn_view(jobSeq){
	document.comListForm.jobSeq.value = jobSeq;
	document.comListForm.action = "/board/userDetail.jsp";
	document.comListForm.submit();
}
</script>


<script type="text/javascript">
function toggleBook(id){
	$.ajax({
		type: "POST",
		url: "/board/scrapProc.jsp",
		data: { userId : "<%=CookieUtil.getValue(request, "USER_ID")%>", 
				jobSeq : id
				},
		datatype: "json",
		success: function(obj) {
			var data = JSON.parse(obj);
			if(data.result == "250"){
				$("#"+id).html("<i class='bi bi-bookmark-fill'></i>");
			}else if(data.result == "100"){
				$("#"+id).html("<i class='bi bi-bookmark'></i>");
			}else{
				alert("1에러가 발생했습니다 로그를 확인해주세요")
			}
		},
		error: function(error){
			alert("에러가 발생했습니다 로그를 확인해주세요")
		}
	});
}
</script>
</head>
<body>
<%@ include file="/include/navigation.jsp" %>
<br/>
<div class="container">
	<div style="width:500px; float: left;" class="input-group mb-3">
		<select name="_searchType" id="_searchType" class="btn btn-purple" style="width:auto;">
			<option value="">검색 항목</option>
			<option value="1" <%if(StringUtil.equals(searchType, "1")){%>selected<%}%>>직무</option>
			<option value="2" <%if(StringUtil.equals(searchType, "2")){%>selected<%}%>>공고명</option>
			<option value="3" <%if(StringUtil.equals(searchType, "3")){%>selected<%}%>>공고내용</option>
		</select>
		<input type="text" name="_searchValue" id="_searchValue" value="<%=searchValue%>" class="form-control mx-1" maxlength="40" style="width:auto;ime-mode:active;"/>
		<button id="btnSearch" name="btnSearch" class="btn btn-purple btn-outline-secondary" type="button">
			<svg style="color: white" xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-search" viewBox="0 0 16 16">
			<path d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001c.03.04.062.078.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1.007 1.007 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0z"/>
			</svg>
		</button>
	</div>
	<table class="table">
		<thead>
			<tr style="background-color: #9575CD; color:white;">
				<th scope="col" class="text-center" style="width:5%">번호</th>
				<th scope="col" class="text-center" style="width:15%">공고명</th>
				<th scope="col" class="text-center" style="width:10%">작성자</th>
				<th scope="col" class="text-center" style="width:15%">등록일</th>
				<th scope="col" class="text-center" style="width:15%">마감일</th>
				<th scope="col" class="text-center" style="width:5%">조회수</th>
				<th scope="col" class="text-center" style="width:5%">마감여부</th>
				<th scope="col" class="text-center" style="width:5%">스크랩</th>
			</tr>
		</thead>
<%
	if(list != null && list.size() > 0){
		int startNum = paging.getStartNum();
		
		for(int i = 0; i < list.size(); i++){
			Board bboard = list.get(i);
%>   
		<tbody>
			<tr class="alert">
				<td class="text-center"><%=startNum%></td>
				<td><a href="javascript:void(0)" style="text-decoration-line : none; color:black;" onclick="fn_view(<%=bboard.getJobSeq()%>)"><b><%=bboard.getJobTitle()%></b></a></td>
				<td class="text-center"><%=bboard.getUserName()%></td>
				<td class="text-center"><%=bboard.getRegDate()%></td>
				<td class="text-center"><%=bboard.getExpDate()%></td>
				<td class="text-center"><%=StringUtil.toNumberFormat(bboard.getJobHits())%></td>
				<%if("Y".equals(bboard.getExpFlag())){%>
					<td class="text-center"><div class="badge bg-purple text-white justify-content-center">마감</div></td>
				<% }else{%>
					<td class="text-center"><div class="badge bg-purple text-white justify-content-center"></div></td>
				<% }%>
				
				<%if("Y".equals(bboard.getScrapYn())){%>
					<td class="text-center"><a id="<%=bboard.getJobSeq()%>" onclick="toggleBook(this.id);"><i class="bi bi-bookmark-fill"></i></a></td>
				<%}else{%>
					<td class="text-center"><a id="<%=bboard.getJobSeq()%>" onclick="toggleBook(this.id);"><i class="bi bi-bookmark"></i></a></td>
				<%} %>
			</tr>
		</tbody>
<%
			startNum--;
		}
	} else {
%> 
		<tbody>
			<tr class="alert">
				<td class="text-center" colspan="5">검색결과가 없습니다</td>
			</tr>
		</tbody>
<% 
	}
%>	
	</table>
   <!-- 페이지네이션 -->
	<div class="container" align="center">
		<nav>
			<ul class="pagination justify-content-center"> 
<%
	if(paging != null){
		if(paging.getPrevBlockPage() > 0){
%>		
				<li class="page-item">
					<a class="page-link" href="javascript:void(0)" onclick="fn_list(<%=paging.getPrevBlockPage()%>)" aria-label="Previous">
					<span aria-hidden="true">&laquo;</span>
					</a>
				</li>
<%
		}
		
		for(int i = paging.getStartPage(); i <= paging.getEndPage(); i++){
			if(paging.getCurPage() != i){
%>  				
			    <li class="page-item"><a class="page-link" href="javascript:void(0)" onclick="fn_list(<%=i%>)"><%=i%></a></li>
<%
			}else{
%>		    
			    <li class="page-item"><a class="page-link" href="javascript:void(0)" style="cursor:default;"><%=i%></a></li>
<%
			}
		}
		
		if(paging.getNextBlockPage() > 0){
%>			    
			    <li class="page-item">
					<a class="page-link" href="javascript:void(0)" onclick="fn_list(<%=paging.getNextBlockPage()%>)" aria-label="Next">
					<span aria-hidden="true">&raquo;</span>
					</a>
			    </li>
<%
			}
		}
%>	    
			</ul>
		</nav>
		<form name="comListForm" id="comListForm" method="post">
			<input type="hidden" name="jobSeq" value=""/>
	   		<input type="hidden" name="searchType" value="<%=searchType%>"/>
	   		<input type="hidden" name="searchValue" value="<%=searchValue%>"/>
	   		<input type="hidden" name="curPage" value="<%=curPage%>"/>
	   </form>
	</div>
</div>
</body>
</html>
