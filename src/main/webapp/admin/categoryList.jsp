<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%@ page import="java.util.*" %>
<%
	//Controller
	//로그인이 안되어 있을때 or 일반 사용자는 접근불가
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null || loginMember.getMemberLevel()<1)
	{
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	
	//Model
	CategoryDao categoryDao = new CategoryDao();
	ArrayList<Category> categoryList = categoryDao.selectCategoryListByAdmin();
	
	//View
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width,initial-scale=1">
    <title>categoryList </title>
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
											<h4 class="text-center mb-4 fontThisDate">가계부 수입/지출 카테고리 목록</h4>
										</td>
									</tr>
									<tr>
										<th>번호</th>
										<th>수입/지출</th>
										<th>이름</th>
										<th>마지막 수정 날짜</th>
										<th>생성 날짜</th>
										<th>수정</th>
										<th>삭제</th>
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
												<td>
													<a href="<%=request.getContextPath()%>/admin/updateCategoryForm.jsp?categoryNo=<%=c.getCategoryNo()%>">&#9997;</a><!-- 수정 이모지 -->
												</td>
												<td>
													<a href="<%=request.getContextPath()%>/admin/deleteCategoryAction.jsp?categoryNo=<%=c.getCategoryNo()%>">&#10060;</a><!-- 삭제이모지 -->
												</td>
											</tr>
									<%
										}
									
									%>
									<tr>
										<td colspan="7" style="text-align: right;">
											<span class="fontThisDateBack">
												<a href="<%=request.getContextPath()%>/admin/insertCategoryForm.jsp">
													<span style="color:#4641D9;">&#10133; 카테고리 추가</span>
												</a>
											</span>
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
	            Content body start
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