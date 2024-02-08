<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="org.apache.logging.log4j.LogManager" %>
<%@ page import="org.apache.logging.log4j.Logger" %>
<%@ page import="com.sist.common.util.StringUtil" %>
<%@ page import="com.sist.web.util.HttpUtil" %>
<%@ page import="com.sist.web.dao.BoardDao" %>
<%@ page import="com.sist.web.model.Board" %>
<%@ page import="com.sist.web.model.Paging" %>
<%@ page import="com.sist.web.dao.ScrapDao" %>
<%@ page import="com.sist.web.model.Scrap" %>
<%@ page import="com.sist.web.model.BoardFileConfig" %>
<%@ page import="java.util.List" %>
<%
	Logger logger = LogManager.getLogger("/board/userList.jsp");
	HttpUtil.requestLogString(request, logger);
	
	Scrap scrap = new Scrap();
	scrap.setUserId(CookieUtil.getValue(request, "USER_ID"));
	ScrapDao scrapDao = new ScrapDao();
	List<Scrap> list = scrapDao.selectScrapList(scrap);
	
%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/include/header.jsp" %>
<script>
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
				location.reload();
			}else if(data.result == "100"){
				$("#"+id).html("<i class='bi bi-bookmark'></i>");
				location.reload();
			}else{
				alert("에러가 발생했습니다 로그를 확인해주세요")
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
<br>
<h2 align="center"><b>나의 스크랩</b></h2>
<br>
<div class="container">
	<table class="table">
		<thead>
			<tr style="background-color: #9575CD; color:white;">
				<th scope="col" class="text-center" style="width:15%">공고명</th>
				<th scope="col" class="text-center" style="width:10%">작성자</th>
				<th scope="col" class="text-center" style="width:15%">등록일</th>
				<th scope="col" class="text-center" style="width:15%">마감일</th>
				<th scope="col" class="text-center" style="width:5%">마감여부</th>
				<th scope="col" class="text-center" style="width:5%">스크랩</th>
			</tr>
		</thead>
<%
	if(list != null && list.size() > 0){
		
		for(int i = 0; i < list.size(); i++){
			Scrap scrap2 = list.get(i);
%>			
		<tbody>
			<tr class="alert">
				<td><a href="/board/userDetail.jsp?jobSeq=<%=scrap2.getJobSeq()%>" style="text-decoration-line : none; color:black;"><b><%=scrap2.getJobTitle()%></b></a></td>
				<td class="text-center"><%=scrap2.getUserName()%></td>
				<td class="text-center"><%=scrap2.getRegDate()%></td>
				<td class="text-center"><%=scrap2.getExpDate()%></td>
				
			<% if("Y".equals(scrap2.getExpFlag())){ %>
				<td class="text-center"><div class="badge bg-purple text-white justify-content-center">마감</div></td>
			<% }else{ %>
				<td class="text-center"><div class="badge bg-purple text-white justify-content-center"></div></td>
			<% } %>
			<% if("Y".equals(scrap2.getScrapYn())){ %>
				<td class="text-center"><a id="<%=scrap2.getJobSeq()%>" onclick="toggleBook(this.id);"><i class="bi bi-bookmark-fill"></i></a></td>
			<% }else{ %>
				<td class="text-center"><a id="<%=scrap2.getJobSeq()%>" onclick="toggleBook(this.id);"><i class="bi bi-bookmark"></i></a></td>
			<% } %>
			</tr>
		</tbody>
<%
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
</div>
</body>
</html>
