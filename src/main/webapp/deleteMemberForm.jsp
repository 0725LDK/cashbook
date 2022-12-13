<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.util.*"%>
<%@ page import = "dao.*" %>
<%@ page import = "vo.*" %>
<%
	//로그인이 안되어 있을때는 접근불가
	if(session.getAttribute("loginMember") == null)
	{
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	//session에 저장된 멤버(현재 로그인)
	Member loginMember = (Member)session.getAttribute("loginMember");
	
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width,initial-scale=1">
    <title>Delete Member </title>
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
											
										if(request.getParameter("msg") != null)
										{
									%>
											<span><%=request.getParameter("msg") %></span>
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
		<!-- 로그인 폼 -->
		<div class="content-body">
			<!-- row -->
			<div class="container-fluid">
				<div class="authincation h-100">
			        <div class="container-fluid h-100">
			            <div class="row justify-content-center h-100 align-items-center">
			                <div class="col-md-6">
			                    <div class="authincation-content">
			                        <div class="row no-gutters">
			                            <div class="col-xl-12">
			                                <div class="auth-form">
			                                    <h4 class="text-center mb-4">회원 탈퇴</h4>
												<form action="<%=request.getContextPath()%>/deleteMemberAction.jsp" method="post">
													
													<div class="form-group">
														<label><strong>ID</strong></label>
														<input name="memberId" type="text" class="form-control"  value="<%=request.getParameter("memberId")%>" readonly="readonly">
													</div>
													<div class="form-group">
														<label><strong>비밀번호 확인 </strong></label>
														<input type="password" name="memberPw" class="form-control" >
													</div>
													<div class="text-center">
														<button type="submit" class="btn btn-primary btn-block">탈퇴하기</button>
													</div>
												</form>
												<br>
												<div>
													<%
														if(request.getParameter("msg") != null)
														{
													%>
															<span style="color:red"><%=request.getParameter("msg") %></span>
													<%	
														}
													
													%>
				                         		</div>
			                                </div>
			                            </div>
			                        </div>
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