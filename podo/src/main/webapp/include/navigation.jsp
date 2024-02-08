<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.sist.common.util.StringUtil" %>
<%@ page import="com.sist.web.util.CookieUtil" %>
<%@ page import="com.sist.web.util.HttpUtil" %>
<%@ page import="com.sist.web.dao.UserDao" %>
<%@ page import="com.sist.web.model.User" %>

<%
	UserDao userDao1 = new UserDao();
	String userId1 = CookieUtil.getValue(request, "USER_ID");
	User user1 = null;

	
	if(StringUtil.isEmpty(userId1)){
%>
	<nav class="navbar navbar-expand-lg navbar-dark bg-purple">
	    <div class="container px-4 px-lg-5">
	        <a id="title" class="text-white navbar-brand" href="/index.jsp">podo</a>
	        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
	        	<span class="navbar-toggler-icon"></span>
	        </button>
	        <!-- 로그인 하지 않았을때 -->
	        <div class="collapse navbar-collapse" id="navbarSupportedContent">
	            <ul class="navbar-nav ms-auto mb-2 mb-lg-0">
	                <li class="nav-item"><a class="nav-link active" aria-current="page" href="/index.jsp">Home</a></li>
	                <li class="nav-item"><a class="nav-link" href="/user/login.jsp">Login</a></li>
	                <li class="nav-item"><a class="nav-link" href="/user/join.jsp">Join</a></li>
	            </ul>
	     </div>
	     </div>
	</nav>	    
<%
	}else{
		user1 = userDao1.userSelect(userId1);
%>	        
	<nav class="navbar navbar-expand-lg navbar-dark bg-purple">
	    <div class="container px-4 px-lg-5">
	        <a id="title" class="text-white navbar-brand" href="/index.jsp">podo</a>
	        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
	        	<span class="navbar-toggler-icon"></span>
	        </button>
	        <!-- 로그인 했을때 -->
<%
			if(StringUtil.equals(user1.getUserFlag(), "C")){
%>
	        <div class="collapse navbar-collapse" id="navbarSupportedContent">
	            <ul class="navbar-nav ms-auto mb-2 mb-lg-0">
	                <li class="nav-item"><a class="nav-link active" aria-current="page" href="/index.jsp" >Home</a></li>
	                <li class="nav-item"><a class="nav-link" href="/user/loginOut.jsp">Logout</a></li>
	                <li class="nav-item"><a class="nav-link" href="/user/myPage.jsp">MyPage</a></li>
	                <li class="nav-item"><a class="nav-link" href="/board/comList.jsp">JobOpening(기업회원)</a></li>
	            </ul>
	     	</div>
<%
			}else if(StringUtil.equals(user1.getUserFlag(), "U")){
%>
	        <div class="collapse navbar-collapse" id="navbarSupportedContent">
				<ul class="navbar-nav ms-auto mb-2 mb-lg-0">
					<li class="nav-item"><a class="nav-link active" aria-current="page" href="/index.jsp" >Home</a></li>
	                <li class="nav-item"><a class="nav-link" href="/user/loginOut.jsp">Logout</a></li>
	                <li class="nav-item"><a class="nav-link" href="/user/myPage.jsp">MyPage</a></li>
	                <li class="nav-item"><a class="nav-link" href="/board/userScrap.jsp">MyScrap</a></li>
	                <li class="nav-item"><a class="nav-link" href="/board/userList.jsp">JobOpening(개인회원)</a></li>
	            </ul>
			</div>
<%
   			}
%>
	     </div>
	</nav>	
<%			
	}	
%>