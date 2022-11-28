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
<title>Insert title here</title>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css" rel="stylesheet">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
	<h1>회원가입 페이지</h1>
	<form action="<%=request.getContextPath()%>/insertMemberAction.jsp" method="post">
		<table>
			<tr>
				<td> ID </td>
				<td> <input type="text" name="memberId"> </td>
			</tr>
			<tr>
				<td> PW </td>
				<td> <input type="password" name="memberPw"> </td>
			</tr>
			<tr>
				<td> PW 확인 </td>
				<td> <input type="password" name="chkPw"> </td>
			</tr>
			<tr>
				<td> 이름 </td>
				<td> <input type="text" name="memberName"> </td>
			</tr>
		</table>
		<button type="submit">회원가입</button>
	</form>
	
	<%
		if(request.getParameter("msg") != null)
		{
	%>
			<span style="color:red">경고! </span>
			<span><%=request.getParameter("msg") %></span>
	<%	
		}
	
	%>
</body>
</html>