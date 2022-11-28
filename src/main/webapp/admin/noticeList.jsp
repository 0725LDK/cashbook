<%@page import="java.net.URLEncoder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%@ page import="java.util.*" %>
<%
	//Controller
	request.setCharacterEncoding("utf-8");
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null || loginMember.getMemberLevel()<1)
	{
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	
	//Model : notice list
	int firstPage = 1; //1페이지 고정값
	int currentPage = 1; //현재페이지 반영값
	if(request.getParameter("currentPage")!=null)
	{
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	
	int rowPerPage =10;
	int beginRow = (currentPage-1)*rowPerPage;
	NoticeDao noticeDao = new NoticeDao();
	ArrayList<Notice> list = noticeDao.selectNoticeListByPage(beginRow, rowPerPage);
	int noticeCount = noticeDao.selectNoticeCount();
	System.out.println(noticeCount+"<---notiCnt");
	int lastPage = noticeCount / rowPerPage;
	if(noticeCount%rowPerPage!=0)
	{
		lastPage = lastPage +1;
	}
	
	
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
	<ul>
		<li><a href="<%=request.getContextPath()%>/admin/noticeList.jsp">공지관리</a></li>
		<li><a href="<%=request.getContextPath()%>/admin/categoryList.jsp">카테고리관리</a></li>
		<li><a href="<%=request.getContextPath()%>/admin/memberList.jsp">멤버관리(목록,레벨수정,강제탈퇴)</a></li>
		<li><a href="<%=request.getContextPath()%>/cash/cashList.jsp">돌아가기</a></li>
	</ul>
	<div>
		<!-- noticeList contents-->
		<h1>공지</h1>
		<form action="<%=request.getContextPath()%>/admin/insertNoticeAction.jsp">
			<textarea rows="3" cols="30" name="noticeMemo"></textarea>
			<button type="submit">입력</button>		
		</form>
		<%
			if(request.getParameter("msg") != null)
			{
		%>
				<span><%=request.getParameter("msg") %></span>
		<%		
			}
		%>
		
		<table>
			<tr>
				<th>공지내용</th>
				<th>공지날짜</th>
				<th>수정</th>
				<th>삭제</th>
			</tr>
			
			<%
				for(Notice n : list)
				{
					String noticeMemo = URLEncoder.encode(n.getNoticeMemo(),"utf-8");//한글로된 noticeMemo 넘기기 위해
			%>
					<tr>
						<td><%=n.getNoticeMemo() %></td>
						<td><%=n.getCreatedate() %></td>
						<td><a href="<%=request.getContextPath()%>/admin/updateNoticeForm.jsp?noticeNo=<%=n.getNoticeNo()%>&noticeMemo=<%=noticeMemo%>">수정</a></td>
						<td><a href="<%=request.getContextPath()%>/admin/deleteNotice.jsp?noticeNo=<%=n.getNoticeNo()%>">삭제</a></td>
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
					<a href="<%=request.getContextPath()%>/admin/noticeList.jsp?currentPage=<%=firstPage%>">처음으로</a>
					<a href="<%=request.getContextPath()%>/admin/noticeList.jsp?currentPage=<%=currentPage-1%>">이전</a>
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
					<a href="<%=request.getContextPath()%>/admin/noticeList.jsp?currentPage=<%=currentPage+1%>">다음</a>
					<a href="<%=request.getContextPath()%>/admin/noticeList.jsp?currentPage=<%=lastPage%>">마지막으로</a>
			<%		
				}
			%>
		</div>
	</div>
</body>
</html>