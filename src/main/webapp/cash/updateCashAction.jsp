<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.net.URLEncoder"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>

<%
	//로그인이 안되어 있을때는 접근불가
	if(session.getAttribute("loginMember") == null)
	{
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	request.setCharacterEncoding("utf-8");
	
	String msg = null;
	//값 설정
	int year = Integer.parseInt(request.getParameter("year"));
	int month = Integer.parseInt(request.getParameter("month"));
	int date = Integer.parseInt(request.getParameter("date"));
	int cashNo = Integer.parseInt(request.getParameter("cashNo"));
	
	//빈칸방지
	if(request.getParameter("categoryNo")==null || request.getParameter("categoryNo").equals("")
		|| request.getParameter("cashPrice")==null || request.getParameter("cashPrice").equals("")
		|| request.getParameter("cashMemo")==null || request.getParameter("cashMemo").equals(""))
	{
		msg = URLEncoder.encode("항목을 입력하세요","utf-8");
		response.sendRedirect(request.getContextPath()+"/cash/updateCashForm.jsp?year="+year+"&month="+month+"&date="+date+"&msg="+msg);
		return;
	}
	
	//객체 생성하고 필드값 설정
	Cash cash = new Cash();
	cash.setCategoryNo(Integer.parseInt(request.getParameter("categoryNo")));
	cash.setCashPrice(Long.parseLong(request.getParameter("cashPrice")));
	cash.setCashMemo(request.getParameter("cashMemo"));
	cash.setCashNo(Integer.parseInt(request.getParameter("cashNo")));
	
	
	CashDao cashDao = new CashDao();
	cashDao.updateCash(cash);
	if(cashDao.updateCash(cash)==1)
	{
		msg = URLEncoder.encode("가계부 수정 성공","utf-8");
		response.sendRedirect(request.getContextPath()+"/cash/cashDateList.jsp?year="+year+"&month="+month+"&date="+date+"&msg="+msg);
		return;
	}
	else if((cashDao.updateCash(cash)!=1))
	{
		System.out.println("수정 실패");
		response.sendRedirect(request.getContextPath()+"/cash/updateCashForm.jsp?year="+year+"&month="+month+"&date="+date+"&msg="+msg+"&cashNo="+cashNo);
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
