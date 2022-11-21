<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="dao.*" %>
<%
	//controller : session, request
	//request 년 + 월
	int year = 0;
	int month = 0;
	
	//연과 월을 구하는 알고리즘
	if(request.getParameter("year") == null || request.getParameter("momth") == null)
	{
		Calendar today  = Calendar.getInstance(); //오늘 날짜
		year = today.get(Calendar.YEAR);
		month = today.get(Calendar.MONTH); //월 -1 이됨  0은 1월  11은 12월 
	}
	else
	{
		year = Integer.parseInt(request.getParameter("year"));
		month = Integer.parseInt(request.getParameter("month"));
		//month -> -1 , month ->12일 경우
		if(month == -1)
		{
			month = 11;
			year -= 1;
		}
		if(month == 12)
		{
			month = 0;
			year +=1;
		}
	}
	
	//출력하고자 하는 연, 월의 1일 요일(일요일 1 월요일 2 화요일 3 ... 토요일 7)
	Calendar targetDate = Calendar.getInstance();	
	targetDate.set(Calendar.YEAR, year);
	targetDate.set(Calendar.MONTH, month);
	targetDate.set(Calendar.DATE, 1);
	//firstDay는 1일의 요일
	int firstDay = targetDate.get(Calendar.DAY_OF_WEEK);//요일
	//마지막 날짜
	int lastDate = targetDate.getActualMaximum(Calendar.DATE);
	
	//begin blank는 firstDay -1
	int beginBlank = firstDay - 1;
	int endBlank = 0;// beginBlank+lastDate+endBlank 7로 나누어 떨어진다
	if(beginBlank + lastDate % 7 != 0)
	{
		endBlank = 7 - (beginBlank + lastDate % 7);
	}
	
	//전체 td의 갯수 : 7로 나누어 떨어져야한다.
	int totalTd = beginBlank + lastDate + endBlank;
	
	//model 호출 : 일별 cash 목록
	CashDao cashDao = new CashDao();
	ArrayList<HashMap<String, Object>> list = cashDao.selectCashListByMonth(year, month+1);

	//view : 달력 출력 + 일별 cash 목록

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>cashList</title>
</head>
<body>
	<div>
		<!-- 로그인 정보(세션 loginMember 변수) 출력 -->
		<h1>마이 페이지</h1>
	</div>
	
	<div>
		<%=year%>년 &nbsp;<%=month+1%> 월
	</div>
	
	<div>
		<table border="1">
			<tr>
				<th>일</th>
				<th>월</th>
				<th>화</th>
				<th>수</th>
				<th>목</th>
				<th>금</th>
				<th>토</th>
			</tr>
			<%
				for(int i=1; i<=totalTd; i++)
				{
			%>		
					<td>
						<%
							int date = i-beginBlank; 
							if(date>0 && date<=lastDate)
							{
						%>
								<%=date%>
						<%
							}
						
						%>
					</td>				
			<%	
					if(i%7==0 && i!= totalTd)
					{
					%>
						<tr></tr><!-- td7개 만들고 테이블 줄바꿈 -->
					<%
					}
				}
			%>
		</table>
	</div>
	
	<div>
		<%
			for(HashMap<String, Object> m : list)
			{
		%>		
				<!-- 과제 -->
				<%=(Integer)(m.get("cashNo")) %>	
		<%		
			}
		%>
	</div>
</body>
</html>