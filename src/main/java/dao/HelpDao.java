package dao;

import vo.*;

import java.sql.*;
import java.util.*;

import util.*;

public class HelpDao 
{
	//문의 총 갯수 구하기
	public int helpCount () 
	{
		int result = 0;
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		DBUtil dbUtil = new DBUtil();

		try
		{
			String sql = "SELECT COUNT(*) FROM HELP";
			conn = dbUtil.getConnection();
			stmt = conn.prepareStatement(sql);
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
					result = rs.getInt("COUNT(*)");
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
	
	//관리자 selectHelpList 오버로딩 함수의 리턴값,이름이 같아도 매개변수가 다른것
	public ArrayList<HashMap<String, Object>> selectHelpList(int beginRow, int rowPerPage) 
	{
		
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		DBUtil dbUtil = new DBUtil();
		ArrayList<HashMap<String, Object>> list = null;

		try
		{
			list = new ArrayList<HashMap<String, Object>>();
			String sql = "SELECT h.help_no helpNo, h.help_memo helpMemo, h.member_id memberId, h.createdate helpCreatedate,  c.comment_no commentNo, c.comment_memo commentMemo, c.createdate commentCreatedate FROM help h LEFT OUTER JOIN comment c ON h.help_no = c.help_no ORDER BY helpCreatedate DESC LIMIT ?,?";
			conn = dbUtil.getConnection();
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, beginRow);
			stmt.setInt(2, rowPerPage);
			rs = stmt.executeQuery();
			while(rs.next()) 
			{
				HashMap<String, Object> m = new HashMap<String, Object>();
				m.put("helpNo", rs.getInt("helpNo"));
				m.put("helpMemo", rs.getString("helpMemo"));
				m.put("memberId", rs.getString("memberId"));
				m.put("helpCreatedate", rs.getString("helpCreatedate"));
				m.put("commentNo", rs.getString("commentNo"));
				m.put("commentMemo", rs.getString("commentMemo"));
				m.put("commentCreatedate", rs.getString("commentCreatedate"));
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
	
	//문의사항 리스트업
	public ArrayList<HashMap<String, Object>> selectHelpList(String memberId) 
	{
		
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		DBUtil dbUtil = new DBUtil();
		ArrayList<HashMap<String, Object>> list = null;

		try
		{
			list = new ArrayList<HashMap<String, Object>>();
			String sql = "SELECT h.help_no helpNo, h.help_memo helpMemo, h.createdate helpCreatedate, c.comment_memo commentMemo, c.createdate commentCreatedate FROM help h LEFT OUTER JOIN comment c ON h.help_no = c.help_no WHERE h.member_id= ?";
			conn = dbUtil.getConnection();
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, memberId);
			rs = stmt.executeQuery();
			while(rs.next()) 
			{
				HashMap<String, Object> m = new HashMap<String, Object>();
				m.put("helpNo", rs.getInt("helpNo"));
				m.put("helpMemo", rs.getString("helpMemo"));
				m.put("helpCreatedate", rs.getString("helpCreatedate"));
				m.put("commentMemo", rs.getString("commentMemo"));
				m.put("commentCreatedate", rs.getString("commentCreatedate"));
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
	
	//문의사항 작성
	public int helpInsert(Help help) 
	{
		int resultRow = 0;
		int row = 0;
		DBUtil dbUtil = new DBUtil();
		Connection conn = null;
		PreparedStatement stmt = null;

		try
		{
			String sql = "INSERT INTO HELP(help_memo,member_id,updatedate,createdate)VALUES(?,?,NOW(),NOW());";
			conn = dbUtil.getConnection();
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, help.getHelpMemo());
			stmt.setString(2, help.getMemberId());
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
	
	//문의사항 삭제
	public int helpDelete(int helpNo) 
	{
		int resultRow = 0;
		int row = 0;
		Connection conn = null;
		PreparedStatement stmt = null;
		DBUtil dbUtil = new DBUtil();
		
		try
		{
			String sql = "DELETE FROM help where help_no = ? ";
			conn = dbUtil.getConnection();
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, helpNo);
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
	
	//문의사항 수정
	public int helpUpdate(Help help) 
	{
		int resultRow = 0;
		int row = 0;
		Connection conn = null;
		PreparedStatement stmt = null;
		DBUtil dbUtil = new DBUtil();
		
		try
		{
			String sql = "UPDATE help SET help_memo = ? WHERE help_no= ? ";
			conn = dbUtil.getConnection();
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, help.getHelpMemo());
			stmt.setInt(2, help.getHelpNo());
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
