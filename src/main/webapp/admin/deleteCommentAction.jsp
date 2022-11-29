<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<%@ page import="java.util.*" %>

<%
	Comment comment = new Comment();
	comment.setCommentNo(Integer.parseInt(request.getParameter("commentNo")));
	
	CommentDao commentDao = new CommentDao();
	int row = commentDao.deleteComment(comment);
	if(row == 1)
	{
		System.out.println(row + "<===deleteCommentAction 성공");
	}
	else
	{
		System.out.println(row + "<===deleteCommentAction 실패");
		
	}
	
	response.sendRedirect(request.getContextPath()+"/admin/helpListAll.jsp");
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