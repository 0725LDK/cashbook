<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<%@ page import="java.util.*" %>

<%
	int categoryNo = Integer.parseInt(request.getParameter("categoryNo"));

	CategoryDao categoryDao = new CategoryDao();
	int row = categoryDao.deleteCategory(categoryNo);
	
	if(row == 1)
	{
		System.out.println(row + "<===deleteCategoryAction 성공");
	}
	else
	{
		System.out.println(row + "<===deleteCategoryAction 실패");
		
	}
	response.sendRedirect(request.getContextPath()+"/admin/categoryList.jsp");
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