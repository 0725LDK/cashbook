<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<%@ page import="java.util.*" %>
<%
	request.setCharacterEncoding("utf-8");
	// session에 저장된 멤버(현재 로그인)
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(session.getAttribute("loginMember")==null)
	{
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	
	String memberId = loginMember.getMemberId();

%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>문의 추가 페이지</h1>
	<form	action="<%=request.getContextPath()%>/help/insertHelpAction.jsp" method="post">
		<table>
			<tr>
				<td>작성자</td>
				<td><input type="text" name="memberId" value="<%=memberId%>" readonly="readonly"></td>
			</tr>
			
			<tr>
				<td>문의내용</td>
				<td><input type="text" name="helpMemo"></td>
			</tr>
			
		</table>
		<button type="submit">작성하기</button>
	</form>
</body>
</html>