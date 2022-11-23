<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%	
	//세션 종료 후 로그인 페이지로 넘김
	session.invalidate();
	response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
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