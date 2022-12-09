<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.net.URLEncoder"%>
<%@ page import="java.util.*" %>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>

<%

	//로그인이 안되어 있을때 or 일반 사용자는 접근불가
	Member loginMember = (Member)session.getAttribute("loginMember");
	System.out.println(loginMember +"<=== adminMain loginMember 넘어오는 값");
	if(loginMember == null || loginMember.getMemberLevel()<1)
	{
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	} 
	
	request.setCharacterEncoding("utf-8");
	String msg = null;
	if(request.getParameter("categoryKind")==null || request.getParameter("categoryKind").equals("")
		||request.getParameter("categoryName")==null || request.getParameter("categoryName").equals("") )
	{
		msg = URLEncoder.encode("항목을 입력하세요","utf-8");
		response.sendRedirect(request.getContextPath()+"/admin/insertCategoryForm.jsp?msg="+msg);
		return;
	}
		
	

	Category category = new Category();
	category.setCategoryKind(request.getParameter("categoryKind"));
	category.setCategoryName(request.getParameter("categoryName"));
	
	CategoryDao categoryDao = new CategoryDao();
	
	int row = categoryDao.insertCategory(category);
	
	if(row==1)
	{
		System.out.println(row+"<==insertCategoryAction 추가 성공");
	}
	else
	{
		System.out.println(row+"<==insertCategoryAction 추가 실패");
	
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