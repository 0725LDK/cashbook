<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
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
	
	HelpDao helpDao = new HelpDao();
	ArrayList<HashMap<String, Object>> list  = helpDao.selectHelpList(memberId);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>고객센터</h1>
	<table>
		<tr>
			<th>문의내용</th>
			<th>문의날짜</th>
			<th>답변내용</th>
			<th>답변날짜</th>
			<th>수정</th>
			<th>삭제</th>
		</tr>
		
		<%
			for(HashMap<String, Object> m : list)
			{
		%>
				<input type="hidden" name="helpNo" value="<%=m.get("helpNo")%>">
				<tr>
					<td><%=m.get("helpMemo") %></td>
					<td><%=m.get("helpCreatedate") %></td>
					
					<td>
						<%
							if(m.get("commentMemo") ==null)
							{
						%>
								답변전
						<%
							}
							else
							{
						%>
								<%=m.get("commentMemo") %>
						<%
							}
						
						%>
					</td>
					
					<td>
						<%
							if(m.get("commentCreatedate") == null)
							{
						%>
								답변전
						<%		
							}
							else
							{
						%>
						
								<%=m.get("commentCreatedate") %>
						<%
							}
						%>
					</td>
					
					<td>
						<%
							if(m.get("commentMemo") == null)
							{
						%>
								<a href="<%=request.getContextPath()%>/help/updateHelpForm.jsp?helpNo=<%=m.get("helpNo")%>&helpMemo=<%=m.get("helpMemo")%>">수정</a>
						<%
							}
							else
							{
						%>
								&nbsp;
						<%
							}
						%>
					</td>
					<td>
						<%
							if(m.get("commentMemo") == null)
							{
						%>
								<a href="<%=request.getContextPath()%>/help/deleteHelpAction.jsp?helpNo=<%=m.get("helpNo")%>">삭제</a>
						<%
							}
							else
							{
						%>
								&nbsp;
						<%
							}
						%>
					</td>
				</tr>
		<%		
			}
		
		%>
	</table>
	
	<div>
		<a href="<%=request.getContextPath()%>/help/insertHelpForm.jsp">문의 추가</a>
		<a href="<%=request.getContextPath()%>/cash/cashList.jsp">돌아가기</a>
	</div>
</body>
</html>