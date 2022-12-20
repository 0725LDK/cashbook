<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.util.*"%>
<%@ page import = "dao.*" %>
<%@ page import = "vo.*" %>
<%
	// Controller : seesion, request
	request.setCharacterEncoding("utf-8");
	if(session.getAttribute("loginMember")==null)
	{
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	} 
	 // session에 저장된 멤버(현재 로그인)
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember != null && loginMember.getMemberLevel()==1)
	{
		response.sendRedirect(request.getContextPath()+"/admin/adminMain.jsp");
		return;
	} 
	
	// request 년 + 월
	int year = 0;
	int summaryYear = 0;
	int month = 0;
	Calendar today = Calendar.getInstance(); // 오늘날짜
	//연도&월별 요약용 변수 및 설정
	if(request.getParameter("summaryYear") == null)
	{
		summaryYear = today.get(Calendar.YEAR);
	}
	else
	{
		summaryYear = Integer.parseInt(request.getParameter("summaryYear"));
	}
	//날짜 없이 넘어 올 경우
	if((request.getParameter("year") == null) || request.getParameter("month") == null) 
	{
		year = today.get(Calendar.YEAR);
		month = today.get(Calendar.MONTH);
	} 
	else 
	{
		year = Integer.parseInt(request.getParameter("year"));
		month = Integer.parseInt(request.getParameter("month"));
		// month -> -1, month -> 12 일경우
		if(month == -1) 
		{
			month = 11;
			year -= 1;
		}
		if(month == 12) 
		{
			month = 0;
			year += 1;
		}
	}
	
	// 출력하고자 하는 년,월과 월의 1일의 요일(일 1, 월 2, 화 3, ... 토 7)
	Calendar targetDate = Calendar.getInstance();
	targetDate.set(Calendar.YEAR, year);
	targetDate.set(Calendar.MONTH, month);
	targetDate.set(Calendar.DATE, 1);
	// firstDay는 1일의 요일
	int firstDay = targetDate.get(Calendar.DAY_OF_WEEK); // 요일(일 1, 월 2, 화 3, ... 토 7)
	// begin blank개수는 firstDay - 1
	
	// 마지막날짜
	int lastDate = targetDate.getActualMaximum(Calendar.DATE); // 
	
	// 달력 출력테이블의 시작 공백셀(td)과 마지막 공백셀(td)의 개수
	int beginBlank = firstDay - 1;
	int endBlank = 0; // beginBlank + lastDate + endBlank --> 7로 나누어 떨어진다 --> totalTd
	if((beginBlank + lastDate) % 7 != 0) {
		endBlank = 7 - ((beginBlank + lastDate) % 7);
	}
	
	// 전체 td의 개수 : 7로 나누어 떨어져야 한다
	int totalTd = beginBlank + lastDate + endBlank;
	
	
	// Model 호출 : 일별 cash 목록
	CashDao cashDao = new CashDao();
	ArrayList<HashMap<String, Object>> list = cashDao.selectCashListByMonth(loginMember.getMemberId(),year ,month+1);
	
	// View : 달력출력 + 일별 cash 목록 출력
	
	System.out.println(loginMember.getMemberLevel()+"<== 캐쉬리스트 멤버 레벨");
	
	//연도별 요약 출력
	ArrayList<HashMap<String, Object>> yearSummary = cashDao.selectYearCashSummary(loginMember.getMemberId(),summaryYear ,month+1);
	//연도에 따른 월별 요약 출력
	ArrayList<HashMap<String, Object>> monthSummary = cashDao.selectMonthCashSummary(loginMember.getMemberId(),summaryYear);

	//페이징
	HashMap<String,Object> mapYear = cashDao.cashSummaryYearCount();
	int minYear = (Integer)(mapYear.get("minYear"));
	int maxYear = (Integer)(mapYear.get("maxYear"));
	
	System.out.println(minYear+"<==최소연도");
	System.out.println(maxYear+"<==최고연도");
%>


<!DOCTYPE html>
<html>

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width,initial-scale=1">
    <title>cashList </title>
    <!-- Favicon icon -->
    <link rel="icon" type="image/png" sizes="16x16" href="<%=request.getContextPath() %>/resource/images/favicon.png">
    <link rel="stylesheet" href="<%=request.getContextPath() %>/resource/vendor/owl-carousel/css/owl.carousel.min.css">
    <link rel="stylesheet" href="<%=request.getContextPath() %>/resource/vendor/owl-carousel/css/owl.theme.default.min.css">
    <link href="<%=request.getContextPath() %>/resource/vendor/jqvmap/css/jqvmap.min.css" rel="stylesheet">
    <link href="<%=request.getContextPath() %>/resource/css/style.css" rel="stylesheet">
    <link href="<%=request.getContextPath() %>/resource/vendor/fullcalendar/css/fullcalendar.min.css" rel="stylesheet">
</head>

