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
	Logger logger = LogManager.getLogger("/board/comDetail.jsp");
	HttpUtil.requestLogString(request, logger);
	
	String cookieUserId = CookieUtil.getValue(request, "USER_ID");
	String cookieUserFlag = CookieUtil.getValue(request, "USER_FLAG");

	if("U".equals(cookieUserFlag) || "".equals(cookieUserFlag))
	response.sendRedirect("/user/loginOut.jsp");
	
	int jobSeq = HttpUtil.get(request, "jobSeq", 0);
	
	String searchType = HttpUtil.get(request, "searchType", "");
	String searchValue = HttpUtil.get(request, "searchValue", "");
	//curPage못가져오는중
	int curPage = HttpUtil.get(request, "curPage", 1);
	
	logger.info("curPage = " + curPage);
	BoardDao boardDao = new BoardDao();
	Board board = boardDao.jobDetail(jobSeq);
	
	if(board != null){
		//조회수 증가
		boardDao.jobReadCntPlus(jobSeq);
	}
%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/include/header.jsp" %>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=c5afd7d1c04d90f5cbc3cb96de239cb8&libraries=services"></script>
<script>
$(document).ready(function() {
	<%
		if(board == null) {
	%>	
			alert("공고가 존재하지 않습니다.");
			document.seqForm.action = "/board/comList.jsp";
			document.seqForm.submit();
	<%
		} else {
	%>
			$("#btnList").on("click",function(){
				document.seqForm.action = "/board/comList.jsp";
				document.seqForm.submit();
			});

				$("#btnUpdate").on("click",function(){
				    document.seqForm.action = "/board/comUpdate.jsp";
					document.seqForm.submit();
				});
				
				$("#btnDelete").on("click",function(){
					if(confirm("공고를 삭제하시겠습니까?") == true){
						document.seqForm.action = "/board/comDelete.jsp";
						document.seqForm.submit();
					}
				});
	<%
			}
		
	%>
});
</script>
</head>
<body>
<%@ include file="/include/navigation.jsp"%>
	<br/>
	<h2 class="" align="center"><b><%=board.getJobTitle()%></b></h2>
	<br/>
	<div class="container">
		<div align="center"><i class="bi bi-calendar"></i>&nbsp;등록일 : <%=board.getRegDate()%>&emsp;<span>|</span>&emsp;<i class="bi bi-calendar"></i>&nbsp;마감일 : <%=board.getExpDate()%></div>
		<br>
		<div class="form-join d-flex justify-content-center">
			<table style="width:550px; height: 150px">
				<tr>
					<th><i class="bi bi-briefcase"></i>&nbsp;직무</th>
					<td><%=board.getJobFlag()%></td>
					<th><i class="bi bi-cash-coin"></i>&nbsp;급여</th>
					<td><%=board.getJobSal()%></td>
				</tr>
				
				<tr>
					<th><i class="bi bi-bank"></i>&nbsp;학력</th>
					<td><%=board.getSchoFlag()%></td>
					<th><i class="bi bi-pin-map"></i>&nbsp;근무지역</th>
					<td><%=board.getJobArea()%></td>
				</tr>
				
				<tr>
					<th><i class="bi bi-card-list"></i>&nbsp;근무형태</th>
					<td><%=board.getWorkerFlag()%></td>
					<th><i class="bi bi-person"></i>&nbsp;채용인원</th>
					<td><%=board.getRecruNum()%></td>
				</tr>
				
				<tr>
					<th><i class="bi bi-chat-square-text"></i>&nbsp;상세내용</th>
				</tr>
			</table>
		</div>
		<div style="width:500px; " class="form-join d-flex justify-content-center">
			<%=StringUtil.replace(HttpUtil.filter(board.getJobContent()), "\n", "<br/>")%>
		</div>
		<div class="form-join d-flex justify-content-center" style="width:600px; border-bottom:1px solid black;"></div>
		<br>
		<div class="form-join d-flex justify-content-center">
			<table style="width:550px; height: 150px">
				<tr>
					<th><i class="bi bi-building"></i>&nbsp;기업명</th>
					<td><%=board.getUserName()%></td>
				</tr>
				
				<tr>
					<th><i class="bi bi-envelope"></i>&nbsp;이메일</th>
					<td><%=board.getUserEmail()%></td>
					<th><i class="bi bi-telephone"></i>&nbsp;전화</th>
					<td><%=board.getUserPhone()%></td>
				</tr>
				
				<tr>
					<th><i class="bi bi-pin-map"></i>&nbsp;주소</th>
					<td><%=board.getAddr1()%></td>
				</tr>
			</table>
		</div>
		<div id="map" class="form-join d-flex justify-content-center" style="width:500px;height:400px;" align="center"></div>
		<br>
		<div class="form-group row justify-content-center" >
			<div class="col-sm-12" style="width :500px">
				<div style="float: left;">
					<button type="button" id="btnList" class="btn btn-purple">목록</button>
				</div>
			
				<div style="float: right;">
					<button type="button" id="btnUpdate" class="btn btn-purple" title="수정">수정</button>
					<button type="button" id="btnDelete" class="btn btn-purple" title="삭제">삭제</button>
				</div>
			</div>
		</div>
		<form name="seqForm" id="seqForm" method="post">
			<input type="hidden" name="jobSeq" value="<%=jobSeq%>"/>
			<input type="hidden" name="searchType" value="<%=searchType%>"/>
   			<input type="hidden" name="searchValue" value="<%=searchValue%>"/>
   			<input type="hidden" name="curPage" value="<%=curPage%>"/>
		</form>
	</div>
<br>
<%@ include file="/include/footer.jsp" %>
<script>
var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
    mapOption = {
        center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
        level: 3 // 지도의 확대 레벨
    };  

// 지도를 생성합니다    
var map = new kakao.maps.Map(mapContainer, mapOption); 

// 주소-좌표 변환 객체를 생성합니다
var geocoder = new kakao.maps.services.Geocoder();

// 주소로 좌표를 검색합니다
geocoder.addressSearch('<%=board.getAddr1()%>&nbsp;<%=board.getAddr2()%>', function(result, status) {

    // 정상적으로 검색이 완료됐으면 
     if (status === kakao.maps.services.Status.OK) {

        var coords = new kakao.maps.LatLng(result[0].y, result[0].x);

        // 결과값으로 받은 위치를 마커로 표시합니다
        var marker = new kakao.maps.Marker({
            map: map,
            position: coords
        });

        // 인포윈도우로 장소에 대한 설명을 표시합니다
        var infowindow = new kakao.maps.InfoWindow({
            content: '<div style="width:150px;text-align:center;padding:6px 0;"><%=board.getUserName()%></div>'
            
        });
        infowindow.open(map, marker);

        // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
        map.setCenter(coords);
    } 
});    
</script>
</body>
</html>