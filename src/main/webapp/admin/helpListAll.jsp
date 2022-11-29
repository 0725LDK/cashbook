<%@page import="java.net.URLEncoder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>

<%
	//Controller
	Member loginMember = (Member)session.getAttribute("loginMember");
	System.out.println(loginMember +"<=== adminMain loginMember 넘어오는 값");
	if(loginMember == null || loginMember.getMemberLevel()<1)
	{
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	} 
	
	//페이징 변수
	int firstPage = 1;
	int currentPage = 1;
	if(request.getParameter("currentPage") != null)
	{
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	
	int rowPerPage = 10;
	int beginRow = (currentPage-1) * rowPerPage;
	int count = 0; //총행수
	int lastPage = 0;
	
	HelpDao helpDao  = new HelpDao();
	ArrayList<HashMap<String, Object>> list = helpDao.selectHelpList(beginRow, rowPerPage); //리스트출력
	
	//String commentMemo = URLEncoder.encode(m.get("commentMemo"),"utf-8");
	
	count = helpDao.helpCount();
	lastPage = count / rowPerPage;
	
	if(count%rowPerPage != 0)
	{
		lastPage = lastPage+1;
	}
	

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

	<!-- head include -->
	<div>
		<jsp:include page="/inc/head.jsp"></jsp:include>
	</div>

	<!-- 고객센터 문의 목록 -->
	<table>
		<tr>
			<th>문의내용</th>
			<th>회원ID</th>
			<th>문의날짜</th>
			<th>답변내용</th>
			<th>답변날짜</th>
			<th>답변입력 / 수정 / 삭제</th>
		</tr>
		
		<%
			for(HashMap<String, Object> m :list)
			{
		%>
				<tr>
					<input type="hidden" name="commentNo" value="<%=m.get("commentNo")%>">
					<td><%=m.get("helpMemo") %></td>
					<td><%=m.get("memberId") %></td>
					<td><%=m.get("helpCreatedate") %></td>
					
					<td>
						<%
							if(m.get("commentMemo") == null)
							{
						%>
								<span>@답변 대기중@</span>
						<%
							}
							else
							{
						%>
								<%=m.get("commentMemo")%>
						<%
							}
						%>
					</td>
					<td>
						<%
							if(m.get("commentCreatedate") == null)
							{
						%>
								<span> ...........시간 미정...........</span>
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
								<a href="<%=request.getContextPath() %>/admin/insertCommentForm.jsp?helpNo=<%=m.get("helpNo")%>"> 
									답변입력
								</a>
						<% 
							}
							else
							{
						%>		
								<a href="<%=request.getContextPath() %>/admin/updateCommentForm.jsp?commentNo=<%=m.get("commentNo")%>&commentMemo=<%=m.get("commentMemo")%>">답변수정</a>	
								<a href="<%=request.getContextPath() %>/admin/deleteCommentAction.jsp?commentNo=<%=m.get("commentNo")%>">답변삭제</a>	
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
			<%
				if(currentPage == 1)
				{
			%>
					<span>처음으로</span>		
					<span>이전</span>		
			<%		
				}
				else
				{
			%>
					<a href="<%=request.getContextPath()%>/admin/helpListAll.jsp?currentPage=<%=firstPage%>">처음으로</a>
					<a href="<%=request.getContextPath()%>/admin/helpListAll.jsp?currentPage=<%=currentPage-1%>">이전</a>
			<%
				}
			%>
			
			<span> [<%=currentPage %>  ] </span>
			
			<%
				if(currentPage == lastPage)
				{
			%>		
					<span>다음</span>		
					<span>마지막으로</span>		
			<%		
				}
				else
				{
			%>
					<a href="<%=request.getContextPath()%>/admin/helpListAll.jsp?currentPage=<%=currentPage+1%>">다음</a>
					<a href="<%=request.getContextPath()%>/admin/helpListAll.jsp?currentPage=<%=lastPage%>">마지막으로</a>
			<%		
				}
			%>
		</div>
	<!-- footer include -->
</body>
</html>