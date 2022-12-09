<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%@ page import="java.util.*" %>
<%
	//Controller
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null || loginMember.getMemberLevel()<1)
	{
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	
	//Model
	
	int firstPage = 1;//1페이지 설정
	int currentPage = 1;// 현재 페이지
	if(request.getParameter("currentPage")!=null)
	{
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	int rowPerPage = 5;
	int beginRow = (currentPage-1)*rowPerPage;
	MemberDao memberDao = new MemberDao();
	ArrayList<Member> list = memberDao.selecetMemberListByPage(beginRow, rowPerPage);
	int count = memberDao.selectMemberCount();
	int lastPage = count/rowPerPage;
	System.out.println(lastPage+"<---라스트 페이지");
	if(count%rowPerPage != 0)
	{
		lastPage= lastPage+1;
	}
	
	
	//View
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width,initial-scale=1">
    <title>memberList </title>
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
        
        
        <div class="content-body">
			<!-- row -->
		    <div class="container-fluid">
		       <div class="row">
		            <div class="col-xl-12 col-lg-8 col-md-8">
		                <div class="card">
		                	<div class="table-responsive">
								<table class="table mb-0">
									<tr>
										<td colspan="8">
											<span class="fontThisDate">멤버 목록</span><br>
											<%
												if(request.getParameter("msg") != null)
												{
											%>
													<span><%=request.getParameter("msg") %></span>
											<%		
												}
											%>
										</td>
									</tr>
									
									<tr>
										<th>멤버 번호</th>
										<th>아이디</th>
										<th>레벨</th>
										<th>이름</th>
										<th>마지막 수정일자</th>
										<th>생성일자</th>
										
										<th>레벨 수정</th>
										<th>강제 탈퇴</th>
									</tr>
									
									<% 		
										for(Member m : list)
										{
									%>
											<tr>
												<td><%=m.getMemberNo() %></td>
												<td><%=m.getMemberId() %></td>
												<td><%=m.getMemberLevel() %></td>
												<td><%=m.getMemberName() %></td>
												<td><%=m.getUpdatedate() %></td>
												<td><%=m.getCreatedate() %></td>
												
												<td>
													<form action="<%=request.getContextPath()%>/admin/updateMemberAction.jsp" method="post">
														<input type="hidden" name="memberId" value="<%=m.getMemberId()%>">
														<select name="memberLevel" class="form-control">
															<option value="0">0</option>
															<option value="1">1</option>
														</select>
													<button type="submit" class="btn btn-primary btn-block">레벨 수정</button>
													</form>
												</td>
												
												<td><a href="<%=request.getContextPath()%>/admin/deleteMemberAction.jsp?memberId=<%=m.getMemberId()%>">&#10060;&#10060;&#10060;</a></td><!-- 탈퇴 x모양 이모지 -->
											</tr>
									<%
										}
									%>
									<tr>
										<td colspan="8">
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
													<a href="<%=request.getContextPath()%>/admin/memberList.jsp?currentPage=<%=firstPage%>">처음으로</a>
													<a href="<%=request.getContextPath()%>/admin/memberList.jsp?currentPage=<%=currentPage-1%>">이전</a>
											<%
												}
											%>
											
											<span> [ <%=currentPage %> ] </span>
											
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
													<a href="<%=request.getContextPath()%>/admin/memberList.jsp?currentPage=<%=currentPage+1%>">다음</a>
													<a href="<%=request.getContextPath()%>/admin/memberList.jsp?currentPage=<%=lastPage%>">마지막으로</a>
											<%		
												}
											%>
										
										</td>
									<tr>
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