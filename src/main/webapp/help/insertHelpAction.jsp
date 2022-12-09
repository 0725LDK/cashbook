<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<%@ page import="java.util.*" %>

<%
	//로그인이 안되어 있을때는 접근불가
	if(session.getAttribute("loginMember") == null)
	{
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	

	request.setCharacterEncoding("utf-8");

	Help help = new Help();
	help.setMemberId(request.getParameter("memberId"));
	help.setHelpMemo(request.getParameter("helpMemo"));
	
	HelpDao helpDao = new HelpDao();
	int row = helpDao.helpInsert(help);
	
	if(row==1)
	{
		System.out.println(row +"<===insertHelpAction 성공");
	}
	else
	{
		System.out.println(row +"<===insertHelpAction 성공");
	}
	
	response.sendRedirect(request.getContextPath()+"/help/helpList.jsp");
	

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