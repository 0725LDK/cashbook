<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>

<%
	request.setCharacterEncoding("UTF-8");
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