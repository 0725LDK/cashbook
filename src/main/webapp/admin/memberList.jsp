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
	
	int firstPage = 1;//1페이지 설정
	int currentPage = 1;// 현재 페이지
	if(request.getParameter("currentPage")!=null)
	{
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	int rowPerPage = 5;
	int beginRow = (currentPage-1)*rowPerPage;
	MemberDao memberDao = new MemberDao();
	ArrayList<Member> list = memberDao.selecetMemberListByPage(beginRow, rowPerPage);
	int count = memberDao.selectMemberCount();
	int lastPage = count/rowPerPage;
	if(lastPage%rowPerPage != 0)
	{
		lastPage= lastPage+1;
	}
	
	
	//View
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<ul>
		<li><a href="<%=request.getContextPath()%>/admin/noticeList.jsp">공지관리</a></li>
		<li><a href="<%=request.getContextPath()%>/admin/categoryList.jsp">카테고리관리</a></li>
		<li><a href="<%=request.getContextPath()%>/admin/memberList.jsp">멤버관리(목록,레벨수정,강제탈퇴)</a></li>
		<li><a href="<%=request.getContextPath()%>/cash/cashList.jsp">돌아가기</a></li>
	</ul>
	<div>
		<!-- memberList contents-->
		<h1>멤버 목록</h1>
		<table>
			<tr>
				<th>멤버 번호</th>
				<th>아이디</th>
				<th>레벨</th>
				<th>이름</th>
				<th>마지막 수정일자</th>
				<th>생성일자</th>
				
				<th>레벨 수정</th>
				<th>강제 탈퇴</th>
			</tr>
			
		<% 		
			for(Member m : list)
			{
		%>
				<tr>
					<td><%=m.getMemberNo() %></td>
					<td><%=m.getMemberId() %></td>
					<td><%=m.getMemberLevel() %></td>
					<td><%=m.getMemberName() %></td>
					<td><%=m.getUpdatedate() %></td>
					<td><%=m.getCreatedate() %></td>
					
					<td>
						<form action="<%=request.getContextPath()%>/admin/updateMemberAction.jsp" method="post">
							<input type="hidden" name="memberId" value="<%=m.getMemberId()%>">
							<select name="memberLevel">
								<option value="0">0</option>
								<option value="1">1</option>
							</select>
						<button type="submit">레벨 수정</button>
						</form>
					</td>
					
					<td><a href="<%=request.getContextPath()%>/admin/deleteMemberAction.jsp?memberId=<%=m.getMemberId()%>">강제 탈퇴</a></td>
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
					<a href="<%=request.getContextPath()%>/admin/memberList.jsp?currentPage=<%=firstPage%>">처음으로</a>
					<a href="<%=request.getContextPath()%>/admin/memberList.jsp?currentPage=<%=currentPage-1%>">이전</a>
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
					<a href="<%=request.getContextPath()%>/admin/memberList.jsp?currentPage=<%=currentPage+1%>">다음</a>
					<a href="<%=request.getContextPath()%>/admin/memberList.jsp?currentPage=<%=lastPage%>">마지막으로</a>
			<%		
				}
			%>
		</div>
	</div>
	
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