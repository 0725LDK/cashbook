<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.util.*"%>
<%@ page import = "java.net.*"%>
<%@ page import = "dao.*" %>
<%@ page import = "vo.*" %>
<%
	//Controller
	Member loginMember = (Member)session.getAttribute("loginMember");
	System.out.println(loginMember +"<=== adminMain loginMember 넘어오는 값");
	
	//로그인이 안되어 있을때 or 일반 사용자는 접근불가
	if(loginMember == null || loginMember.getMemberLevel()<1)
	{
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	} 
	
	//Model

	//최근공지 5개 최근멤버 5명
	
	//View
	
	// request 년 + 월
	int year = 0;
	int month = 0;
	
	//날짜 없이 넘어 올 경우
	if((request.getParameter("year") == null) || request.getParameter("month") == null) 
	{
		Calendar today = Calendar.getInstance(); // 오늘날짜
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
	ArrayList<HashMap<String, Object>> list = cashDao.selectCashListByMonth(loginMember.getMemberId(), year, month+1);
	
	// View : 달력출력 + 일별 cash 목록 출력
	
	System.out.println(loginMember.getMemberLevel()+"<== 캐쉬리스트 멤버 레벨");
	
	//카테고리 요약
	CategoryDao categoryDao = new CategoryDao();
	ArrayList<Category> categoryList = categoryDao.selectCategoryListByAdmin();
	
	//고객센터 요약
	int beginRow = 0;
	int rowPerPage = 10;
	HelpDao helpDao  = new HelpDao();
	ArrayList<HashMap<String, Object>> helpList = helpDao.selectHelpList(beginRow, rowPerPage); //리스트출력
	
	//멤버 요약
	MemberDao memberDao = new MemberDao();
	ArrayList<Member> MemberList = memberDao.selecetMemberListByPage(beginRow, rowPerPage);
	
	//공지사항 요약
	NoticeDao noticeDao = new NoticeDao();
	ArrayList<Notice> noticeList = noticeDao.selectNoticeListByPage(beginRow, rowPerPage);
%>



<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width,initial-scale=1">
    <title>adminMain </title>
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
				Hello! <%=loginMember.getMemberName() %>&nbsp;&nbsp;&nbsp;
				<a href="<%=request.getContextPath()%>/logOut.jsp">LogOut</a>
				
			</div>
			
        </div>
        <!--**********************************
            Nav header end
        ***********************************-->
		
		<!--**********************************
            Header start
        ***********************************-->
        <jsp:include page="/inc/adminHeader.jsp"></jsp:include>
        <!--**********************************
            Header end ti-comment-alt
        ***********************************-->
        
        <!--**********************************
            Sidebar start
        ***********************************-->
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
                
                	<!-- 카테고리 요약 -->
                    <div class="col-lg-3 col-sm-6">
                        <div class="card">
                            <div class="stat-widget-two card-body">
                                <div class="stat-content">
									<table class="table mb-0">
										<tr>
											<td colspan="5">
												<h4 class="text-center mb-4 fontThisDate">
													<a href="<%=request.getContextPath()%>/admin/categoryList.jsp">
														<span style="color:#2924BD;">가계부 카테고리 목록</span>
													</a>
												</h4>
											</td>
										</tr>
										<tr>
											<th>번호</th>
											<th>수입/지출</th>
											<th>이름</th>
											<th>마지막 수정 날짜</th>
											<th>생성 날짜</th>
										</tr>
										<!-- 모델데이터 categoryList -->
										<%
											for(Category c : categoryList)
											{
										%>
												<tr>
													<td><%=c.getCategoryNo() %></td>
													<td><%=c.getCategoryKind() %></td>
													<td><%=c.getCategoryName() %></td>
													<td><%=c.getUpdatedate() %></td>
													<td><%=c.getCreatedate() %></td>
												</tr>
										<%
											}
										
										%>
									</table>
                                </div>
							</div>
						</div>
					</div>
					
					<!-- 고객센터 요약 -->
					<div class="col-lg-3 col-sm-6">
                        <div class="card">
                            <div class="stat-widget-two card-body">
                                <div class="stat-content">
                                   <table class="table mb-0">
									
										<tr>
											<td colspan="3">
												<h4 class="text-center mb-4 fontThisDate">
													<a href="<%=request.getContextPath()%>/admin/helpListAll.jsp">
														<span style="color:#2924BD;">고객센터 문의 목록</span>
													</a>
												</h4>
											</td>
										</tr>
										<tr>
											<th><span style="font-size:15px">문의내용</span></th>
											<th><span style="font-size:15px">회원ID</span></th>
											<th><span style="font-size:15px">문의날짜</span></th>
										</tr>
									
								
										<%
											for(HashMap<String, Object> m : helpList)
											{
										%>
												<tr>
													<td><%=m.get("helpMemo") %></td>
													<td><%=m.get("memberId") %></td>
													<td><%=m.get("helpCreatedate") %></td>
												</tr>
										<%
											}
										%>
									
									</table>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <!-- 멤버 요약 -->
					<div class="col-lg-3 col-sm-6">
                        <div class="card">
                            <div class="stat-widget-two card-body">
                                <div class="stat-content">
                                   <table class="table mb-0">
										<tr>
											<td colspan="4">
												<h5 class="text-center fontThisDate">
													<a href="<%=request.getContextPath()%>/admin/memberList.jsp">
														<span style="color:#2924BD;">멤버 목록</span>
													</a>
												</h5><br>
											</td>
										</tr>
										
										<tr>
											<th>멤버 번호</th>
											<th>아이디</th>
											<th>레벨</th>
											<th>이름</th>
											
										</tr>
										
										<% 		
											for(Member m : MemberList)
											{
										%>
												<tr>
													<td><%=m.getMemberNo() %></td>
													<td><%=m.getMemberId() %></td>
													<td><%=m.getMemberLevel() %></td>
													<td><%=m.getMemberName() %></td>
										<%
											}
										%>
										
									</table>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <!-- 공지사항 요약 -->
					<div class="col-lg-3 col-sm-6">
                        <div class="card">
                            <div class="stat-widget-two card-body">
                                <div class="stat-content">
                                   <table class="table mb-0">
										<tr>
	                       					<td colspan="2">
	                       						<h4 class="text-center mb-4 fontThisDate">
	                       							<a href="<%=request.getContextPath()%>/admin/noticeList.jsp">
	                       								<span style="color:#2924BD;">공지 목록</span>
	                       							</a>
	                       						</h4>
	                       					</td>
	                       				</tr>
										<tr>
											<th>공지내용</th>
											<th>공지날짜</th>
											
										</tr>
										
										<%
											for(Notice n : noticeList)
											{
												String noticeMemo = URLEncoder.encode(n.getNoticeMemo(),"utf-8");//한글로된 noticeMemo 넘기기 위해
										%>
												<tr>
													<td><%=n.getNoticeMemo() %></td>
													<td><%=n.getCreatedate() %></td>
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