<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.util.*"%>
<%@ page import = "java.sql.*"%>
<%@ page import = "dao.*" %>
<%@ page import = "vo.*" %>
<%

	//세션정보
	if(session.getAttribute("loginMember") == null){
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	
	//수입 지출 내용
	CategoryDao categoryDao = new CategoryDao();
	ArrayList<Category> categoryList = categoryDao.selectCategoryList();
	
	Member loginMember = (Member)session.getAttribute("loginMember");
	String loginMemberId = loginMember.getMemberId();
	
	//값 설정
	int year = Integer.parseInt(request.getParameter("year"));
	int month = Integer.parseInt(request.getParameter("month"));
	int date = Integer.parseInt(request.getParameter("date"));
	int cashNo = Integer.parseInt(request.getParameter("cashNo"));
	
	System.out.println(request.getParameter("cashNo"));
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>가계부 수정 페이지</h1>
	<form action="<%=request.getContextPath()%>/cash/updateCashAction.jsp" method="post">
		<input type="hidden" name="memberId" value="<%=loginMemberId%>">
		<input type="hidden" name="year" value="<%=year%>"> 
		<input type="hidden" name="month" value="<%=month%>"> 
		<input type="hidden" name="date" value="<%=date%>"> 
		<input type="hidden" name="cashNo"  value="<%=cashNo%>">
		<table>
			<tr>
				<td>수입/지출 + 내용</td>
				<td>
					<select name="categoryNo">
						<%
							for(Category c : categoryList)
							{
						%>		
								<option value="<%=c.getCategoryNo()%>"><%=c.getCategoryKind() %> - <%=c.getCategoryName() %></option>
						<%		
								System.out.println(c.getCategoryNo() + "<==카테고리 넘버");
							}
						%>
					</select>
				</td>
			</tr>
			
			<tr>
					<td>cash_date</td>
					<%
						if(date < 10) {
					%>
							<td><input type="text" name="cashDate" value="<%=year%>-<%=month+1%>-<%=date%>" readonly="readonly"></td>
					<%
						} else {
					%>
							<td><input type="text" name="cashDate" value="<%=year%>-<%=month+1%>-<%=date%>" readonly="readonly"></td>
					<%
						}
					%>
				</tr>
			
			<tr>
				<td>금액</td>
				<td> 
					<input type="text" name="cashPrice"> 원
				</td>
			</tr>
			<tr>
				<td>메모</td>
				<td> 
					<textarea rows="3" cols="50" name="cashMemo"></textarea>
				</td>
			</tr>
			
			
		</table>
	
	<button type="submit">수정하기</button>
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