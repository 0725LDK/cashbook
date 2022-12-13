<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "dao.*" %>
<%@ page import = "vo.*" %>
<%
	//session에 저장된 멤버(현재 로그인)
	Member loginMember = (Member)session.getAttribute("loginMember");
%>

<div class="header">
	<div class="header-content">
		<a href="<%=request.getContextPath()%>/cash/cashList.jsp">
			<span style="color:#2924BD;">[메인 페이지] &nbsp;&nbsp;</span>
		</a> 
		<a href="<%=request.getContextPath()%>/updateMemberForm.jsp?memberId=<%=loginMember.getMemberId()%>&memberName=<%=loginMember.getMemberName() %>">
			<span style="color:#2924BD;">[회원정보 수정] &nbsp;&nbsp;</span> 
		</a> 
		<a href="<%=request.getContextPath()%>/help/helpList.jsp">
			<span style="color:#2924BD;">[고객센터] &nbsp;&nbsp;</span>
		</a> 
		<a href="<%=request.getContextPath()%>/deleteMemberForm.jsp?memberId=<%=loginMember.getMemberId()%>">
			<span style="color:#2924BD;">[회원 탈퇴] &nbsp;&nbsp;</span>
		</a>
	</div>
</div>
<span>
	<%
		if(request.getParameter("msg") != null)
		{
	%>
			<span><%=request.getParameter("msg") %></span>
	<%	
		}
	%>
</span>