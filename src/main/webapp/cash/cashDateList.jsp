<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.util.*"%>
<%@ page import = "dao.*" %>
<%@ page import = "vo.*" %>
<%
	//세션정보
	if(session.getAttribute("loginMember") == null){
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	
	//Map 매개변수
	Member loginMember = (Member)session.getAttribute("loginMember");
	String loginMemberId = loginMember.getMemberId();
	//연월일 받기
	int year = Integer.parseInt(request.getParameter("year"));
	int month = Integer.parseInt(request.getParameter("month"));
	int date = Integer.parseInt(request.getParameter("date"));
	
	CategoryDao CategoryDao = new CategoryDao();
	ArrayList<Category> categoryList = CategoryDao.selectCategoryList();
	
	CashDao cashDao = new CashDao(); 
	ArrayList<HashMap<String, Object>> list = cashDao.selectCashListByMonth(loginMemberId, year, month);
	
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<!-- cash 목록 출력 -->
	<h1><%=year %>년 <%=month %>월 <%=date %>일 상세내역</h1>
	
	<table>
		<tr>
			<td>수입/지출</td>
			<td>내용</td>
			<td>금액</td>
			<td>메모</td>
			<td>수정일자</td>
			<td>생성일자</td>
			<td>편집</td>
		</tr>
		
		<%
			//해당일의 가계부 목록 출력
			for(HashMap<String, Object> m : list)
			{
				String cashDate = (String)(m.get("cashDate"));
				if(Integer.parseInt(cashDate.substring(0, 4)) == year && Integer.parseInt(cashDate.substring(5, 7)) == month && Integer.parseInt(cashDate.substring(8)) == date)
				{
					System.out.println((Integer)(m.get("cashNo")));
		%>
					
					<tr>
						<td><%=(String)m.get("categoryKind")%>&nbsp;</td>
						<td><%=(String)m.get("categoryName")%>&nbsp;</td>
						<td><%=(Long)m.get("cashPrice")%>원&nbsp;</td>
						<td><%=(String)m.get("cashMemo")%>&nbsp;</td>
						<td><%=(String)m.get("updateDate")%>&nbsp;</td>
						<td><%=(String)m.get("createDate")%>&nbsp;</td>
						<td>
							<a href="<%=request.getContextPath()%>/cash/updateCashForm.jsp?year=<%=year%>&month=<%=month%>&date=<%=date%>&cashNo=<%=m.get("cashNo")%>">수정&nbsp;</a>
							<a href="<%=request.getContextPath()%>/cash/deleteCashAction.jsp?year=<%=year%>&month=<%=month%>&date=<%=date%>&cashNo=<%=m.get("cashNo")%>&memberId=<%=loginMemberId%>">삭제</a></td>
						</td>
					<tr>
		<%
				}
			}
		%>
	</table>
	
	<a href="<%=request.getContextPath()%>/cash/cashList.jsp">돌아가기</a>
	
	<!-- cash 입력폼 -->
	<form action="<%=request.getContextPath()%>/cash/insertCashAction.jsp" method="post">
		<input type="hidden" name="memberId" value="<%=loginMember.getMemberId()%>">
		<input type="hidden" name="year" value="<%=year%>">
		<input type="hidden" name="month" value="<%=month%>">
		<input type="hidden" name="date" value="<%=date%>">
		<table>
			<tr>
				<td>categoryNo</td>
				<td><!-- 카테고리 넘버 출력 -->
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
				<td>cashDate</td>
				<td>
					<input type="text" name="cashDate" value="<%=year %>-<%=month %>-<%=date %>" readonly="readonly">
				</td>
			</tr>
			
			<tr>
				<td>cashPrice</td>
				<td>
					<input type="text" name="cashPrice">
				</td>
			</tr>

			<tr>
				<td>cashMemo</td>
				<td>
					<textarea rows="3" cols="50" name="cashMemo"></textarea>
				</td>
			</tr>
			
		</table>
	<button type="submit">입력</button>
	</form>
	
	<%
		if(request.getParameter("msg1") != null)
		{
	%>
			<span style="color:red"><%=request.getParameter("msg1") %></span>
			<span><%=request.getParameter("msg") %></span>
	<%	
		}
		else if(request.getParameter("msg1") == null && request.getParameter("msg") != null )
		{
	%>
			<span><%=request.getParameter("msg") %></span>
	<%		
		}
	%>
	
</body>
</html>
