<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<%@ page import="java.util.*" %>

<%
	request.setCharacterEncoding("utf-8");

	int helpNo = Integer.parseInt(request.getParameter("helpNo"));
	
	HelpDao helpDao = new HelpDao();
	int row = helpDao.helpDelete(helpNo);
	
	if(row==1)
	{
		System.out.println(row+"<===deleteHelpAction 삭제성공");
	}
	else
	{
		System.out.println(row+"<===deleteHelpAction 삭제실패");
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