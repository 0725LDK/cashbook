<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>

<%


	/* request.setCharacterEncoding("utf-8");
	String driver = "org.mariadb.jdbc.Driver";
	String dbUrl = "jdbc:mariadb://localhost:3306/cashbook";
	String dbUser = "root";
	String dbPw = "java1234";
	
	Class.forName(driver); // 외부 드라이브 로딩
	Connection conn = DriverManager.getConnection(dbUrl, dbUser, dbPw); // db 연결
	
	String memberId = request.getParameter("memberId");
	String memberPw= request.getParameter("memberPw");
	
	String sql = "SELECT member_id memberId, member_pw memberPw FROM member WHERE member_id =? AND member_pw =PASSWORD(?)";
	PreparedStatement stmt = conn.prepareStatement(sql);
	stmt.setString(1, memberId);
	stmt.setString(2, memberPw);
	ResultSet rs = stmt.executeQuery();
	if(rs.next())
	{
		response.sendRedirect(request.getContextPath()+"/cash/cashList.jsp");
		System.out.println("성공");
	}
	else
	{
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		System.out.println("실패");
	} */
	
	
	//C
	Member paramMember = new Member();//모델 호출시 매개값
	
	
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