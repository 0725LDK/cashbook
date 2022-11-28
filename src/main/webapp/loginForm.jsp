<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%
	//로그인이 되어 있을때는 접근불가
	if(session.getAttribute("loginMember") != null)
	{
		response.sendRedirect(request.getContextPath()+"/cash/cashList.jsp");
		return;
	}

	//페이징을 위한 변수 설정
	int firstPage = 1;//1페이지 고정값
	int currentPage = 1;//현재페이지 반영값
	if(request.getParameter("currentPage")!=null)
	{
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	int rowPerPage = 5;//1페이지당 보여줄 갯수
	int beginRow = (currentPage-1)*rowPerPage; //페이지 시작 번호
	int count = 0; //총 행수
	
	//페이지에 보여줄 갯수&내용 받아오기
	NoticeDao noticeDao = new NoticeDao();
	ArrayList<Notice> list = noticeDao.selectNoticeListByPage(beginRow, rowPerPage);
	
	//마지막 페이지 구하기
	count = noticeDao.selectNoticeCount();//총 행수 받아오기
	int lastPage = count/rowPerPage;
	//rowPerPage로 나눠지지 않을때 마지막 장+1
	if(count%rowPerPage != 0)
	{
		lastPage = lastPage+1;
	}
	/* 디버깅 
		System.out.println(beginRow +"<===beginRow");
		System.out.println(rowPerPage+"<===rowPerPage");
		System.out.println(lastPage+"<===lastPage");
		System.out.println(count+"<===count"); 
	*/
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>loginForm</title>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css" rel="stylesheet">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
	<!-- 공지(5개)목록 페이징 -->
	<table>
		<tr>
			<td>공지내용</td>
			<td>날짜</td>
		</tr>
		
		<%
			for(Notice n : list)
			{
		%>		
				<tr>
					<td><%=n.getNoticeMemo() %></td>
					<td><%=n.getCreatedate() %></td>
				</tr>	
		<%	
			}
		%>
	</table>
	
	<!-- 페이지 넘기기 버튼 -->
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
				<a href="<%=request.getContextPath()%>/loginForm.jsp?currentPage=<%= firstPage%>">처음으로</a>
				<a href="<%=request.getContextPath()%>/loginForm.jsp?currentPage=<%= currentPage-1%>">이전</a>
		<%
			}
		%>
		
		<span>[ <%=currentPage %> ]</span>
		
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
				<a href="<%=request.getContextPath()%>/loginForm.jsp?currentPage=<%= currentPage+1%>">다음</a>
				<a href="<%=request.getContextPath()%>/loginForm.jsp?currentPage=<%= lastPage%>">마지막으로</a>
		<%
			}
		%>
	</div>
	
	<!-- 로그인 폼 -->
	<form action="<%=request.getContextPath()%>/loginAction.jsp" method="post">
		<h1>로그인</h1>
		<table>
			<tr>
				<td>ID:</td>
				<td><input type="text" name="memberId"></td>
			</tr>
			<tr>
				<td>PW:</td>
				<td><input type="password" name="memberPw"></td>
			</tr>
		</table>
		<button type="submit">로그인</button>
	</form>
	<div>
		<a href="<%=request.getContextPath()%>/insertMemberForm.jsp">회원가입</a>
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