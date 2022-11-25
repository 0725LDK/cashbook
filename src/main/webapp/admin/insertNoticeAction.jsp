<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<%@ page import="java.util.*" %>

<%
	request.setCharacterEncoding("utf-8");
	Notice notice = new Notice();
	notice.setNoticeMemo(request.getParameter("noticeMemo"));
	
	NoticeDao noticeDao = new NoticeDao();
	
	int row = noticeDao.insertNotice(notice);
	if(row == 1)
	{
		System.out.println(row + "<===insertNoticeAction 성공");
	}
	else
	{
		System.out.println(row + "<===insertNoticeAction 성공");
		
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