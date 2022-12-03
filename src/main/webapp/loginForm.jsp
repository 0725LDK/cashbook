<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%
	//로그인이 되어 있을때는 접근불가
	if(session.getAttribute("loginMember") != null)
	{
		response.sendRedirect(request.getContextPath()+"/cash/cashList.jsp");
		return;
	}

	//페이징을 위한 변수 설정
	int firstPage = 1;//1페이지 고정값
	int currentPage = 1;//현재페이지 반영값
	if(request.getParameter("currentPage")!=null)
	{
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	int rowPerPage = 5;//1페이지당 보여줄 갯수
	int beginRow = (currentPage-1)*rowPerPage; //페이지 시작 번호
	int count = 0; //총 행수
	
	//페이지에 보여줄 갯수&내용 받아오기
	NoticeDao noticeDao = new NoticeDao();
	ArrayList<Notice> list = noticeDao.selectNoticeListByPage(beginRow, rowPerPage);
	
	//마지막 페이지 구하기
	count = noticeDao.selectNoticeCount();//총 행수 받아오기
	int lastPage = count/rowPerPage;
	//rowPerPage로 나눠지지 않을때 마지막 장+1
	if(count%rowPerPage != 0)
	{
		lastPage = lastPage+1;
	}
	/* 디버깅 
		System.out.println(beginRow +"<===beginRow");
		System.out.println(rowPerPage+"<===rowPerPage");
		System.out.println(lastPage+"<===lastPage");
		System.out.println(count+"<===count"); 
	*/
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width,initial-scale=1">
    <title>Sign In </title>
    <!-- Favicon icon -->
    <link rel="icon" type="<%=request.getContextPath()%>/resource/image/png" sizes="16x16" href="<%=request.getContextPath()%>/resource/images/favicon.png">
    <link href="<%=request.getContextPath() %>/resource/css/style.css" rel="stylesheet">
</head>

<body class="h-100">
	<!-- 공지(5개)목록 페이징 -->
	<br><br><br>
	<div class="authincation h-100">
        <div class="container-fluid h-100">
            <div class="row justify-content-center h-100 align-items-center">
                <div class="col-md-6">
                    <div class="authincation-content">
                        <div class="row no-gutters">
                            <div class="col-xl-12">
                                <div class="auth-form">	
                                	<div class="container-fluid">
                                		<h4 class="text-center mb-4">Notice</h4>			
											<table id="example" class="table mb-0" style="min-width: 600px">
												<thead class="text-center mb-4">
													<tr>
														<th>공지내용</th>
														<th>날짜</th>
													</tr>
												</thead>
												<tbody class="text-center mb-4">
													<%
														for(Notice n : list)
														{
													%>		
															<tr>
																<td><%=n.getNoticeMemo() %></td>
																<td><%=n.getCreatedate() %></td>
															</tr>	
													<%	
														}
													%>
												</tbody>
												<tfoot class="text-center mb-4">
													<!-- 페이지 넘기기 버튼 -->
													<tr>
														<td colspan="2">
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
																		<a href="<%=request.getContextPath()%>/loginForm.jsp?currentPage=<%= firstPage%>">처음으로</a>
																		<a href="<%=request.getContextPath()%>/loginForm.jsp?currentPage=<%= currentPage-1%>">이전</a>
																<%
																	}
																%>
																
																<span>[ <%=currentPage %> ]</span>
																
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
																		<a href="<%=request.getContextPath()%>/loginForm.jsp?currentPage=<%= currentPage+1%>">다음</a>
																		<a href="<%=request.getContextPath()%>/loginForm.jsp?currentPage=<%= lastPage%>">마지막으로</a>
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
			</div>
		</div>
	</div>
	<br><br><br>
	
	<!-- 로그인 폼 -->
	<div class="authincation h-100">
        <div class="container-fluid h-100">
            <div class="row justify-content-center h-100 align-items-center">
                <div class="col-md-6">
                    <div class="authincation-content">
                        <div class="row no-gutters">
                            <div class="col-xl-12">
                                <div class="auth-form">
                                    <h4 class="text-center mb-4">Sign in</h4>
									<form action="<%=request.getContextPath()%>/loginAction.jsp" method="post">
										
										<div class="form-group">
											<label><strong>ID</strong></label>
											<input name="memberId" type="text" class="form-control" placeholder="Insert Your ID">
										</div>
										<div class="form-group">
											<label><strong>Password</strong></label>
											<input type="password" name="memberPw" class="form-control" placeholder="Password">
										</div>
										<div class="text-center">
											<button type="submit" class="btn btn-primary btn-block">Sign In!</button>
										</div>
									</form>
									<div class="new-account mt-3">
										<p>Don't have an account?&nbsp;<a class="text-primary" href="<%=request.getContextPath()%>/insertMemberForm.jsp">Sign Up!</a></p>
									</div>
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