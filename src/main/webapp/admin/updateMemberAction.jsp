<%@page import="java.net.URLEncoder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<%
	
	//Controller
	//로그인이 안되어 있을때 or 일반 사용자는 접근불가
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null || loginMember.getMemberLevel()<1)
	{
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}


	request.setCharacterEncoding("utf-8");
	
	Member member = new Member();
	member.setMemberLevel(Integer.parseInt(request.getParameter("memberLevel")));
	member.setMemberId(request.getParameter("memberId"));
	
	MemberDao memberDao = new MemberDao();
	int row = memberDao.updateMemberLevel(member);
	String msg = null;
	if(row==1)
	{
		System.out.println(row + "<===updateMemberAction 성공");
		msg = URLEncoder.encode("회원 레벨 변경완료","utf-8");
	}
	else
	{
		System.out.println(row + "<===updateMemberAction 실패");
		
	}
	
	response.sendRedirect(request.getContextPath()+"/admin/memberList.jsp?msg="+msg);

%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

</body>
</html>