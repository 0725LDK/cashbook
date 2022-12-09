<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%@ page import="java.util.*" %>
<%
	request.setCharacterEncoding("utf-8");
	// session에 저장된 멤버(현재 로그인)
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(session.getAttribute("loginMember") == null)
	{
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	
	String memberId = loginMember.getMemberId();
	
	HelpDao helpDao = new HelpDao();
	ArrayList<HashMap<String, Object>> list  = helpDao.selectHelpList(memberId);
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width,initial-scale=1">
    <title>helpList </title>
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
        <div class="quixnav">
            <div class="quixnav-scroll">
                <ul class="metismenu" id="menu">
                    <li><a class="has-arrow" href="javascript:void()" aria-expanded="false"><i class="icon icon-single-04"></i><span class="nav-text">My Page</span></a>
                        <ul aria-expanded="false">
                            <li><a href="<%=request.getContextPath()%>/updateMemberForm.jsp?memberId=<%=loginMember.getMemberId()%>&memberName=<%=loginMember.getMemberName() %>">회원 정보 수정</a></li>
                            <li><a href="<%=request.getContextPath()%>/help/helpList.jsp">고객센터</a></li>
                            <li><a href="<%=request.getContextPath()%>/deleteMemberForm.jsp?memberId=<%=loginMember.getMemberId()%>">회원 탈퇴</a></li>
                            <li>
                           		<!-- 관리자 로그인시 관리자 페이지 생성 -->
								<div>
									<%
										if(loginMember.getMemberLevel()>0)
										{
									%>
											<a href="<%=request.getContextPath()%>/admin/adminMain.jsp?loginMember=<%=loginMember%>">관리자 페이지</a>
									<%
										}
									%>
								</div>
                            </li>
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
					<div class="col-xl-12 col-lg-8 col-md-8">
		                <div class="card">
		                	<div class="table-responsive">
								<table class="table mb-0">
									<tr>
			                       		<td colspan="6">
			                       			<span class="fontThisDate">나의 문의사항</span>
			                      	 	</td>
				              		</tr>
									
									<tr>
										<th>문의내용</th>
										<th>문의날짜</th>
										<th>답변내용</th>
										<th>답변날짜</th>
										<th>수정</th>
										<th>삭제</th>
									</tr>	
										
										<%
											for(HashMap<String, Object> m : list)
											{
										%>
												<input type="hidden" name="helpNo" value="<%=m.get("helpNo")%>">
												<tr>
													<td><%=m.get("helpMemo") %></td>
													<td><%=m.get("helpCreatedate") %></td>
													
													<td>
														<%
															if(m.get("commentMemo") ==null)
															{
														%>
																답변전
														<%
															}
															else
															{
														%>
																<%=m.get("commentMemo") %>
														<%
															}
														
														%>
													</td>
													
													<td>
														<%
															if(m.get("commentCreatedate") == null)
															{
														%>
																답변전
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
																<a href="<%=request.getContextPath()%>/help/updateHelpForm.jsp?helpNo=<%=m.get("helpNo")%>&helpMemo=<%=m.get("helpMemo")%>">&#9997;</a><!-- 수정 이모지 -->
														<%
															}
															else
															{
														%>
																&nbsp;
														<%
															}
														%>
													</td>
													<td>
														<%
															if(m.get("commentMemo") == null)
															{
														%>
																<a href="<%=request.getContextPath()%>/help/deleteHelpAction.jsp?helpNo=<%=m.get("helpNo")%>">&#10060;</a><!-- 삭제이모지 -->
														<%
															}
															else
															{
														%>
																&nbsp;
														<%
															}
														%>
													</td>
												</tr>
											<%		
												}
											
											%>
									<tr>
										<td colspan="5">
											<span></span>
										</td>
										<td>
											<a style="color:#4641D9; font-weight:bold" href="<%=request.getContextPath()%>/help/insertHelpForm.jsp"> &#10133;문의하기</a>
										</td>
									</tr>
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