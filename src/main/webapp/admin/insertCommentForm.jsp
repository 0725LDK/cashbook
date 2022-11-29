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
	int helpNo = Integer.parseInt(request.getParameter("helpNo"));
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>문의 답변 작성 페이지</h1>
	<form action="<%=request.getContextPath()%>/admin/insertCommentAction.jsp" method="post">
			<input type="hidden" name="helpNo" value="<%=helpNo%>">
			<input type="hidden" name="memberId" value="<%=loginMember%>">
		<table>
			<tr>
				<td>문의 답변 작성</td>
				<td><textarea rows="3" cols="30" name="commentMemo"></textarea></td>
			</tr>
		</table>
		<button type="submit">작성완료</button>
	</form>
</body>
</html>