<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>

<%	
	//Controller
	request.setCharacterEncoding("utf-8");
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null || loginMember.getMemberLevel()<1)
	{
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}


	Notice notice = new Notice();
	notice.setNoticeNo(Integer.parseInt(request.getParameter("noticeNo")));
	int noticeNo = notice.getNoticeNo();
	notice.setNoticeMemo(request.getParameter("noticeMemo"));
	String noticeMemo = notice.getNoticeMemo();

%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css" rel="stylesheet">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
	<h1>공지 수정 페이지</h1>
	<form action="<%=request.getContextPath()%>/admin/updateNoticeAction.jsp" method="post">
		<table>
			<tr>
				<td>공지번호</td>
				<td><input type="text" name="noticeNo" value="<%=noticeNo%>" readonly="readonly"></td>
			</tr>
			<tr>
				<td>공지메모</td>
				<td><textarea rows="3" cols="30" name="noticeMemo"></textarea></td>
			</tr>
		</table>
		<button type="submit">수정하기</button>
	</form>
		<%
			if(request.getParameter("msg") != null)
			{
		%>
				<span><%=request.getParameter("msg") %></span>
		<%		
			}
		%>
</body>
</html>