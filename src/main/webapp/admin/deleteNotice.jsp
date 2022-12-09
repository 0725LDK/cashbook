<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<%@ page import="java.util.*" %>


<%
	//로그인이 안되어 있을때 or 일반 사용자는 접근불가
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null || loginMember.getMemberLevel()<1)
	{
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}

	Notice notice = new Notice();
	notice.setNoticeNo(Integer.parseInt(request.getParameter("noticeNo")));
	NoticeDao noticeDao = new NoticeDao();
	int row = noticeDao.deleteNotice(notice);
	
	if(row == 1)
	{
		System.out.println(row +"noticeDelete 삭제성공");
	}
	else
	{
		System.out.println(row +"noticeDelete 삭제실패");
		
	}
	response.sendRedirect(request.getContextPath()+"/admin/noticeList.jsp");
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