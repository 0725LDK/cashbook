<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.net.URLEncoder"%>
<%@ page import="java.util.*" %>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>

<%

	//Controller
	//로그인이 안되어 있을때 or 일반 사용자는 접근불가
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null || loginMember.getMemberLevel()<1)
	{
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}

	request.setCharacterEncoding("utf-8");
	Comment comment = new Comment();
	comment.setHelpNo(Integer.parseInt(request.getParameter("helpNo")));
	comment.setCommentMemo(request.getParameter("commentMemo"));
	comment.setMemberId(request.getParameter("memberId"));
	
	CommentDao commentDao = new CommentDao();
	int row = commentDao.insertComment(comment);
	
	if(row==1)
	{
		System.out.println(row+"insertCommentAction 성공");
	}
	else
	{
		System.out.println(row+"insertCommentAction 실패");
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