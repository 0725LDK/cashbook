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
	
	//Model
	CategoryDao categoryDao = new CategoryDao();
	ArrayList<Category> categoryList = categoryDao.selectCategoryListByAdmin();
	
	//View
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
	<div>
		<jsp:include page="/inc/head.jsp"></jsp:include>
	</div>
	<div>
		<!-- category contents-->
		<h1>카테고리 목록</h1>
		<a href="<%=request.getContextPath()%>/admin/insertCategoryForm.jsp">카테고리 추가</a>
		<table>
			<tr>
				<th>번호</th>
				<th>수입/지출</th>
				<th>이름</th>
				<th>마지막 수정 날짜</th>
				<th>생성 날짜</th>
				<th>수정</th>
				<th>삭제</th>
			</tr>
			<!-- 모델데이터 categoryList -->
			<%
				for(Category c : categoryList)
				{
			%>
					<tr>
						<td><%=c.getCategoryNo() %></td>
						<td><%=c.getCategoryKind() %></td>
						<td><%=c.getCategoryName() %></td>
						<td><%=c.getUpdatedate() %></td>
						<td><%=c.getCreatedate() %></td>
						<td>
							<a href="<%=request.getContextPath()%>/admin/updateCategoryForm.jsp?categoryNo=<%=c.getCategoryNo()%>">수정</a>
						</td>
						<td>
							<a href="<%=request.getContextPath()%>/admin/deleteCategoryAction.jsp?categoryNo=<%=c.getCategoryNo()%>">삭제</a>
						</td>
					</tr>
			<%
				}
			
			%>
		</table>
	</div>
</body>
</html>