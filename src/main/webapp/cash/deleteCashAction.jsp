<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.net.*" %>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>

<%
	request.setCharacterEncoding("utf-8");

	Member loginMember = (Member)session.getAttribute("loginMember");
	String msg = null;
	
	//값 설정
	int year = Integer.parseInt(request.getParameter("year"));
	int month = Integer.parseInt(request.getParameter("month"));
	int date = Integer.parseInt(request.getParameter("date"));
	int cashNo = Integer.parseInt(request.getParameter("cashNo"));
	
	//객체 이용 메소드 필드 값설정
	Cash cash = new Cash();
	CashDao cashDao = new CashDao();
	cash.setMemberId(request.getParameter("memberId"));
	cash.setCashNo(Integer.parseInt(request.getParameter("cashNo")));
	int row = cashDao.deleteCash(cash);
	
	if(row==1)
	{
		System.out.println("deleteAction 성공");
		msg=URLEncoder.encode("가계부 삭제 성공","utf-8");
		response.sendRedirect(request.getContextPath()+"/cash/cashDateList.jsp?year="+year+"&month="+month+"&date="+date+"&msg="+msg);
	}
	else
	{
		System.out.println("deleteAction 실패");
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