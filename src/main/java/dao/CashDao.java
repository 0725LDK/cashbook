package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;

import util.DBUtil;

public class CashDao {
	
	public ArrayList<HashMap<String, Object>> selectCashListDate(String memberId, int year, int month) throws Exception
	{
		ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>();
		DBUtil dbutil = new DBUtil();
		Connection conn = dbutil.getConnection();
		String sql = "SELECT c.cash_no cashNo, c.cash_date cashDate, c.cash_price cashPrice, c.category_no categoryNo, ct.category_kind categoryKind, ct.category_name categoryName, c.cash_memo cashMemo, c.updatedate updateDate, c.createdate createDate FROM cash c INNER JOIN category ct ON c.category_no=ct.category_no WHERE c.member_id = ? AND YEAR(c.cash_date)= ? AND MONTH(c.cash_date) = ? ORDER BY c.cash_date ASC, ct.category_kind ASC";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, memberId);
		stmt.setInt(2, year);
		stmt.setInt(3, month);
		ResultSet rs = stmt.executeQuery();
		while(rs.next()) 
		{
			HashMap<String, Object> m = new HashMap<String, Object>();
			
			// 해당 월의 cash 정보 HashMap에 저장
			m.put("cashNo", rs.getInt("cashNo"));
			m.put("cashDate", rs.getString("cashDate"));
			m.put("cashPrice", rs.getLong("cashPrice"));
			m.put("categoryNo", rs.getInt("categoryNo"));
			m.put("categoryKind", rs.getString("categoryKind"));
			m.put("categoryName", rs.getString("categoryName"));
			m.put("cashMemo", rs.getString("cashMemo"));
			m.put("createDate", rs.getString("createDate"));
			m.put("updateDate", rs.getString("updateDate"));
			
			// 리스트에 넣음
			list.add(m);
		}
		rs.close();
		stmt.close();
		conn.close();
		return list;
	}
	
	
	public ArrayList<HashMap<String, Object>> selectCashListByMonth(String memberId, int year, int month) throws Exception
	{
		ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>();
		DBUtil dbutil = new DBUtil();
		Connection conn = dbutil.getConnection();
		String sql = "SELECT c.cash_no cashNo, c.cash_date cashDate, c.cash_price cashPrice, c.category_no categoryNo, ct.category_kind categoryKind, ct.category_name categoryName, c.cash_memo cashMemo, c.updatedate updateDate, c.createdate createDate FROM cash c INNER JOIN category ct ON c.category_no=ct.category_no WHERE c.member_id = ? AND YEAR(c.cash_date)= ? AND MONTH(c.cash_date) = ? ORDER BY c.cash_date ASC, ct.category_kind ASC";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, memberId);
		stmt.setInt(2, year);
		stmt.setInt(3, month);
		ResultSet rs = stmt.executeQuery();
		while(rs.next()) {
			HashMap<String, Object> m = new HashMap<String, Object>();
			
			// 해당 월의 cash 정보 HashMap에 저장
			m.put("cashNo", rs.getInt("cashNo"));
			m.put("cashDate", rs.getString("cashDate"));
			m.put("cashPrice", rs.getLong("cashPrice"));
			m.put("categoryNo", rs.getInt("categoryNo"));
			m.put("categoryKind", rs.getString("categoryKind"));
			m.put("categoryName", rs.getString("categoryName"));
			m.put("cashMemo", rs.getString("cashMemo"));
			m.put("createDate", rs.getString("createDate"));
			m.put("updateDate", rs.getString("updateDate"));
			
			// 리스트에 넣음
			list.add(m);
		}
		
		rs.close();
		stmt.close();
		conn.close();
		return list;		
	}
	
}
