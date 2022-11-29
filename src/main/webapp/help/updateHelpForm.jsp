<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%
	request.setCharacterEncoding("utf-8");
	if(session.getAttribute("loginMember")==null)
	{
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	} 
	// session에 저장된 멤버(현재 로그인)
	Member loginMember = (Member)session.getAttribute("loginMember");

	int helpNo = Integer.parseInt(request.getParameter("helpNo"));
	String helpMemo = request.getParameter("helpMemo");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>문의 수정 페이지</h1>
	<form action="<%=request.getContextPath()%>/help/updateHelpAction.jsp" method="post">
		<input type="hidden" name="helpNo" value="<%=helpNo%>">
		<table>
			<tr>
				<td>게시글 수정 전 내용</td>
				<td><input type="text" value="<%=helpMemo%>" readonly="readonly"></td>
			</tr>
			<tr>
				<td>게시글 수정 후 내용</td>
				<td><input type="text" name="helpMemo"></td>
			</tr>
		</table>
		<button type="submit">수정하기</button>
	</form>
</body>
</html>