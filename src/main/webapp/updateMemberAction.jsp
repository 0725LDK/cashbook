<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.net.*" %>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>

<%
	request.setCharacterEncoding("utf-8");
	String msg = null;
	
	//값설정
	String memberId= request.getParameter("memberId");
	String memberName= request.getParameter("memberName");
	
	//빈칸방지
	if(request.getParameter("memberName")== null || request.getParameter("memberId").equals("")
		|| request.getParameter("memberPw")== null || request.getParameter("memberPw").equals(""))
	{
		msg = URLEncoder.encode("항목을 입력하세요.","utf-8");
		memberName = URLEncoder.encode(memberName,"utf-8");
		response.sendRedirect(request.getContextPath()+"/updateMemberForm.jsp?msg="+msg+"&memberId="+memberId+"&memberName="+memberName);
		return;
	}
	
	//객체생성하고 필드변경
	Member updateMember = new Member();
	updateMember.setMemberId(request.getParameter("memberId"));
	updateMember.setMemberPw(request.getParameter("memberPw"));
	updateMember.setMemberName(request.getParameter("newName"));
	
	
	MemberDao MemberDao = new MemberDao();
	Member loginMember = (Member)session.getAttribute("loginMember");
	
	//회원정보 수정 실패
	if(MemberDao.updateMember(updateMember) == 0)
	{
		msg = URLEncoder.encode("회원정보 수정에 실패했습니다.", "utf-8");
		String targetUrl = "/updateMemberForm.jsp";
		memberName = URLEncoder.encode(memberName,"utf-8");
		response.sendRedirect(request.getContextPath()+targetUrl + "?msg="+msg+"&memberId="+memberId+"&memberName="+memberName);
		return;
	}
	//회원정보 수정 성공
	else if((MemberDao.updateMember(updateMember) == 1))
	{
		msg = URLEncoder.encode("회원정보 수정에 성공했습니다.", "utf-8");
		String targetUrl = "/cash/cashList.jsp";
		loginMember.setMemberName(request.getParameter("newName"));
		response.sendRedirect(request.getContextPath()+targetUrl + "?msg="+msg);
		return;
	}
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