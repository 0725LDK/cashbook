<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<%@ page import="java.util.*" %>

<%
	request.setCharacterEncoding("utf-8");
	System.out.println("11111---"+ request.getParameter("commentMemo"));	

	Comment comment = new Comment();
	comment.setCommentMemo(request.getParameter("commentMemo"));
	comment.setCommentNo(Integer.parseInt(request.getParameter("commentNo")));
	int commentNo = comment.getCommentNo();
	String commentMemo = comment.getCommentMemo();
	
	System.out.println("222222----" + commentMemo);	
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>문의 답변 수정 페이지</h1>
	<form action="<%=request.getContextPath()%>/admin/updateCommentAction.jsp" method="post">
			<input type="hidden" name="commentNo" value="<%=commentNo%>">
		<table>
			<tr>
				<td>기존 답변</td>
				<td><input type="text" value="<%=commentMemo%>" readonly="readonly"></td>
			</tr>
			<tr>
				<td> 답변 수정</td>
				<td><textarea rows="3" cols="30" name="commentMemo"></textarea></td>
			</tr>
		</table>
		<button type="submit">수정완료</button>
	</form>
</body>
</html>