<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>

<%
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
</head>
<body>
	<form action="<%=request.getContextPath()%>/admin/noticeUpdateAction.jsp" method="post">
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
</body>
</html>