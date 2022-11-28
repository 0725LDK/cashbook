<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<%@ page import="java.util.*" %>

<%
	Member member = new Member();
	member.setMemberId(request.getParameter("memberId"));
	
	MemberDao memberDao = new MemberDao();
	int row = memberDao.deleteMemberByAdmin(member);
	
	if(row == 1)
	{
		System.out.println(row + "<===deleteMemberAction 성공");
	}
	else
	{
		System.out.println(row + "<===deleteMemberAction 실패");
		
	}
	
	response.sendRedirect(request.getContextPath()+"/admin/memberList.jsp");
%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

</body>
</html>