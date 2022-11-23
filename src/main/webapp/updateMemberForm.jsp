<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	//로그인이 안되어 있을때는 접근불가
	if(session.getAttribute("loginMember") == null)
	{
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>회원정보 수정 페이지</h1>
	<form action="<%=request.getContextPath()%>/updateMemberAction.jsp" method="post">
		<table>
			<tr>
				<td> ID </td>
				<td> <input type="text" name="memberId" value="<%=request.getParameter("memberId")%>" readonly="readonly"> </td>
			</tr>
			
			<tr>
				<td> 기존 이름 </td>
				<td> <input type="text" name="memberName" value="<%=request.getParameter("memberName")%>" readonly="readonly"> </td>
			</tr>
			<tr>
				<td> 바꿀 이름 </td>
				<td> <input type="text" name="newName"> </td>
			</tr>
			
			<tr>
				<td> 비밀번호 확인 </td>
				<td> <input type="password" name="memberPw"> </td>
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