package dao;

import vo.Member;
import java.sql.*;
import java.util.*;

import util.DBUtil;

public class MemberDao 
{	//로그인
	public Member login(Member paramMember) throws Exception
	{
		Member	resultMember = null;
		
		/*String driver = "org.mariadb.jdbc.Driver";
		String dbUrl = "jdbc:mariadb://localhost:3306/cashbook";
		String dbUser = "root";
		String dbPw = "java1234";
		
		Class.forName(driver); // 외부 드라이브 로딩
		Connection conn = DriverManager.getConnection(dbUrl, dbUser, dbPw); // db 연결
		*/ //DB를 연결하는 코드(명령들)가 Dao 메소드 거의 공통으로 중복된다.
		//	중복되는 코드를 하나의 이름(메서드)으로 만들자
		//	입력값과 반환값 결정해야 한다.
		//  입력값X 반환값은 Connection 타입 결과값이 나와야한다.
		DBUtil dbUtil = new DBUtil(); //DBUtil 클래스의 객체 dbUtil 만들고
		Connection conn = dbUtil.getConnection();//객체 dbUtil의 getConnection 메소드를 호출해서 Connection conn에 저장
		
		String sql = "SELECT member_id memberId, member_level memberLevel, member_name memberName FROM member WHERE member_id =? AND member_pw =PASSWORD(?)";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, paramMember.getMemberId());
		stmt.setString(2, paramMember.getMemberPw());
		ResultSet rs = stmt.executeQuery();
		
		if(rs.next())
		{
			resultMember = new Member();
			resultMember.setMemberId(rs.getString("memberId"));
			resultMember.setMemberName(rs.getString("memberName"));
			resultMember.setMemberLevel(rs.getInt("memberLevel"));
		}
		
		rs.close();
		stmt.close();
		conn.close();
		return resultMember;
	}
	
	//회원가입 
	//1) 아이디 중복 체크
	//반환값의 의미를 적자  t: 이미 존재  f: 사용가능
	public boolean selectMemberIdCk(String memberId) throws Exception
	{
		boolean result = false;
		
		DBUtil dbUtil = new DBUtil(); //DBUtil 클래스의 객체 dbUtil 만들고
		Connection conn = dbUtil.getConnection();//객체 dbUtil의 getConnection 메소드를 호출해서 Connection conn에 저장
		String sql = "SELECT member_id FROM member WHERE member_id=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, memberId);
		ResultSet rs = stmt.executeQuery();
		
		if(rs.next())
		{
			result = true;
		}
		dbUtil.close(rs, stmt, conn);
		return result;
	}
	
	//2)회원가입
	public int insertMember(Member paramMember) throws Exception
	{
		int resultRow = 0;
		
		/*String driver = "org.mariadb.jdbc.Driver";
		String dbUrl = "jdbc:mariadb://localhost:3306/cashbook";
		String dbUser = "root";
		String dbPw = "java1234";
		
		Class.forName(driver); // 외부 드라이브 로딩
		Connection conn = DriverManager.getConnection(dbUrl, dbUser, dbPw); // db 연결
		*/
		DBUtil dbUtil = new DBUtil(); //DBUtil 클래스의 객체 dbUtil 만들고
		Connection conn = dbUtil.getConnection();//객체 dbUtil의 getConnection 메소드를 호출해서 Connection conn에 저장
		
		String sql = "INSERT INTO member(member_id, member_pw, member_name, updatedate, createdate) VALUES ( ?,PASSWORD(?),?,now(),now())";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, paramMember.getMemberId());
		stmt.setString(2, paramMember.getMemberPw());
		stmt.setString(3, paramMember.getMemberName());
		int row = stmt.executeUpdate();
		if(row ==1)
		{
			System.out.println("회원가입 성공");
			resultRow = 1;
		}
		else
		{
			System.out.println("회원가입 실패");	
		}
		
		dbUtil.close(null, stmt, conn);
		
		return resultRow;
	}
	
	//회원정보 수정
	public int updateMember(Member paramMember) throws Exception
	{
		int resultRow = 0;
		
		/*String driver = "org.mariadb.jdbc.Driver";
		String dbUrl = "jdbc:mariadb://localhost:3306/cashbook";
		String dbUser = "root";
		String dbPw = "java1234";
		
		Class.forName(driver); // 외부 드라이브 로딩
		Connection conn = DriverManager.getConnection(dbUrl, dbUser, dbPw); // db 연결
		*/
		DBUtil dbUtil = new DBUtil(); //DBUtil 클래스의 객체 dbUtil 만들고
		Connection conn = dbUtil.getConnection();//객체 dbUtil의 getConnection 메소드를 호출해서 Connection conn에 저장
		
		String sql = "UPDATE MEMBER SET member_name = ? WHERE member_id= ? AND member_pw = PASSWORD(?);";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, paramMember.getMemberName());
		stmt.setString(2, paramMember.getMemberId());
		stmt.setString(3, paramMember.getMemberPw());
		int row = stmt.executeUpdate();
		if(row ==1)
		{
			System.out.println("회원정보 수정 성공");
			stmt.close();
			conn.close();
			resultRow = 1;
			return resultRow;
		}
		System.out.println("회원정보 수정 실패");
		stmt.close();
		conn.close();
		
		return resultRow;
	}
	
	//회원탈퇴
	public int deleteMember(String memberId, String memberPw) throws Exception
	{
		int resultRow = 0;
		
		DBUtil dbUtil = new DBUtil(); //DBUtil 클래스의 객체 dbUtil 만들고
		Connection conn = dbUtil.getConnection();//객체 dbUtil의 getConnection 메소드를 호출해서 Connection conn에 저장
		
		String sql = "DELETE FROM MEMBER WHERE member_id=? AND member_pw=PASSWORD(?)";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, memberId);
		stmt.setString(2, memberPw);
		int row = stmt.executeUpdate();
		if(row==1)
		{
			System.out.println("회원 삭세 성공");
			resultRow = 1;
		}
		dbUtil.close(null, stmt, conn);
		return resultRow;
	}
		
}
