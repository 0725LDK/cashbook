<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "dao.*" %>
<%@ page import = "vo.*" %>
<%
	//session에 저장된 멤버(현재 로그인)
	Member loginMember = (Member)session.getAttribute("loginMember");
%>
<div class="header">
	<div class="header-content">
		<a href="<%=request.getContextPath()%>/admin/adminMain.jsp">
			<span style="color:#2924BD;">[메인 페이지] &nbsp;&nbsp;</span> 
		</a> 
		<a href="<%=request.getContextPath()%>/admin/categoryList.jsp">
			<span style="color:#2924BD;">[카테고리 관리] &nbsp;&nbsp;</span>
		</a> 
		<a href="<%=request.getContextPath()%>/admin/helpListAll.jsp">
			<span style="color:#2924BD;">[고객센터 관리] &nbsp;&nbsp;</span>
		</a>
		<a href="<%=request.getContextPath()%>/admin/memberList.jsp">
			<span style="color:#2924BD;">[멤버 관리] &nbsp;&nbsp;</span>
		</a>
		<a href="<%=request.getContextPath()%>/admin/noticeList.jsp">
			<span style="color:#2924BD;">[공지 관리] &nbsp;&nbsp;</span>
		</a>
	</div>
</div>