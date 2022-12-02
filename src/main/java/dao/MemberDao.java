package dao;

import vo.Member;
import java.sql.*;
import java.util.*;

import javax.naming.spi.DirStateFactory.Result;

import util.DBUtil;

public class MemberDao 
{	
	//관리자 : 멤버 레벨수정
	public int updateMemberLevel(Member member) 
	{
		int resultRow = 0;
		int row = 0;
		DBUtil dbUtil = new DBUtil();
		Connection conn = null;
		PreparedStatement stmt = null;
		try
		{
			String sql = "UPDATE MEMBER SET member_level = ? WHERE member_id= ? ";
			conn = dbUtil.getConnection();
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, member.getMemberLevel());
			stmt.setString(2, member.getMemberId());
			row = stmt.executeUpdate();
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		finally 
		{
			try
			{
				if(row ==1)
				{
					resultRow = 1;
				}
				dbUtil.close(null, stmt, conn);
			}
			catch(Exception e)
			{
				e.printStackTrace();
			}
		}
		return resultRow;
	}
	
	//관리자 : 멤버수
	public int selectMemberCount()
	{
		int count = 0;
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		DBUtil dbUtil = new DBUtil();
		
		try
		{
			String sql = "SELECT COUNT(*) FROM member";
			conn = dbUtil.getConnection();
			stmt = conn.prepareStatement(sql);
			rs = stmt.executeQuery();
			while(rs.next())
			{
				count = rs.getInt("COUNT(*)");
			}
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		finally 
		{
			try
			{
				dbUtil.close(rs, stmt, conn);
			}
			catch(Exception e)
			{
				e.printStackTrace();
			}
		}
		return count;
	}
	
	//회원 강퇴
	public int deleteMemberByAdmin(Member member) 
	{
		int resultRow = 0;
		int row = 0;
		DBUtil dbUtil = new DBUtil();
		Connection conn = null;
		PreparedStatement stmt = null;
		
		try
		{
			String sql = "DELETE FROM member WHERE member_id = ? ";
			conn = dbUtil.getConnection();
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, member.getMemberId());
			row = stmt.executeUpdate();
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		finally 
		{
			try
			{
				if(row ==1)
				{
					resultRow = 1;
				}
	
				dbUtil.close(null, stmt, conn);
			}
			catch(Exception e)
			{
				e.printStackTrace();
			}
		}
		
		return resultRow;
	}
	
	//관리자 멤버 리스트 띄우기
	public ArrayList<Member> selecetMemberListByPage(int beginRow, int rowPerPage) 
	{
		DBUtil dbUtil = new DBUtil();
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		ArrayList<Member> list = null;
		
		try
		{
			//ORDER BY createdate DESC
			list= new ArrayList<Member>();
			String sql = "SELECT member_no memberNo, member_id memberId, member_level memberLevel, member_name memberName, updatedate, createdate FROM member ORDER BY createdate DESC LIMIT ?,?";
			conn = dbUtil.getConnection();
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, beginRow);
			stmt.setInt(2, rowPerPage);
			rs = stmt.executeQuery();
			while(rs.next())
			{
				Member m = new Member();
				m.setMemberNo(rs.getInt("memberNo"));
				m.setMemberId(rs.getString("memberId"));
				m.setMemberLevel(rs.getInt("memberLevel"));
				m.setMemberName(rs.getString("memberName"));
				m.setUpdatedate(rs.getString("updatedate"));
				m.setCreatedate(rs.getString("createdate"));
				list.add(m);
			}
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		finally 
		{
			try
			{
				dbUtil.close(rs, stmt, conn);
			}
			catch(Exception e)
			{
				e.printStackTrace();
			}
		}
		return list;
	}
	
	//로그인
	public Member login(Member paramMember) 
	{
		Member	resultMember = null;
		DBUtil dbUtil = new DBUtil(); //DBUtil 클래스의 객체 dbUtil 만들고
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
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
		
		try 
		{
			String sql = "SELECT member_id memberId, member_level memberLevel, member_name memberName FROM member WHERE member_id =? AND member_pw =PASSWORD(?)";
			conn = dbUtil.getConnection();//객체 dbUtil의 getConnection 메소드를 호출해서 Connection conn에 저장
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, paramMember.getMemberId());
			stmt.setString(2, paramMember.getMemberPw());
			rs = stmt.executeQuery();
			
			if(rs.next())
			{
				resultMember = new Member();
				resultMember.setMemberId(rs.getString("memberId"));
				resultMember.setMemberName(rs.getString("memberName"));
				resultMember.setMemberLevel(rs.getInt("memberLevel"));
			}
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		finally 
		{
			try 
			{
				dbUtil.close(rs, stmt, conn);
			}
			catch(Exception e)
			{
				e.printStackTrace();
			}
		}
		return resultMember;
	}
	
	//회원가입 
	//1) 아이디 중복 체크
	//반환값의 의미를 적자  t: 이미 존재  f: 사용가능
	public boolean selectMemberIdCk(String memberId) 
	{
		boolean result = false;
		DBUtil dbUtil = new DBUtil(); //DBUtil 클래스의 객체 dbUtil 만들고
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		try
		{
			conn = dbUtil.getConnection();//객체 dbUtil의 getConnection 메소드를 호출해서 Connection conn에 저장
			String sql = "SELECT member_id FROM member WHERE member_id=?";
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, memberId);
			rs = stmt.executeQuery();
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		finally 
		{
			try
			{
				if(rs.next())
				{
					result = true;
				}
				dbUtil.close(rs, stmt, conn);
			}
			catch(Exception e)
			{
				e.printStackTrace();
			}
		}
		return result;
	}
	
	//2)회원가입
	public int insertMember(Member paramMember) 
	{
		int resultRow = 0;
		int row = 0;
		DBUtil dbUtil = new DBUtil(); //DBUtil 클래스의 객체 dbUtil 만들고
		Connection conn = null;
		PreparedStatement stmt = null;
		/*String driver = "org.mariadb.jdbc.Driver";
		String dbUrl = "jdbc:mariadb://localhost:3306/cashbook";
		String dbUser = "root";
		String dbPw = "java1234";
		
		Class.forName(driver); // 외부 드라이브 로딩
		Connection conn = DriverManager.getConnection(dbUrl, dbUser, dbPw); // db 연결
		*/
		
		try
		{
			String sql = "INSERT INTO member(member_id, member_pw, member_name, updatedate, createdate) VALUES ( ?,PASSWORD(?),?,now(),now())";
			conn = dbUtil.getConnection();//객체 dbUtil의 getConnection 메소드를 호출해서 Connection conn에 저장
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, paramMember.getMemberId());
			stmt.setString(2, paramMember.getMemberPw());
			stmt.setString(3, paramMember.getMemberName());
			row = stmt.executeUpdate();
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		finally 
		{
			try
			{
				if(row ==1)
				{
					resultRow = 1;
				}
				dbUtil.close(null, stmt, conn);
			}
			catch(Exception e)
			{
				e.printStackTrace();
			}
		}
		return resultRow;
	}
	
	//회원정보 수정
	public int updateMember(Member paramMember)
	{
		int resultRow = 0;
		int row = 0;
		DBUtil dbUtil = new DBUtil(); //DBUtil 클래스의 객체 dbUtil 만들고
		Connection conn = null;
		PreparedStatement stmt = null;
		/*String driver = "org.mariadb.jdbc.Driver";
		String dbUrl = "jdbc:mariadb://localhost:3306/cashbook";
		String dbUser = "root";
		String dbPw = "java1234";
		
		Class.forName(driver); // 외부 드라이브 로딩
		Connection conn = DriverManager.getConnection(dbUrl, dbUser, dbPw); // db 연결
		*/

		try
		{
			String sql = "UPDATE MEMBER SET member_name = ? WHERE member_id= ? AND member_pw = PASSWORD(?);";
			conn = dbUtil.getConnection();//객체 dbUtil의 getConnection 메소드를 호출해서 Connection conn에 저장
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, paramMember.getMemberName());
			stmt.setString(2, paramMember.getMemberId());
			stmt.setString(3, paramMember.getMemberPw());
			row = stmt.executeUpdate();
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		finally 
		{
			try
			{
				if(row ==1)
				{
					resultRow = 1;
				}
				dbUtil.close(null, stmt, conn);
			}
			catch(Exception e)
			{
				e.printStackTrace();
			}
		}
		return resultRow;
	}
	
	//회원탈퇴
	public int deleteMember(String memberId, String memberPw)
	{
		int resultRow = 0;
		int row = 0;
		DBUtil dbUtil = new DBUtil(); //DBUtil 클래스의 객체 dbUtil 만들고
		Connection conn = null;
		PreparedStatement stmt = null;
		
		try
		{
			String sql = "DELETE FROM MEMBER WHERE member_id=? AND member_pw=PASSWORD(?)";
			conn = dbUtil.getConnection();//객체 dbUtil의 getConnection 메소드를 호출해서 Connection conn에 저장
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, memberId);
			stmt.setString(2, memberPw);
			row = stmt.executeUpdate();
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		finally 
		{
			try
			{
				if(row==1)
				{
					resultRow = 1;
				}
				dbUtil.close(null, stmt, conn);
			}
			catch(Exception e)
			{
				e.printStackTrace();
			}
		}
		return resultRow;
	}
}
