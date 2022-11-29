<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<%@ page import="java.util.*" %>

<%
	request.setCharacterEncoding("utf-8");

	Help help = new Help();
	help.setHelpNo(Integer.parseInt(request.getParameter("helpNo")));
	help.setHelpMemo(request.getParameter("helpMemo"));
	
	HelpDao helpDao = new HelpDao();
	int row = helpDao.helpUpdate(help);
	
	if(row==1)
	{
		System.out.println(row+"<---updateHelpAction 성공");
	}
	else
	{
		System.out.println(row+"<---updateHelpAction 성공");
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