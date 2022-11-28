<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.net.*" %>

<%
	request.setCharacterEncoding("utf-8");
	String msg = null;
	if(request.getParameter("categoryKind") == null || request.getParameter("categoryKind").equals("")
			|| request.getParameter("categoryName") == null || request.getParameter("categoryName").equals(""))
	{
		msg = URLEncoder.encode("항목을 입력하세요","utf-8");
		response.sendRedirect(request.getContextPath()+"/admin/updateCategoryForm.jsp?msg="+msg+"&categoryNo="+request.getParameter("categoryNo"));
		return;
	}
	Category category = new Category();
	category.setCategoryNo(Integer.parseInt(request.getParameter("categoryNo")));
	category.setCategoryKind(request.getParameter("categoryKind"));
	category.setCategoryName(request.getParameter("categoryName"));
	
	CategoryDao categoryDao = new CategoryDao();
	int row = categoryDao.updateCategoryName(category);
	
	if(row == 1)
	{
		System.out.println(row + "<===updateCategoryAction 성공");
	}
	else
	{
		System.out.println(row + "<===updateCategoryAction 실패");
		
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