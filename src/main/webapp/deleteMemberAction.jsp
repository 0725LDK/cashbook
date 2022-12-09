<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<%@ page import="java.net.*" %>

<%
	//로그인이 안되어 있을때는 접근불가
	if(session.getAttribute("loginMember") == null)
	{
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	request.setCharacterEncoding("utf-8");
	String msg = null;
	
	//로그인이 안되어 있을때는 접근불가
	if(session.getAttribute("loginMember") == null)
	{
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	
	String memberId = request.getParameter("memberId");
	String memberPw = request.getParameter("memberPw");
	
	Member member = new Member();
	member.setMemberId(memberId);
	member.setMemberPw(memberPw);
	
	MemberDao memberDao = new MemberDao();
	int row = memberDao.deleteMember(memberId, memberPw);
	if(row == 0 || memberPw == null)
	{
		System.out.println(row+"<===deleteMemberAction 실패");
		msg = URLEncoder.encode("비밀번호를 확인하세요","utf-8");
		response.sendRedirect(request.getContextPath()+"/deleteMemberForm.jsp?msg="+msg+"&memberId="+member.getMemberId());
		return;
	}
	msg = URLEncoder.encode("탈퇴 성공","utf-8");
	System.out.println(row+"<===deleteMemberAction 성공");
	session.invalidate();
	response.sendRedirect(request.getContextPath()+"/loginForm.jsp?msg="+msg);
	
	//response.sendRedirect(request.getContextPath()+"/logOut.jsp");
	


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