<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%@ page import="java.net.*" %>

<%
	request.setCharacterEncoding("UTF-8");
	//빈칸 방지
	String msg = null;
	if(request.getParameter("memberId")==null || request.getParameter("memberId").equals("")
		|| request.getParameter("memberPw")==null || request.getParameter("memberPw").equals(""))
	{
		msg = URLEncoder.encode("항목을 입력하세요.","utf-8");
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp?msg="+msg);
		return;
	}
	//C
	Member paramMember = new Member();//모델 호출시 매개값
	paramMember.setMemberId(request.getParameter("memberId"));
	paramMember.setMemberPw(request.getParameter("memberPw"));
	
	//분리된 M(모델)을 호출
	
	MemberDao memberDao = new MemberDao();
	Member resultMember = memberDao.login(paramMember);
	
	String redirectUrl = "/loginForm.jsp";
	
	if(resultMember != null)
	{
		session.setAttribute("loginMember", resultMember); //세션안에 로그인  아이디 & 이름을 저장
		redirectUrl = "/cash/cashList.jsp";
	}
	
	//redirect
	response.sendRedirect(request.getContextPath()+redirectUrl);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>loginAction</title>
</head>
<body>

</body>
</html>