<body>

    <!--**********************************
        Main wrapper start
    ***********************************-->
    <div id="main-wrapper">

        <!--**********************************
            Nav header start
        ***********************************-->
        <div class="nav-header">
           	<div class="brand-logo">
				<!-- 로그인 정보(세션 loginMember 변수) 출력 -->
				<a href="<%=request.getContextPath()%>/cash/cashList.jsp">Hello!</a>&nbsp;&nbsp; <%=loginMember.getMemberName() %>&nbsp;&nbsp;&nbsp;
				<a href="<%=request.getContextPath()%>/logOut.jsp">LogOut</a>
			</div>
        </div>
        <!--**********************************
            Nav header end
        ***********************************-->

        <!--**********************************
            Header start
        ***********************************-->
	
		<jsp:include page="/inc/cashHeader.jsp"></jsp:include>
	
        <!--**********************************
            Header end ti-comment-alt
        ***********************************-->

        <!--**********************************
            Sidebar start
        ***********************************-->
          <div>
				<%
					if(loginMember.getMemberLevel()==0)
					{
				%>	
						<div class="quixnav">
				            <div class="quixnav-scroll">
				                <ul class="metismenu" id="menu">
				                    <li><a class="has-arrow" href="javascript:void()" aria-expanded="false"><i class="icon icon-single-04"></i><span class="nav-text">My Page</span></a>
				                        <ul aria-expanded="false">
				                            <li><a href="<%=request.getContextPath()%>/updateMemberForm.jsp?memberId=<%=loginMember.getMemberId()%>&memberName=<%=loginMember.getMemberName() %>">회원 정보 수정</a></li>
				                            <li><a href="<%=request.getContextPath()%>/help/helpList.jsp">고객센터</a></li>
				                            <li><a href="<%=request.getContextPath()%>/deleteMemberForm.jsp?memberId=<%=loginMember.getMemberId()%>">회원 탈퇴</a></li>
				                        </ul>
				                    </li>
				                </ul>
				            </div>
				        </div>
				<%
					}
					else if(loginMember.getMemberLevel()>0)
					{
				%>
						<div class="quixnav">
				            <div class="quixnav-scroll">
				                <ul class="metismenu" id="menu">
									<li><a class="has-arrow" href="javascript:void()" aria-expanded="false"><i
				                                class="icon icon-single-04"></i><span class="nav-text">Admin Page</span></a>
				                        <ul aria-expanded="false">
											<jsp:include page="/inc/head.jsp"></jsp:include>
				                        </ul>
				                    </li>
				                </ul>
				            </div>
				        </div>
				<% 
			        }
				%>
	       </div>
        <!--**********************************
            Sidebar end
        ***********************************-->

        <!--**********************************
            Content body start
        ***********************************-->
        <div class="content-body">
            <!-- row -->
			<div class="container-fluid">
				<div class="row">
                    <div class="col-xl-12 col-lg-8 col-md-8">
                        <div class="card">
							<div class="table-responsive">
								<table class="table mb-0">
									<tr>
										<td><a class="fontMoveDate" href="<%=request.getContextPath()%>/cash/cashList.jsp?year=<%=year%>&month=<%=month-1%>">&#8701;이전달</a></td>
										<td><span class="fontThisDate"><%=year%>년 <%=month+1%> 월</span></td>
										<td><a class="fontMoveDate" href="<%=request.getContextPath()%>/cash/cashList.jsp?year=<%=year%>&month=<%=month+1%>">다음달&#8702;</a></td>
									</tr>
								</table>
							</div>
							<br>
								
							<!-- 달력 -->
							<div class="table-responsive">
								<table class="table mb-0">
									<tr>
										<th>
											<span style="color:#FF5A5A">일</span>
										</th>
										<th>월</th>
										<th>화</th>
										<th>수</th>
										<th>목</th>
										<th>금</th>
										<th>
											<span style="color:#5AAEFF">토</span>
										</th>
									</tr>
									
									<tr>
										<%
											for(int i=1; i<=totalTd; i++) 
											{
										%>
												<td>
										<%
													int date = i-beginBlank;
													if(date > 0 && date <= lastDate) 
													{
										%>
														<div>
															<a href="<%=request.getContextPath()%>/cash/cashDateList.jsp?year=<%=year%>&month=<%=month+1%>&date=<%=date%>">
																
																<%
																	if(i%7==1)
																	{
																%>
																		<span style="color:#FF5A5A"><%=date%></span>
																<%
																	}
																	else if(i%7==0)
																	{
																%>
																		<span style="color:#5AAEFF"><%=date%></span>
																<%		
																	}
																	else
																	{
																%>
																		<%=date%>
																<%
																	}
																%>
															</a>
														</div>
														<div>
															<%
																for(HashMap<String, Object> m : list) 
																{
																	String cashDate = (String)(m.get("cashDate"));
																	if(Integer.parseInt(cashDate.substring(8)) == date) 
																	{
															%>
																		<%
																			if(m.get("categoryKind").equals("수입"))
																			{
																		%>
																				<span style="color:blue"><%=(String)(m.get("categoryKind"))%></span>
																		
																		<%
																			}
																			else if(m.get("categoryKind").equals("지출"))
																			{
																		%>		
																			
																				<span style="color:red"><%=(String)(m.get("categoryKind"))%></span>
																		<%	
																			}
																		%>
																		<%=(String)(m.get("categoryName"))%>
																		&nbsp;
																		<%=(Long)(m.get("cashPrice"))%>원
																		<br>
															<%
																	}
																}
															%>
														</div>
											<%				
														}
											%>
													</td>
											<%
													
													if(i%7 == 0 && i != totalTd) 
													{
											%>
														</tr><tr> <!-- td7개 만들고 테이블 줄바꿈 -->
											<%			
													}
												}
											%>
									</tr>
								</table>
							</div>
				        </div>
				    </div>
				</div>
           	</div>
           	
           	<!-- 연도별 내용 -->
           	<div class="container-fluid">
				<div class="row">
                    <div class="col-xl-12 col-lg-8 col-md-8">
                        <div class="card">
							<div class="table-responsive">
								<table class="table mb-0">
								 	<tr>
				                       	<td colspan="8">
				                       		<span class="fontThisDate" style="font-size:23px">연도별 수입/지출 요약</span><br>
				                       	</td>
	 				                </tr>
									<tr>
										<th>연도</th>
										<th>수입횟수</th>
										<th>수입합계</th>
										<th>수입평균</th>
										<th>지출횟수</th>
										<th>지출합계</th>
										<th>지출평균</th>
									</tr>
									<%
										for(HashMap<String,Object> map : yearSummary)
										{
									%>
											<tr>
												<td><%=(String)(map.get("year")) %> 년</td>
												<td><%=(String)(map.get("countImportCash")) %> 회</td>
												<td><%=(String)(map.get("sumImportCash")) %> 원</td>
												<td><%=(String)(map.get("avgImportCash")) %> 원</td>
												<td><%=(String)(map.get("countExportCash")) %> 회</td>
												<td><%=(String)(map.get("sumExportCash")) %> 원</td>
												<td><%=(String)(map.get("avgExportCash")) %> 원</td>
											</tr>
									<%
										}
									
									%>
								</table>
							</div>
						</div>
					</div>
				</div>
			</div>
			
			<!-- 월별내용 -->
			<div class="container-fluid">
				<div class="row">
                    <div class="col-xl-12 col-lg-8 col-md-8">
                        <div class="card">
							<div class="table-responsive">
								<table class="table mb-0">
									<tr>
										<td>
											<%
												if(summaryYear>minYear)
												{
											%>
													<a class="fontMoveDate" href="<%=request.getContextPath()%>/cash/cashList.jsp?summaryYear=<%=summaryYear-1%>&month=<%=month-1%>">&#8701;이전연도</a>
											
											<%
												}
												else if(summaryYear == minYear)
												{
											%>
													<span>&#8701;이전연도</span>
											<%
												}
											%>
										</td>
										<td>
											<span class="fontThisDate"><%=summaryYear %>년 월별 수입/지출 요약</span>
										</td>
										<td>
											<%
												if(summaryYear<maxYear)
												{
											%>
													<a class="fontMoveDate" href="<%=request.getContextPath()%>/cash/cashList.jsp?summaryYear=<%=summaryYear+1%>&month=<%=month+1%>">다음연도&#8702;</a>
											<%		
												}
												else if(summaryYear==maxYear)
												{
											%>
													<span>다음연도&#8702;</span>
											<%		
												}
											%>
										</td>
									</tr>
								</table>
							</div>
							
							<div class="table-responsive">
								<table class="table mb-0">
								 	<%-- <tr>
				                       	<td colspan="8">
				                       		<span class="fontThisDate" style="font-size:23px"><%=summaryYear %>년 월별 수입/지출 요약</span><br>
				                       	</td>
	 				                </tr> --%>
									<tr>
										<th>월</th>
										<th>수입횟수</th>
										<th>수입합계</th>
										<th>수입평균</th>
										<th>지출횟수</th>
										<th>지출합계</th>
										<th>지출평균</th>
									</tr>
									<%
										for(HashMap<String,Object> map2 : monthSummary)
										{	
									%>
											<tr>
												<td><%=(String)(map2.get("month")) %> 월</td>
												<td><%=(String)(map2.get("countImportCash")) %> 회</td>
												<td><%=(String)(map2.get("sumImportCash")) %> 원</td>
												<td><%=(String)(map2.get("avgImportCash")) %> 원</td>
												<td><%=(String)(map2.get("countExportCash")) %> 회</td>
												<td><%=(String)(map2.get("sumExportCash")) %> 원</td>
												<td><%=(String)(map2.get("avgExportCash")) %> 원</td>
											</tr>
									<%
										}
									
									%>
								</table>
							</div>
						</div>
					</div>
				</div>
			</div>
       	</div>
        <!--**********************************
            Content body end
        ***********************************-->
    </div>
    <!--**********************************
        Main wrapper end
    ***********************************-->
	
	<!--**********************************
	    Footer start
	***********************************-->
	<div class="footer">
	    <jsp:include page="/inc/cashFoot.jsp"></jsp:include>
	</div>
	<!--**********************************
	    Footer end
	***********************************-->


    <!--**********************************
        Scripts
    ***********************************-->
	<div>
		<jsp:include page="/inc/scripts.jsp"></jsp:include>
	</div>

</body>
</html>