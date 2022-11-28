<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.util.*"%>
<%@ page import = "dao.*" %>
<%@ page import = "vo.*" %>
<%
	Member loginMember = (Member)session.getAttribute("loginMember");
	
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
	<h1>회원 탈퇴 페이지</h1>	
	<form	action="<%=request.getContextPath()%>/deleteMemberAction.jsp" method="post">
		<table>
			<tr>
				<td>ID : </td>
				<td><input type="text" name="memberId" value="<%=loginMember.getMemberId()%>" readonly="readonly"></td>
			</tr>
			<tr>
				<td>PW : </td>
				<td><input type="password" name="memberPw"></td>
			</tr>
			
		</table>
	<button type="submit">삭제하기</button>
	</form>
	
	<%
		if(request.getParameter("msg") != null)
		{
	%>
			<span style="color:red">경고!</span>
			<span><%=request.getParameter("msg") %></span>
	<%
		}
	%>
</body>
</html>