package dao;

import vo.*;

import java.sql.*;
import java.util.*;

import util.*;

public class HelpDao 
{
	//문의 총 갯수 구하기
	public int helpCount () throws Exception
	{
		int result = 0;
		
		String sql = "SELECT COUNT(*) FROM HELP";
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		DBUtil dbUtil = new DBUtil();
		conn = dbUtil.getConnection();
		stmt = conn.prepareStatement(sql);
		rs = stmt.executeQuery();
		if(rs.next())
		{
			result = rs.getInt("COUNT(*)");
		}
		
		return result;
	}
	
	//관리자 selectHelpList 오버로딩 함수의 리턴값,이름이 같아도 매개변수가 다른것
	public ArrayList<HashMap<String, Object>> selectHelpList(int beginRow, int rowPerPage) throws Exception
	{
		ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>();
		
		String sql = "SELECT h.help_no helpNo, h.help_memo helpMemo, h.member_id memberId, h.createdate helpCreatedate,  c.comment_no commentNo, c.comment_memo commentMemo, c.createdate commentCreatedate FROM help h LEFT OUTER JOIN comment c ON h.help_no = c.help_no ORDER BY helpCreatedate DESC LIMIT ?,?";
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		DBUtil dbUtil = new DBUtil();
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
		
		dbUtil.close(rs, stmt, conn);
		return list;
	}
	
	//문의사항 리스트업
	public ArrayList<HashMap<String, Object>> selectHelpList(String memberId) throws Exception
	{
		ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>();
		
		String sql = "SELECT h.help_no helpNo, h.help_memo helpMemo, h.createdate helpCreatedate, c.comment_memo commentMemo, c.createdate commentCreatedate FROM help h LEFT OUTER JOIN comment c ON h.help_no = c.help_no WHERE h.member_id= ?";
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		DBUtil dbUtil = new DBUtil();
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
		
		dbUtil.close(rs, stmt, conn);
		return list;
	}
	
	//문의사항 작성
	public int helpInsert(Help help) throws Exception
	{
		int resultRow = 0;
		
		
		String sql = "INSERT INTO HELP(help_memo,member_id,updatedate,createdate)VALUES(?,?,NOW(),NOW());";
		Connection conn = null;
		PreparedStatement stmt = null;
		
		DBUtil dbUtil = new DBUtil();
		conn = dbUtil.getConnection();
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, help.getHelpMemo());
		stmt.setString(2, help.getMemberId());
		int row = stmt.executeUpdate();
		
		if(row==1)
		{
			resultRow = 1;
		}
		
		dbUtil.close(null, stmt, conn);
		return resultRow;
	}
	
	//문의사항 삭제
	public int helpDelete(int helpNo) throws Exception
	{
		int resultRow = 0;
		
		String sql = "DELETE FROM help where help_no = ? ";
		Connection conn = null;
		PreparedStatement stmt = null;
		
		DBUtil dbUtil = new DBUtil();
		conn = dbUtil.getConnection();
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, helpNo);
		int row = stmt.executeUpdate();
		
		if(row==1)
		{
			resultRow = 1;
		}
		
		dbUtil.close(null, stmt, conn);
		return resultRow;
		
	}
	
	//문의사항 수정
	public int helpUpdate(Help help) throws Exception
	{
		int resultRow = 0;
		
		String sql = "UPDATE help SET help_memo = ? WHERE help_no= ? ";
		Connection conn = null;
		PreparedStatement stmt = null;
		
		DBUtil dbUtil = new DBUtil();
		conn = dbUtil.getConnection();
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, help.getHelpMemo());
		stmt.setInt(2, help.getHelpNo());
		int row = stmt.executeUpdate();
		
		if(row==1)
		{
			resultRow = 1;
		}
		
		dbUtil.close(null, stmt, conn);
		return resultRow;
	}
}
