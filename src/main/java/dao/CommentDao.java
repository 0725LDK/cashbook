package dao;
import vo.*;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.util.*;

import util.DBUtil;
public class CommentDao {
	
	//답변 추가
	public int insertComment(Comment comment) throws Exception
	{
		int resultRow = 0;
		
		String sql = "INSERT INTO comment(help_no, comment_memo, member_id, updatedate, createdate)VALUES(?, ?, ?, NOW(), NOW());";
		Connection conn = null;
		PreparedStatement stmt = null;
		
		DBUtil dbUtil = new DBUtil();
		conn = dbUtil.getConnection();
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, comment.getHelpNo());
		stmt.setString(2, comment.getCommentMemo());
		stmt.setString(3, comment.getMemberId());
		int row = stmt.executeUpdate();
		
		if(row==1)
		{
			resultRow = 1;
		}
		
		dbUtil.close(null, stmt, conn);
		
		return resultRow;
	}
	
	//답변업데이트
	public int updateComment (Comment comment) throws Exception
	{
		int resultRow = 0;
		String sql = "UPDATE comment SET comment_memo = ? WHERE comment_no= ? ";
		Connection conn = null;
		PreparedStatement stmt = null;
		
		DBUtil dbUtil = new DBUtil();
		conn = dbUtil.getConnection();
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, comment.getCommentMemo());
		stmt.setInt(2, comment.getCommentNo());
		int row = stmt.executeUpdate();
		
		if(row==1)
		{
			resultRow = 1;
		}
		
		dbUtil.close(null, stmt, conn);
		
		return resultRow;
	}
	
	//답변 삭제
	public int deleteComment (Comment comment) throws Exception
	{
		int resultRow = 0;
		String sql = "DELETE FROM COMMENT WHERE comment_no= ? ;";
		Connection conn = null;
		PreparedStatement stmt = null;
		
		DBUtil dbUtil = new DBUtil();
		conn = dbUtil.getConnection();
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, comment.getCommentNo());
		int row = stmt.executeUpdate();
		
		if(row==1)
		{
			resultRow = 1;
		}
		
		dbUtil.close(null, stmt, conn);
		
		return resultRow;
	}
}
