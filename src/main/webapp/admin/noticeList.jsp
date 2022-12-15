<%@page import="java.net.URLEncoder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%@ page import="java.util.*" %>
<%
	//Controller
	request.setCharacterEncoding("utf-8");
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null || loginMember.getMemberLevel()<1)
	{
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	
	//Model : notice list
	int firstPage = 1; //1페이지 고정값
	int currentPage = 1; //현재페이지 반영값
	if(request.getParameter("currentPage")!=null)
	{
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	
	int rowPerPage =10;
	int beginRow = (currentPage-1)*rowPerPage;
	NoticeDao noticeDao = new NoticeDao();
	ArrayList<Notice> list = noticeDao.selectNoticeListByPage(beginRow, rowPerPage);
	int noticeCount = noticeDao.selectNoticeCount();
	System.out.println(noticeCount+"<---notiCnt");
	int lastPage = noticeCount / rowPerPage;
	if(noticeCount%rowPerPage!=0)
	{
		lastPage = lastPage +1;
	}
	
	
	//View
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width,initial-scale=1">
    <title>NoticeList </title>
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
				<a href="<%=request.getContextPath()%>/admin/adminMain.jsp">Hello!</a>&nbsp;&nbsp; <%=loginMember.getMemberName() %>&nbsp;&nbsp;&nbsp;
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
                       					<td colspan="4">
                       						<h4 class="text-center mb-4 fontThisDate">공지 목록</h4>
                       					</td>
                       				</tr>
									<tr>
										<th>공지내용</th>
										<th>공지날짜</th>
										<th>수정</th>
										<th>삭제</th>
									</tr>
									
									<%
										for(Notice n : list)
										{
											String noticeMemo = URLEncoder.encode(n.getNoticeMemo(),"utf-8");//한글로된 noticeMemo 넘기기 위해
									%>
											<tr>
												<td><%=n.getNoticeMemo() %></td>
												<td><%=n.getCreatedate() %></td>
												<td><a href="<%=request.getContextPath()%>/admin/updateNoticeForm.jsp?noticeNo=<%=n.getNoticeNo()%>&noticeMemo=<%=noticeMemo%>">&#9997;</a></td><!-- 수정 이모지 -->
												<td><a href="<%=request.getContextPath()%>/admin/deleteNotice.jsp?noticeNo=<%=n.getNoticeNo()%>">&#10060;</a></td><!-- 삭제이모지 -->
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
			<div class="container-fluid">
               <div class="row">
                    <div class="col-xl-12 col-lg-8 col-md-8">
                        <div class="card">
                        	<div class="table-responsive">
                        		<form id="insertNoticeForm" action="<%=request.getContextPath()%>/admin/insertNoticeAction.jsp">
                        			<table class="table mb-0">
                        				<tr>
                        					<td colspan="2">
                        						<h4 class="text-center mb-4 fontThisDate">공지 등록</h4>
                        					</td>
                        				</tr>
                        				
                        				<tr>
                        					<td>공지 내용</td>
                        					<td><input id="noticeMemo" type="text" class="form-control" name="noticeMemo"></td>
                        				</tr>
                        				<tr>
                        					<td colspan="2"><button id="insertNoticeBtn" type="button" class="btn btn-primary btn-block">공지 입력</button></td>
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

	<!-- 스크립트 추가 -->
	<script>
		let insertNoticeBtn = document.querySelector('#insertNoticeBtn');
		insertNoticeBtn.addEventListener('click',function()
											{
												let noticeMemo = document.querySelector('#noticeMemo');
												if(noticeMemo.value == '')
												{
													alert('공지사항을 입력하세요');
													noticeMemo.focus();
													return;
												}
												
												let insertNoticeForm = document.querySelector('#insertNoticeForm');
												insertNoticeForm.submit();
											});
	</script>

</body>
</html>