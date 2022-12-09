<%@page import="java.net.URLEncoder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>

<%
	//Controller
	//로그인이 안되어 있을때 or 일반 사용자는 접근불가
	Member loginMember = (Member)session.getAttribute("loginMember");
	System.out.println(loginMember +"<=== adminMain loginMember 넘어오는 값");
	if(loginMember == null || loginMember.getMemberLevel()<1)
	{
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	} 
	
	//페이징 변수
	int firstPage = 1;
	int currentPage = 1;
	if(request.getParameter("currentPage") != null)
	{
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	
	int rowPerPage = 10;
	int beginRow = (currentPage-1) * rowPerPage;
	int count = 0; //총행수
	int lastPage = 0;
	
	HelpDao helpDao  = new HelpDao();
	ArrayList<HashMap<String, Object>> list = helpDao.selectHelpList(beginRow, rowPerPage); //리스트출력
	
	//String commentMemo = URLEncoder.encode(m.get("commentMemo"),"utf-8");
	
	count = helpDao.helpCount();
	lastPage = count / rowPerPage;
	
	if(count%rowPerPage != 0)
	{
		lastPage = lastPage+1;
	}
	

%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width,initial-scale=1">
    <title>helpListAll</title>
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
								<li><a class="has-arrow" href="javascript:void()" aria-expanded="false"><i class="icon icon-single-04"></i><span class="nav-text">Admin Page</span></a>
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
									<thead class="text-center mb-4">
										<tr>
											<td colspan="6">
												<span class="fontThisDate">고객센터 문의 목록</span>
											</td>
										</tr>
										<tr>
											<th><span style="font-size:15px">문의내용</span></th>
											<th><span style="font-size:15px">회원ID</span></th>
											<th><span style="font-size:15px">문의날짜</span></th>
											<th><span style="font-size:15px">답변내용</span></th>
											<th><span style="font-size:15px">답변날짜</span></th>
											<th>
												<span style="font-size:15px">답변입력[&#10133;] / 수정[&#9997;] / 삭제[&#10060;]</span>
											</th>
										</tr>
									</thead>
									<tbody class="text-center mb-4">
										<%
											for(HashMap<String, Object> m :list)
											{
										%>
												<tr>
													<input type="hidden" name="commentNo" value="<%=m.get("commentNo")%>">
													<td><%=m.get("helpMemo") %></td>
													<td><%=m.get("memberId") %></td>
													<td><%=m.get("helpCreatedate") %></td>
													
													<td>
														<%
															if(m.get("commentMemo") == null)
															{
														%>
																<span>.....답변 대기중.....</span>
														<%
															}
															else
															{
														%>
																<%=m.get("commentMemo")%>
														<%
															}
														%>
													</td>
													<td>
														<%
															if(m.get("commentCreatedate") == null)
															{
														%>
																<span>.....답변 대기중.....</span>
														<%
															}
															else
															{
														%>
																<%=m.get("commentCreatedate") %>
														<%
															}
														%>
													</td>
													
													<td>
														<%
															if(m.get("commentMemo") == null)
															{
														%>
																<a href="<%=request.getContextPath() %>/admin/insertCommentForm.jsp?helpNo=<%=m.get("helpNo")%>"> 
																	&#10133;<!-- 답변입력 이모지 -->
																</a>
														<% 
															}
															else
															{
														%>		
																<a href="<%=request.getContextPath() %>/admin/updateCommentForm.jsp?commentNo=<%=m.get("commentNo")%>&commentMemo=<%=m.get("commentMemo")%>">&#9997;&nbsp;&nbsp;</a><!-- 수정 이모지 -->	
																<a href="<%=request.getContextPath() %>/admin/deleteCommentAction.jsp?commentNo=<%=m.get("commentNo")%>">&nbsp;&nbsp;&#10060;</a><!-- 삭제이모지 -->
														<%	
															}
														
														%>
													
													</td>
													
												</tr>
										<%
											}
										%>
									</tbody>
									<tfoot class="text-center mb-4">
										<!-- 페이지 넘기기 버튼 -->
										<tr>
											<td colspan="6">
												<div>
													<%
														if(currentPage == 1)
														{
													%>
															<span>처음으로</span>		
															<span>이전</span>		
													<%		
														}
														else
														{
													%>
															<a href="<%=request.getContextPath()%>/admin/helpListAll.jsp?currentPage=<%=firstPage%>">처음으로</a>
															<a href="<%=request.getContextPath()%>/admin/helpListAll.jsp?currentPage=<%=currentPage-1%>">이전</a>
													<%
														}
													%>
													
													<span> [<%=currentPage %>  ] </span>
													
													<%
														if(currentPage == lastPage)
														{
													%>		
															<span>다음</span>		
															<span>마지막으로</span>		
													<%		
														}
														else
														{
													%>
															<a href="<%=request.getContextPath()%>/admin/helpListAll.jsp?currentPage=<%=currentPage+1%>">다음</a>
															<a href="<%=request.getContextPath()%>/admin/helpListAll.jsp?currentPage=<%=lastPage%>">마지막으로</a>
													<%		
														}
													%>
												</div>
											</td>
										</tr>
									</tfoot>
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