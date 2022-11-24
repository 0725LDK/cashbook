<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%
	//Controller
	Member loginMember = (Member)session.getAttribute("login");
	if(loginMember == null || loginMember.getMemberLevel()<0)
	{
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	
	//Model

	//최근공지 5개 최근멤버 5명
	
	//View
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<ul>
		<li><a href="">공지관리</a></li>
		<li><a href="">카테고리관리</a></li>
		<li><a href="">멤버관리(목록,레벨수정,강제탈퇴)</a></li>
	</ul>
</body>
</html>