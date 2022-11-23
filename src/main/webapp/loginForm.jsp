<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	//로그인이 되어 있을때는 접근불가
	if(session.getAttribute("loginMember") != null)
	{
		response.sendRedirect(request.getContextPath()+"/cash/cashList.jsp");
		return;
	}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>loginForm</title>
</head>
<body>
	<form action="<%=request.getContextPath()%>/loginAction.jsp" method="post">
		<h1>로그인</h1>
		<table>
			<tr>
				<td>ID:</td>
				<td><input type="text" name="memberId"></td>
			</tr>
			<tr>
				<td>PW:</td>
				<td><input type="password" name="memberPw"></td>
			</tr>
		</table>
		<button type="submit">로그인</button>
	</form>
	<div>
		<a href="<%=request.getContextPath()%>/insertMemberForm.jsp">회원가입</a>
	</div>
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