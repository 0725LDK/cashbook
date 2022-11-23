package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;

import util.DBUtil;
import vo.*;
public class CashDao {
	

	//월별 리스트 & 상세 리스트확인
	public ArrayList<HashMap<String, Object>> selectCashListByMonth(String memberId, int year, int month) throws Exception
	{
		ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>();
		DBUtil dbutil = new DBUtil();
		Connection conn = dbutil.getConnection();
		String sql = "SELECT c.cash_no cashNo, c.cash_date cashDate, c.cash_price cashPrice, c.category_no categoryNo, ct.category_kind categoryKind, ct.category_name categoryName, c.cash_memo cashMemo, c.updatedate updateDate, c.createdate createDate, c.member_id memberId FROM cash c INNER JOIN category ct ON c.category_no=ct.category_no WHERE c.member_id = ? AND YEAR(c.cash_date)= ? AND MONTH(c.cash_date) = ? ORDER BY c.cash_date ASC, ct.category_kind ASC";
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
			m.put("memberId", rs.getString("memberId"));
			
			// 리스트에 넣음
			list.add(m);
		}
		
		rs.close();
		stmt.close();
		conn.close();
		return list;		
	}
	
	//가게부 추가 
	public int insertCash(Cash cash) throws Exception
	{
		int resultRow = 0;
		
		DBUtil dbutil = new DBUtil();
		Connection conn = dbutil.getConnection();
		String sql = "INSERT INTO cash (category_no, member_id, cash_date, cash_price, cash_memo, updatedate, createdate) VALUES (?, ?, ?, ?, ?, CURDATE(), CURDATE())";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, cash.getCategoryNo());
		stmt.setString(2, cash.getMemberId());
		stmt.setString(3, cash.getCashDate());
		stmt.setLong(4, cash.getCashPrice());
		stmt.setString(5, cash.getCashMemo());
		int row = stmt.executeUpdate();
		
		if(row==1)
		{
			System.out.println("가계부 입력 성공");
			stmt.close();
			conn.close();
			resultRow =1;
			return resultRow;
		}
		
		return resultRow;
	}
	
	//가계부 삭제
	public int deleteCash( Cash cash) throws Exception
	{
		int resultRow = 0;
		
		DBUtil dbutil = new DBUtil();
		Connection conn = dbutil.getConnection();
		
		String sql = "DELETE FROM cash WHERE cash_no = ? AND member_id = ? ";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, cash.getCashNo());
		stmt.setString(2, cash.getMemberId());
	
		int row = stmt.executeUpdate();
		
		if(row==1)
		{
			System.out.println("가계부 삭제 성공");
			resultRow = 1;
		}
		else
		{
			System.out.println("가계부 삭제 실패");
		}
		stmt.close();
		conn.close();
		
		return resultRow;
	}
	
	//가계부 수정
		public int updateCash(Cash cash) throws Exception
		{
			int resultRow =0;
			
			DBUtil dbutil = new DBUtil();
			Connection conn = dbutil.getConnection();
			
			String sql = "UPDATE cash SET category_no = ?, cash_price = ?, cash_memo=?, updatedate=CURDATE() WHERE cash_no = ? ";
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setInt(1, cash.getCategoryNo());
			stmt.setLong(2, cash.getCashPrice());
			stmt.setString(3, cash.getCashMemo());
		
			stmt.setInt(4, cash.getCashNo());
		
			int row = stmt.executeUpdate();
			
			if(row==1)
			{
				System.out.println("가계부 수정 성공");
				resultRow = 1;
				return resultRow;
			}
			else
			{
				System.out.println("가계부 수정 실패");
			}
			stmt.close();
			conn.close();
			
			return resultRow;
		}
		
	
	
}
