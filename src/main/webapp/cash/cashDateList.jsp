<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.util.*"%>
<%@ page import = "dao.*" %>
<%@ page import = "vo.*" %>
<%
	//세션정보
	if(session.getAttribute("loginMember") == null){
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	
	//Map 매개변수
	Member loginMember = (Member)session.getAttribute("loginMember");
	String loginMemberId = loginMember.getMemberId();
	//연월일 받기
	int year = Integer.parseInt(request.getParameter("year"));
	int month = Integer.parseInt(request.getParameter("month"));
	int date = Integer.parseInt(request.getParameter("date"));
	
	CategoryDao CategoryDao = new CategoryDao();
	ArrayList<Category> categoryList = CategoryDao.selectCategoryList();
	
	CashDao cashDao = new CashDao(); 
	ArrayList<HashMap<String, Object>> list = cashDao.selectCashListByMonth(loginMemberId, year, month);
	
	
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width,initial-scale=1">
    <title>cashDateList </title>
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
        <div class="header">
            <div class="header-content">
                <nav class="navbar navbar-expand">
                    <div class="collapse navbar-collapse justify-content-between">
                      
                    </div>
                </nav>
            </div>
        </div>
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
				                    <li><a class="has-arrow" href="javascript:void()" aria-expanded="false"><i
				                                class="icon icon-single-04"></i><span class="nav-text">My Page</span></a>
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
				                       	<td colspan="7">
				                       		<span class="fontThisDate"><%=year %>년 <%=month %>월 <%=date %>일 상세내역</span><br>
				                       	</td>
	 				                </tr>
		
									<tr>
										<th>수입/지출</th>
										<th>내용</th>
										<th>금액</th>
										<th>메모</th>
										<th>수정일자</th>
										<th>생성일자</th>
										<th>수정[&#9997;] / 삭제[&#10060;]</th>
									</tr>
									
									<%
										//해당일의 가계부 목록 출력
										for(HashMap<String, Object> m : list)
										{
											String cashDate = (String)(m.get("cashDate"));
											if(Integer.parseInt(cashDate.substring(0, 4)) == year && Integer.parseInt(cashDate.substring(5, 7)) == month && Integer.parseInt(cashDate.substring(8)) == date)
											{
												System.out.println((Integer)(m.get("cashNo")));
									%>
												<tr>
													<td><%=(String)m.get("categoryKind")%>&nbsp;</td>
													<td><%=(String)m.get("categoryName")%>&nbsp;</td>
													<td><%=(Long)m.get("cashPrice")%>원&nbsp;</td>
													<td><%=(String)m.get("cashMemo")%>&nbsp;</td>
													<td><%=(String)m.get("updateDate")%>&nbsp;</td>
													<td><%=(String)m.get("createDate")%>&nbsp;</td>
													<td>
														<a href="<%=request.getContextPath()%>/cash/updateCashForm.jsp?year=<%=year%>&month=<%=month%>&date=<%=date%>&cashNo=<%=m.get("cashNo")%>">&#9997;&nbsp;&nbsp;&nbsp;</a>
														<a href="<%=request.getContextPath()%>/cash/deleteCashAction.jsp?year=<%=year%>&month=<%=month%>&date=<%=date%>&cashNo=<%=m.get("cashNo")%>&memberId=<%=loginMemberId%>">&#10060;</a>
													</td>
												</tr>
									<%
											}
										}
									%>
									
									<tr>
										<td colspan="7" style="text-align: right;">
				                       		<span class="fontThisDateBack"><a href="<%=request.getContextPath()%>/cash/cashList.jsp">Go To Calendar...</a></span>
				                       	</td>
									</tr>
								</table>
                        	</div>
    					</div>
    				</div>
    			</div>
    		</div>
    		<div class="container-fluid">
				<div class="row">
                    <div class="col-xl-12 col-lg-8 col-md-8">
                        <div class="card">
                        	<div class="table-responsive">
								<!-- cash 입력폼 -->
								<form action="<%=request.getContextPath()%>/cash/insertCashAction.jsp" method="post">
									<input type="hidden" name="memberId" value="<%=loginMember.getMemberId()%>">
									<input type="hidden" name="year" value="<%=year%>">
									<input type="hidden" name="month" value="<%=month%>">
									<input type="hidden" name="date" value="<%=date%>">
									<table class="table mb-0">
										<tr>
				                       		<td colspan="2">
				                       			<span class="fontThisDate">가계부 입력</span><br>
				                       			<%
													if(request.getParameter("msg1") != null)
													{
												%>
														<span style="color:red"><%=request.getParameter("msg1") %></span>
														<span><%=request.getParameter("msg") %></span>
												<%	
													}
													else if(request.getParameter("msg1") == null && request.getParameter("msg") != null )
													{
												%>
														<span><%=request.getParameter("msg") %></span>
												<%		
													}
												%>
				                      	 	</td>
 				              			</tr>
										<tr>
											<td>지출 항목</td>
											<td><!-- 카테고리 넘버 출력 -->
												<select class="form-control" name="categoryNo">
													<%
														for(Category c : categoryList)
														{
													%>		
															<option value="<%=c.getCategoryNo()%>"><%=c.getCategoryKind() %> - <%=c.getCategoryName() %></option>
													<%		
															System.out.println(c.getCategoryNo() + "<==카테고리 넘버");
														}
													%>
												</select>
											</td>
										</tr>
							
										<tr>
											<td>날짜</td>
											<td style=" text-align: center;">
												<input class="form-control" class="form-control" type="text" name="cashDate" value="<%=year %>-<%=month %>-<%=date %>" readonly="readonly">
											</td>
										</tr>
										
										<tr>
											<td>금액</td>
											<td>
												<input class="form-control" type="text" name="cashPrice">
											</td>
										</tr>
							
										<tr>
											<td>내용</td>
											<td>
												<textarea class="form-control" rows="3" cols="50" name="cashMemo"></textarea>
											</td>
										</tr>
										
										<tr class="text-center">
				                       		<td colspan="7" >
				                       			<span class="fontThisDate">
													<button type="submit" class="btn btn-primary btn-block">입력하기!</button>
												</span>
				                      	 	</td>
 				              			</tr>
									</table>
								</form>
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
