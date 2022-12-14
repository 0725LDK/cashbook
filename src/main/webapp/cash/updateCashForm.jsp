<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.util.*"%>
<%@ page import = "java.sql.*"%>
<%@ page import = "dao.*" %>
<%@ page import = "vo.*" %>
<%

	//세션정보
	if(session.getAttribute("loginMember") == null){
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	
	//수입 지출 내용
	CategoryDao categoryDao = new CategoryDao();
	ArrayList<Category> categoryList = categoryDao.selectCategoryList();
	
	Member loginMember = (Member)session.getAttribute("loginMember");
	String loginMemberId = loginMember.getMemberId();
	
	//값 설정
	int year = Integer.parseInt(request.getParameter("year"));
	int month = Integer.parseInt(request.getParameter("month"));
	int date = Integer.parseInt(request.getParameter("date"));
	//int cashNo = Integer.parseInt(request.getParameter("cashNo"));
	
	System.out.println(request.getParameter("cashNo"));
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width,initial-scale=1">
    <title>Update Cash </title>
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
				<div class="authincation h-100">
			        <div class="container-fluid h-100">
			            <div class="row justify-content-center h-100 align-items-center">
			                <div class="col-md-6">
			                    <div class="authincation-content">
			                        <div class="row no-gutters">
			                            <div class="col-xl-12">
			                                <div class="auth-form">
											<h4 class="text-center mb-4">가계부 정보 수정</h4>
											<%
												if(request.getParameter("msg") != null)
												{
											%>
													<span style="color:red">경고! </span>
													<span><%=request.getParameter("msg") %></span>
											<% 
												}
											%>
											<form id="updateCashForm" action="<%=request.getContextPath()%>/cash/updateCashAction.jsp" method="post">
												<input type="hidden" name="memberId" value="<%=loginMemberId%>">
												<input type="hidden" name="year" value="<%=year%>"> 
												<input type="hidden" name="month" value="<%=month%>"> 
												<input type="hidden" name="date" value="<%=date%>"> 
												<div class="form-group">
													<label><strong>수입/지출 + 내용</strong></label>
													<select name="categoryNo" class="form-control">
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
												</div>
												
												<div class="form-group">
													<label><strong>날짜</strong></label>
													<input type="text" name="cashDate" class="form-control" value="<%=year%>-<%=month%>-<%=date%>" readonly="readonly">
												</div>
														
												<div class="form-group">
													<label><strong>금액</strong></label>
													<input id="cashPrice" type="text" name="cashPrice" class="form-control">
												</div>
													
												<div class="form-group">
													<label><strong>메모</strong></label>
													<textarea id="cashMemo" rows="3" cols="50" name="cashMemo" class="form-control"></textarea>
												</div>
												<div class="text-center">
													<button id="updateCashBtn" type="button" class="btn btn-primary btn-block">수정하기</button>
												</div>
											</form>
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
        Main wrapper end
    ***********************************-->
	</div>
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
		let updateCashBtn = document.querySelector('#updateCashBtn');
		updateCashBtn.addEventListener('click', function()
											{
												//가격 유효성 검사
												let cashPrice = document.querySelector('#cashPrice');
												if(cashPrice.value == '')
												{
													alert('가격을 입력하세요')	;
													cashPrice.focus();
													return;
												}
												
			
												//내용 유효성 검사
												let cashMemo = document.querySelector('#cashMemo');
												if(cashMemo.value == '')
												{
													alert('내용을 입력하세요')	;
													cashMemo.focus();
													return;
												}
												
												let updateCashForm = document.querySelector('#updateCashForm');
												updateCashForm.submit();
												
											});
	
	</script>
	
</body>
</html>