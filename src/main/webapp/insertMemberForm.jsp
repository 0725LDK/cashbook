<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	//로그인이 되어 있을때는 접근불가
	if(session.getAttribute("loginMember") != null)
	{
		response.sendRedirect(request.getContextPath()+"/cash/cashList.jsp");
		return;
	}
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width,initial-scale=1">
    <title>Focus - Bootstrap Admin Dashboard </title>
    <!-- Favicon icon -->
    <link rel="icon" type="<%=request.getContextPath()%>/resource/image/png" sizes="16x16" href="<%=request.getContextPath()%>/resource/images/favicon.png">
    <link href="<%=request.getContextPath() %>/resource/css/style.css" rel="stylesheet">
</head>
<body class="h-100">
	<div class="authincation h-100">
	        <div class="container-fluid h-100">
	            <div class="row justify-content-center h-100 align-items-center">
	                <div class="col-md-6">
	                    <div class="authincation-content">
	                        <div class="row no-gutters">
	                            <div class="col-xl-12">
	                                <div class="auth-form">
	                                    <h4 class="text-center mb-4">Sign in</h4>
										<h1>회원가입 페이지</h1>
										<form action="<%=request.getContextPath()%>/insertMemberAction.jsp" method="post">
											<div class="form-group">
												<label><strong>ID</strong></label>
												<input name="memberId" type="text" class="form-control" placeholder="Insert New ID">
											</div>
											<div class="form-group">
												<label><strong>Password</strong></label>
												<input type="password" name="memberPw" class="form-control" placeholder="Password">
											</div> 
											<div class="form-group">
												<label><strong>Check Password</strong></label>
												<input type="password" name="chkPw" class="form-control" placeholder="Check Password">
											</div> 
											<div class="form-group">
												<label><strong>User Name</strong></label>	
												<input type="text" name="memberName" class="form-control" placeholder="User Name">
											</div>
											<div class="text-center">
												<button type="submit" class="btn btn-primary btn-block">Sign Up!</button>
											</div>
										</form><br>
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
	</body>
</html>