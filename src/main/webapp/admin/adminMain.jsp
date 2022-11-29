<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%
	//Controller
	Member loginMember = (Member)session.getAttribute("loginMember");
	System.out.println(loginMember +"<=== adminMain loginMember 넘어오는 값");
	if(loginMember == null || loginMember.getMemberLevel()<1)
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
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css" rel="stylesheet">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
	<div>
		<jsp:include page="/inc/head.jsp"></jsp:include>
	</div>
	<div>
		<!-- adminMain contents-->
	
	</div>
</body>
</html>