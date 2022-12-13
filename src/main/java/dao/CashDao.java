package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;

import util.DBUtil;
import vo.*;
public class CashDao 
{
	//지출수입 총 연도수 구하기
	public HashMap<String, Object> cashSummaryYearCount() 
	{
		HashMap<String, Object> mapYear = null;
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		DBUtil dbUtil = new DBUtil();
		
		try
		{
			mapYear = new HashMap<String,Object>();
			conn = dbUtil.getConnection();
			String sql = "SELECT"
				   	+ "(SELECT MIN(YEAR(cash_date)) FROM cash) minYear"
				   	+ " , (SELECT MAX(YEAR(cash_date))FROM cash) maxYear"
				   	+ " FROM DUAL";
			stmt = conn.prepareStatement(sql);
			rs = stmt.executeQuery();
			if(rs.next())
			{
				mapYear = new HashMap<String, Object>();
				mapYear.put("minYear", rs.getInt("minYear"));
				mapYear.put("maxYear", rs.getInt("maxYear"));
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
				
			}
			catch(Exception e)
			{
				e.printStackTrace();
			}
		}
		
		return mapYear;
	}
	
	
	//월별 지출 수입 내용
	public ArrayList<HashMap<String,Object>> selectMonthCashSummary(String loginMember,int summaryYear)
	{
		ArrayList<HashMap<String,Object>> list = null;
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		DBUtil dbUtil = new DBUtil();
		
		try 
		{
			list = new ArrayList<HashMap<String,Object>>();
			conn = dbUtil.getConnection();
			String sql = "SELECT MONTH(t2.cashDate) 월"
							+ "	 , COUNT(t2.importCash) 수입카운트"
							+ "	 , IFNULL(SUM(t2.importCash), 0) 수입합계"
							+ "	 , IFNULL(ROUND(AVG(t2.importCash)), 0) 수입평균"
						 	+ "	 , COUNT(t2.exportCash) 지출카운트"
						 	+ "	 , IFNULL(SUM(t2.exportCash),0) 지출합계"
							+ "	 , IFNULL(ROUND(AVG(t2.exportCash)),0) 지출평균 "
							+ " FROM " 
							+ " (SELECT memberId, cashNo, cashDate"
							+ "		 , if(categoryKind = '수입', cashPrice, NULL) importCash"
							+ "		 , if(categoryKind = '지출', cashPrice, NULL) exportCash"
							+ "	FROM" 
							+ "		(SELECT cs.cash_no cashNo"
							+ "				  , cs.cash_date cashDate"
							+ "				  , cs.cash_price cashPrice"
							+ "				  , cg.category_kind categoryKind"
							+ "				  , cs.member_id memberId"
							+ "		FROM cash cs INNER JOIN category cg"
							+ "			ON cs.category_no = cg.category_no) t ) t2 "
							+ " WHERE t2.memberId = ? AND YEAR(t2.cashDate) = ? "
							+ " GROUP BY MONTH(t2.cashDate) "
							+ " ORDER BY MONTH(t2.cashDate) ASC"; 
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, loginMember);
			stmt.setInt(2, summaryYear);
			rs = stmt.executeQuery();
			while(rs.next())
			{
				HashMap<String,Object> map2 = new HashMap<String,Object>();
				map2.put("month", rs.getString("월"));
				map2.put("countImportCash", rs.getString("수입카운트"));
				map2.put("sumImportCash", rs.getString("수입합계"));
				map2.put("avgImportCash", rs.getString("수입평균"));
				map2.put("countExportCash", rs.getString("지출카운트"));
				map2.put("sumExportCash", rs.getString("지출합계"));
				map2.put("avgExportCash", rs.getString("지출평균"));
				list.add(map2);
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
	
	
	//연도별 지출 수입 요약
	public ArrayList<HashMap<String,Object>> selectYearCashSummary(String loginMember,int summaryYear, int month)
	{
		ArrayList<HashMap<String,Object>> list = null;
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		DBUtil dbUtil = new DBUtil();
		
		try
		{
			list = new ArrayList<HashMap<String,Object>>();
			conn = dbUtil.getConnection();
			String sql = "SELECT YEAR(t2.cashDate) 연도"
					 	+ " , COUNT(t2.importCash) 수입카운트"
					 	+ " , IFNULL(SUM(t2.importCash), 0) 수입합계"
					 	+ " , IFNULL(ROUND(AVG(t2.importCash)), 0) 수입평균"
					 	+ " , COUNT(t2.exportCash) 지출카운트"
					 	+ " , IFNULL(SUM(t2.exportCash),0) 지출합계"
					 	+ " , IFNULL(ROUND(AVG(t2.exportCash)),0) 지출평균"
						+ "	FROM" 
						+ "		(SELECT memberId, cashNo, cashDate"
						+ "				 , if(categoryKind = '수입', cashPrice, NULL) importCash"
						+ "				 , if(categoryKind = '지출', cashPrice, NULL) exportCash"
						+ "		FROM" 
						+ "			(SELECT cs.cash_no cashNo"
						+ "					  , cs.cash_date cashDate"
						+ "					  , cs.cash_price cashPrice"
						+ "					  , cg.category_kind categoryKind"
						+ "					  , cs.member_id memberId"
						+ "			FROM cash cs INNER JOIN category cg"
						+ "				ON cs.category_no = cg.category_no) t ) t2"
						+ "	WHERE t2.memberId = ? "
						+ "	GROUP BY YEAR(t2.cashDate)"
						+ "	ORDER BY YEAR(t2.cashDate) ASC";
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, loginMember);
			rs = stmt.executeQuery();
			while(rs.next())
			{
				HashMap<String,Object> map = new HashMap<String,Object>();
				map.put("year", rs.getString("연도"));
				map.put("countImportCash", rs.getString("수입카운트"));
				map.put("sumImportCash", rs.getString("수입합계"));
				map.put("avgImportCash", rs.getString("수입평균"));
				map.put("countExportCash", rs.getString("지출카운트"));
				map.put("sumExportCash", rs.getString("지출합계"));
				map.put("avgExportCash", rs.getString("지출평균"));
				list.add(map);
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

	//월별 리스트 & 상세 리스트확인
	public ArrayList<HashMap<String, Object>> selectCashListByMonth(String memberId, int year, int month) 
	{
		ArrayList<HashMap<String, Object>> list = null;
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		DBUtil dbUtil = new DBUtil();
		try 
		{
			list = new ArrayList<HashMap<String, Object>>();
			
			conn = dbUtil.getConnection();
			String sql = "SELECT c.cash_no cashNo, c.cash_date cashDate, c.cash_price cashPrice, c.category_no categoryNo, ct.category_kind categoryKind, ct.category_name categoryName, c.cash_memo cashMemo, c.updatedate updateDate, c.createdate createDate, c.member_id memberId FROM cash c INNER JOIN category ct ON c.category_no=ct.category_no WHERE c.member_id = ? AND YEAR(c.cash_date)= ? AND MONTH(c.cash_date) = ? ORDER BY c.cash_date ASC, ct.category_kind ASC";
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, memberId);
			stmt.setInt(2, year);
			stmt.setInt(3, month);
			rs = stmt.executeQuery();
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
				m.put("memberId", rs.getString("memberId"));
				
				// 리스트에 넣음
				list.add(m);
			}
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		finally {
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
	
	//가게부 추가 
	public int insertCash(Cash cash) 
	{
		
		
		int resultRow = 0;
		int row = 0;
		Connection conn = null;
		PreparedStatement stmt = null;
		DBUtil dbUtil = new DBUtil();
		try 
		{
			conn = dbUtil.getConnection();
			String sql = "INSERT INTO cash (category_no, member_id, cash_date, cash_price, cash_memo, updatedate, createdate) VALUES (?, ?, ?, ?, ?, CURDATE(), CURDATE())";
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, cash.getCategoryNo());
			stmt.setString(2, cash.getMemberId());
			stmt.setString(3, cash.getCashDate());
			stmt.setLong(4, cash.getCashPrice());
			stmt.setString(5, cash.getCashMemo());
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
					dbUtil.close(null, stmt, conn);
					resultRow =1;
				}
			}
			catch(Exception e)
			{
				e.printStackTrace();
			}
		}
		return resultRow;
	}
	
	//가계부 삭제
	public int deleteCash( Cash cash) 
	{
		int resultRow = 0;
		int row = 0;
		Connection conn = null;
		PreparedStatement stmt = null;
		DBUtil dbUtil = new DBUtil();
		
		try 
		{
			conn = dbUtil.getConnection();
			
			String sql = "DELETE FROM cash WHERE cash_no = ? AND member_id = ? ";
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, cash.getCashNo());
			stmt.setString(2, cash.getMemberId());
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		finally 
		{
			try 
			{
				row = stmt.executeUpdate();
				
				if(row==1)
				{
					System.out.println("가계부 삭제 성공");
					resultRow = 1;
				}
				else
				{
					System.out.println("가계부 삭제 실패");
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
	
	//가계부 수정
		public int updateCash(Cash cash) 
		{
			int resultRow = 0;
			int row = 0;
			Connection conn = null;
			PreparedStatement stmt = null;
			DBUtil dbUtil = new DBUtil();
			
			try
			{
				conn = dbUtil.getConnection();
				
				String sql = "UPDATE cash SET category_no = ?, cash_price = ?, cash_memo=?, updatedate=CURDATE() WHERE cash_no = ? ";
				stmt = conn.prepareStatement(sql);
				stmt.setInt(1, cash.getCategoryNo());
				stmt.setLong(2, cash.getCashPrice());
				stmt.setString(3, cash.getCashMemo());
			
				stmt.setInt(4, cash.getCashNo());
			
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
						System.out.println("가계부 수정 성공");
						resultRow = 1;
						return resultRow;
					}
					else
					{
						System.out.println("가계부 수정 실패");
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
