<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.net.*" %>

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
	String msg = null;
	if(request.getParameter("noticeMemo") == null || request.getParameter("noticeMemo").equals(""))
	{
		msg = URLEncoder.encode("항목을 입력하세요","utf-8");
		response.sendRedirect(request.getContextPath()+"/admin/noticeUpdateForm.jsp?msg="+msg+"&noticeNo="+request.getParameter("noticeNo"));
		return;
	}

	Notice notice = new Notice();
	notice.setNoticeNo(Integer.parseInt(request.getParameter("noticeNo")));
	int noticeNo = notice.getNoticeNo();
	notice.setNoticeMemo(request.getParameter("noticeMemo"));
	String noticeMemo = notice.getNoticeMemo();
	
	NoticeDao noticeDao = new NoticeDao();
	int row = noticeDao.updateNotice(notice);
	
	if(row == 1)
	{
		System.out.println(row + "noticeUpdateAction 업데이트성공");
	}
	
	response.sendRedirect(request.getContextPath()+"/admin/noticeList.jsp?noticeNo="+noticeNo+"&noticeMemo="+noticeMemo);
	
	


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