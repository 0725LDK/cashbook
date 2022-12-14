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
    <title>Sigh Up </title>
    <!-- Favicon icon -->
    <link rel="icon" type="<%=request.getContextPath()%>/resource/image/png" sizes="16x16" href="<%=request.getContextPath()%>/resource/images/favicon.png">
    <link href="<%=request.getContextPath() %>/resource/css/style.css" rel="stylesheet">
</head>
<body class="h-100">
	<div class="authincation h-100">
        <div class="container-fluid h-100">
            <div class="row justify-content-center h-100 align-items-center">
                <div class="col-md-6"><br><br><br>
                    <div class="authincation-content">
                        <div class="row no-gutters">
                            <div class="col-xl-12">
                                <div class="auth-form">
                                    <h4 class="text-center mb-4">Sign Up</h4>
									<form id="insertMemberForm" action="<%=request.getContextPath()%>/insertMemberAction.jsp" method="post">
										<div class="form-group">
											<label><strong>ID</strong></label>
											<input id="memberId" name="memberId" type="text" class="form-control" placeholder="Insert New ID">
										</div>
										<div class="form-group">
											<label><strong>Password</strong></label>
											<input id="memberPw" type="password" name="memberPw" class="form-control" placeholder="Password">
										</div> 
										<div class="form-group">
											<label><strong>Check Password</strong></label>
											<input id="chkPw" type="password" name="chkPw" class="form-control" placeholder="Check Password">
										</div> 
										<div class="form-group">
											<label><strong>User Name</strong></label>	
											<input id="memberName" type="text" name="memberName" class="form-control" placeholder="User Name">
										</div>
										<div class="text-center">
											<button id="insertMemberBtn" type="button" class="btn btn-primary btn-block">Sign Up!</button>
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
    
    <!-- 스크립트 추가 -->
    <script>
    	let insertMemberBtn = document.querySelector('#insertMemberBtn');
    	insertMemberBtn.addEventListener('click',function()
    												{
    													
											    		//ID 유효성 검사
														let memberId = document.querySelector('#memberId');
														if(memberId.value == '')
														{
															alert('ID를 입력하세요');
															memberId.focus();
															return;
														}
    		
    													//Pw 유효성 검사
														let memberPw = document.querySelector('#memberPw');
														let chkPw = document.querySelector('#chkPw');
														if(memberPw.value == '' || chkPw.value == '' || memberPw.value != chkPw.value)
														{
															alert('비밀번호를 확인하세요');
															memberPw.focus();
															return;
														}
    		
    													//Name 유효성 검사
    													let memberName = document.querySelector('#memberName');
    													if(memberName.value == '')
    													{
    														alert('이름을 입력하세요');
    														memberName.focus();
    														return;
    													}
    												
    													let insertMemeberForm = document.querySelector('#insertMemberForm');
    													insertMemeberForm.submit();
    												});
    
    
    </script>
    
</body>
</html>