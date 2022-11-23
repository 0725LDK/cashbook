<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.net.*" %>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>

<%
	request.setCharacterEncoding("utf-8");
	String msg = null;
	//빈칸 방지
	if(request.getParameter("memberId")==null ||request.getParameter("memberId").equals("") 
		||request.getParameter("memberPw")==null ||request.getParameter("memberPw").equals("")
		||request.getParameter("memberName")==null ||request.getParameter("memberName").equals(""))
	{
		msg = URLEncoder.encode("항목을 입력하세요.","utf-8");
		response.sendRedirect(request.getContextPath()+"/insertMemberForm.jsp?msg="+msg);
		return;
	}
	
	//pw중복확인
	if(request.getParameter("memberPw").equals(request.getParameter("chkPw"))==false)
	{
		msg = URLEncoder.encode("비밀번호가 맞지않습니다.","utf-8");
		response.sendRedirect(request.getContextPath()+"/insertMemberForm.jsp?msg="+msg);
		return;
	}
	//객체 생성하고 필드값 설정
	Member insertMember = new Member();
	insertMember.setMemberId(request.getParameter("memberId"));
	insertMember.setMemberPw(request.getParameter("memberPw"));
	insertMember.setMemberName(request.getParameter("memberName"));
	
	MemberDao MemberDao = new MemberDao();
	if(MemberDao.insertMember(insertMember) == 1)
	{
		msg = URLEncoder.encode("회원가입에 성공했습니다. 로그인 해주세요", "utf-8");
		String targetUrl = "/loginForm.jsp";
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