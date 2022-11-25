package dao;

import java.sql.*;
import java.util.ArrayList;

import util.DBUtil;
import vo.*;

public class NoticeDao 
{
	//공지 삭제
	public int deleteNotice(Notice notice) throws Exception
	{	
		int resultRow = 0;
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "DELETE FROM notice WHERE notice_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, notice.getNoticeNo());
		int row = stmt.executeUpdate();
		
		if(row == 1 )
		{
			System.out.println("noticeDao 삭제 성공");
			resultRow = 1;
		}
		else
		{
			System.out.println("noticeDao삭제 실패");
		}
		dbUtil.close(null, stmt, conn);
		
		return resultRow;
	}
	
	//공지 수정
	public int updateNotice(Notice notice) throws Exception
	{
		int resultRow = 0;
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "UPDATE notice SET notice_memo = ? WHERE notice_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, notice.getNoticeMemo());
		stmt.setInt(2, notice.getNoticeNo());
		int row = stmt.executeUpdate();
		
		if(row == 1)
		{
			System.out.println("noticeDao수정 성공");
			resultRow = 1;
		}
		else
		{
			System.out.println("noticeDao수정 성공");
		}
		dbUtil.close(null, stmt, conn);
		
		
		return resultRow;
	}
	
	//공지 생성
	public int insertNotice(Notice notice) throws Exception
	{
		int resultRow = 0;
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "INSERT notice(notice_memo, updatedate, createdate) VALUES(?,NOW(),NOW())";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, notice.getNoticeMemo());
		int row = stmt.executeUpdate();
		
		if(row ==1)
		{
			System.out.println("noticeDao생성 성공");
			resultRow = 1;
		}
		else
		{
			System.out.println("noticeDao생성 실패");
			
		}
		dbUtil.close(null, stmt, conn);
		
		return resultRow;
	}
	
	
	//라스트 페이지 구하기
	public int selectNoticeCount() throws Exception {
		int count = 0;
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "SELECT COUNT(*) FROM notice;";
		PreparedStatement stmt = conn.prepareStatement(sql);
		ResultSet rs = stmt.executeQuery();
		while(rs.next())
		{
			count = rs.getInt("COUNT(*)");
		}
		
		return count;
	}
	
	//loginForm.jsp 공지목록
	public ArrayList<Notice> selectNoticeListByPage(int beginRow, int rowPerPage) throws Exception
	{
		ArrayList<Notice> list = new ArrayList<Notice>();
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "SELECT notice_no noticeNO, notice_memo noticeMemo, createdate FROM notice ORDER BY createdate DESC LIMIT ?,?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, beginRow);
		stmt.setInt(2, rowPerPage);
		ResultSet rs = stmt.executeQuery();
		while(rs.next())
		{
			Notice n = new Notice();
			n.setNoticeNo(rs.getInt("noticeNo"));
			n.setNoticeMemo(rs.getString("noticeMemo"));
			n.setCreatedate(rs.getString("createdate"));
			list.add(n);
		}
		return list;
	}
}
