package dao;
import vo.*;

import java.sql.Connection;
import java.sql.PreparedStatement;

import util.DBUtil;
public class CommentDao {
	
	//답변 추가
	public int insertComment(Comment comment) 
	{
		int resultRow = 0;
		int row = 0;
		DBUtil dbUtil = new DBUtil();
		Connection conn = null;
		PreparedStatement stmt = null;

		try
		{
			String sql = "INSERT INTO comment(help_no, comment_memo, member_id, updatedate, createdate)VALUES(?, ?, ?, NOW(), NOW());";
			conn = dbUtil.getConnection();
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, comment.getHelpNo());
			stmt.setString(2, comment.getCommentMemo());
			stmt.setString(3, comment.getMemberId());
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
	
	//답변업데이트
	public int updateComment (Comment comment) 
	{
		int resultRow = 0;
		int row = 0;
		DBUtil dbUtil = new DBUtil();
		Connection conn = null;
		PreparedStatement stmt = null;

		try
		{
			String sql = "UPDATE comment SET comment_memo = ? WHERE comment_no= ? ";
			conn = dbUtil.getConnection();
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, comment.getCommentMemo());
			stmt.setInt(2, comment.getCommentNo());
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
	
	//답변 삭제
	public int deleteComment (Comment comment) 
	{
		int resultRow = 0;
		int row = 0;
		Connection conn = null;
		PreparedStatement stmt = null;
		DBUtil dbUtil = new DBUtil();
		
		try
		{
			String sql = "DELETE FROM COMMENT WHERE comment_no= ? ;";
			conn = dbUtil.getConnection();
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, comment.getCommentNo());
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
