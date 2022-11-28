<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>

<%
	//Controller
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null || loginMember.getMemberLevel()<1)
	{
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}

	Category category = new Category();
	category.setCategoryNo(Integer.parseInt(request.getParameter("categoryNo")));
	int categoryNo = category.getCategoryNo();
	System.out.println(categoryNo);
	CategoryDao categoryDao = new CategoryDao();
	categoryDao.selectCategoryOne(categoryNo);
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
	<h1>카테고리 수정 페이지</h1>
	<form action="<%=request.getContextPath()%>/admin/updateCategoryAction.jsp" method="post">
		<input type="hidden" name="categoryNo" value="<%=categoryNo%>">
		<table>
			<tr>
				<td>수입/지출 수정</td>
				<td>
					<input type="radio" name="categoryKind" value="수입">수입
					<input type="radio" name="categoryKind" value="지출">지출
				</td>
			</tr>
			
			<tr>
				<td>수입/지출 내용 수정</td>
				<td>
					<input type="text" name="categoryName">
				</td>
			</tr>
		
		</table>
		<button type="submit">수정하기</button>
	</form>
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