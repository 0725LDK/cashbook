<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.net.*" %>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>

<%
	//로그인이 되어 있을때는 접근불가
	if(session.getAttribute("loginMember") != null)
	{
		response.sendRedirect(request.getContextPath()+"/cash/cashList.jsp");
		return;
	}
	
	//Controller
	request.setCharacterEncoding("utf-8");
	String memberId = request.getParameter("memberId");
	String memberPw = request.getParameter("memberPw");
	String memberName = request.getParameter("memberName");

	Member member = new Member();
	member.setMemberId(memberId);
	member.setMemberPw(memberPw);
	member.setMemberName(memberName);
	
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
	
	//Model 호출
	//아이디 중복 체크
	String targetUrl = "/insertMemberForm.jsp";
	MemberDao memberDao = new MemberDao();
	if(memberDao.selectMemberIdCk(memberId))
	{
		msg = URLEncoder.encode("아이디가 중복되었습니다.", "utf-8");
		response.sendRedirect(request.getContextPath()+targetUrl + "?msg="+msg);
		return;
	}
	
	//회원가입
	int row = memberDao.insertMember(member);
	System.out.println(row + "<---insertMemberAction.jsp row");
	targetUrl = "/loginForm.jsp";
	msg = URLEncoder.encode("회원가입에 성공했습니다. 로그인하세요.", "utf-8");
	response.sendRedirect(request.getContextPath()+targetUrl + "?msg="+msg);

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