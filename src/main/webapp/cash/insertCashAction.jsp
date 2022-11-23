<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.net.URLEncoder"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>

<%
	request.setCharacterEncoding("utf-8");
	String msg = null;
	
	
	int year = Integer.parseInt(request.getParameter("year"));
	int month = Integer.parseInt(request.getParameter("month"));
	int date = Integer.parseInt(request.getParameter("date"));
	
	Cash cash = new Cash();
	
	//빈칸방지
	if(request.getParameter("cashMemo")==null || request.getParameter("cashMemo").equals("")
		|| request.getParameter("cashPrice")==null || request.getParameter("cashPrice").equals(""))
	{
		String msg1 = URLEncoder.encode("경고 !","utf-8");
		msg = URLEncoder.encode("항목을 입력하세요","utf-8");
		response.sendRedirect(request.getContextPath()+"/cash/cashDateList.jsp?year="+year+"&month="+month+"&date="+date+"&msg="+msg+"&msg1="+msg1);
		return;
	}
	// 값들이 넘어 왔을때 Cash 수정
	else 
	{ 
		cash.setMemberId(request.getParameter("memberId"));
		cash.setCategoryNo(Integer.parseInt(request.getParameter("categoryNo")));
		cash.setCashDate(request.getParameter("cashDate"));
		cash.setCashPrice(Long.parseLong(request.getParameter("cashPrice")));
		cash.setCashMemo(request.getParameter("cashMemo"));
	}
	
	//모델 호출
	CashDao cashDao = new CashDao();
	
	if(cashDao.insertCash(cash)==1)
	{
		msg = URLEncoder.encode("가계부 등록 성공","utf-8");
		response.sendRedirect(request.getContextPath()+"/cash/cashDateList.jsp?year="+year+"&month="+month+"&date="+date+"&msg="+msg);
		return;
	}
	else
	{
		System.out.println("insertCashAction 실패");
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