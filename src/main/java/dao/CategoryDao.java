package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;

import util.DBUtil;
import vo.Category;

public class CategoryDao 
{
	//수정 :수정폼(select)과 수정액션(update)으로 구성
	//admin -> updateCategoryForm.jsp
	public int updateCategoryName(Category category) throws Exception
	{
		int resultRow = 0;
		
		String sql = "UPDATE category SET category_name = ? , category_Kind = ?  WHERE category_no = ?";
		DBUtil dbUtil = new DBUtil();
		Connection conn = null;
		PreparedStatement stmt = null;
		conn = dbUtil.getConnection();
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, category.getCategoryName());
		stmt.setString(2, category.getCategoryKind());
		stmt.setInt(3, category.getCategoryNo());
		int row = stmt.executeUpdate();
		if(row==1)
		{
			resultRow = 1;
		}
		dbUtil.close(null, stmt, conn);
		return resultRow;
	}
	
	//admin -> updateCategoryAction.jsp
	public Category selectCategoryOne(int categoryNo) throws Exception
	{
		Category category = null;
		String sql = "SELECT category_no categoryNo, category_name categoryName, category_kind categoryKind FROM category WHERE category_no = ?";
		DBUtil dbUtil = new DBUtil();
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		conn = dbUtil.getConnection();
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, categoryNo);
		rs = stmt.executeQuery();
		if(rs.next())
		{
			category = new Category();
			category.setCategoryNo(rs.getInt("categoryNo"));
			category.setCategoryName(rs.getString("categoryName"));
			category.setCategoryKind(rs.getString("categoryKind"));
		}
		return category;
	}
	
	//admin -> deleteCategory.jsp
	public int deleteCategory(int categoryNo) throws Exception
	{
		int row = 0;
		
		String sql = "DELETE FROM category WHERE category_no =? ";
		DBUtil dbUtil = new DBUtil();
		Connection conn = null;
		PreparedStatement stmt = null;
		conn = dbUtil.getConnection();
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, categoryNo);
		row = stmt.executeUpdate();
		
		dbUtil.close(null, stmt, conn);
		return row;
	}
	
	//admin -> insertCategoryAction.jsp
	public int insertCategory(Category category) throws Exception
	{
		int row = 0;
		String sql = "INSERT INTO category(category_kind, category_name, updatedate, createdate) VALUES (?,?,CURDATE(),CURDATE())";
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = null;
		PreparedStatement stmt = null;
		
		conn = dbUtil.getConnection();
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, category.getCategoryKind());
		stmt.setString(2, category.getCategoryName());
		row = stmt.executeUpdate();
		dbUtil.close(null, stmt, conn);
		
		return row;
	}
	
	//admin -> 카테고리 관리 -> 카테고리 목록
	public ArrayList<Category> selectCategoryListByAdmin() throws Exception
	{
		ArrayList<Category> categoryList = new ArrayList<Category>();
		
		String sql = "SELECT category_no categoryNo, category_kind categoryKind, category_name categoryName, updatedate, createdate FROM category";
		
		DBUtil dbutil = new DBUtil();

		//db자원 초기화
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		conn=dbutil.getConnection();
		stmt=conn.prepareStatement(sql);
		rs=stmt.executeQuery();
		
		while(rs.next())
		{
			Category c = new Category();
			c.setCategoryNo(rs.getInt("categoryNo"));//rs.getInt(1);  1-SELECT 절의 순서
			c.setCategoryKind(rs.getString("categoryKind"));
			c.setCategoryName(rs.getString("categoryName"));
			c.setUpdatedate(rs.getString("updateDate")); //DB날짜 타입이지만 자바단에서 문자열 타입으로 받는다.
			c.setCreatedate(rs.getString("updateDate"));
			categoryList.add(c);
		}
		
		
		//db자원 반납
		dbutil.close(rs, stmt, conn);
		return categoryList;
	}
	
	//cash 입력시 <select> 리스트
	public ArrayList<Category> selectCategoryList() throws Exception
	{
		ArrayList<Category> categoryList = new ArrayList<Category>();
		
		DBUtil dbutil = new DBUtil();
		Connection conn = dbutil.getConnection();
		String sql = "SELECT category_no categoryNo ,category_kind categoryKind ,category_name categoryName FROM category";
		PreparedStatement stmt = conn.prepareStatement(sql);
		ResultSet rs = stmt.executeQuery();
		while(rs.next())
		{
			Category category = new Category();
			category.setCategoryNo(rs.getInt("categoryNo"));
			category.setCategoryKind(rs.getString("categoryKind"));
			category.setCategoryName(rs.getString("categoryName"));
			categoryList.add(category);
		}
		
		
		rs.close();
		stmt.close();
		conn.close();
			
		return categoryList;
	}
}
