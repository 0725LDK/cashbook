<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%@ page import="java.util.*" %>
<%
	//Controller
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null || loginMember.getMemberLevel()<1)
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
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css" rel="stylesheet">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
	<h1>카테고리 추가 페이지</h1>
	<form action="<%=request.getContextPath()%>/admin/insertCategoryAction.jsp" method="post">
		<table>
			<tr>
				<td>수입/지출 선택</td>
				<td>	
					<input type="radio" name="categoryKind" value="수입">수입
					<input type="radio" name="categoryKind" value="지출">지출
				</td>
			</tr>
			
			<tr>		
				<td>내용</td>
				<td>
					<input type="text" name="categoryName">
				</td>
			</tr>
		</table>
		
	<button type="submit">추가</button>
	</form>
	<%
		if(request.getParameter("msg")!=null)
		{
	%>		
			<span><%=request.getParameter("msg") %></span>	
	<%		
			
		}
	%>
</body>
</html>