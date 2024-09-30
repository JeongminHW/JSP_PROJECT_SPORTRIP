package matchdate;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Vector;

import DB.DBConnectionMgr;

public class MatchdateMgr {

	private DBConnectionMgr pool;

	public MatchdateMgr() {
		pool = DBConnectionMgr.getInstance();
	}

	// 오늘 이후 경기 일정 조회
	public Vector<MatchdateBean> listMachedate(int sport_num) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<MatchdateBean> vlist = new Vector<MatchdateBean>();
		try {
			con = pool.getConnection();
			sql = "select m.MATCH_DATE_NUM, m.STADIUM_NUM, m.MATCH_DATE, "
				    + "m.TEAM_NUM1, m.TEAM_NUM2 from matchdate m "
				    + "join team t on m.team_num1 = t.team_num "
				    + "where m.MATCH_DATE >= now() and t.sport_num = ? "
				    + "order by m.MATCH_DATE asc";

			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, sport_num);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				MatchdateBean bean = new MatchdateBean();
				bean.setMATCH_DATE_NUM(rs.getInt(1));
				bean.setSTADIUM_NUM(rs.getInt(2));
				bean.setMATCH_DATE(rs.getString(3));
				bean.setTEAM_NUM1(rs.getInt(4));
				bean.setTEAM_NUM2(rs.getInt(5));
				vlist.addElement(bean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}
	
	public String getstadiumName(int match_date_num) {
	    Connection con = null;
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;
	    String sql = null;
	    String stadiumName = null;
	    try {
	        con = pool.getConnection();
	        sql = "SELECT s.STADIUM_NAME " +
	              "FROM matchdate m " +
	              "JOIN stadium s ON m.STADIUM_NUM = s.STADIUM_NUM "
	              + "WHERE m.MATCH_DATE_NUM = ?" ;
	        pstmt = con.prepareStatement(sql);
	        pstmt.setInt(1, match_date_num);
	        rs = pstmt.executeQuery();
	        if (rs.next()) {
	        	stadiumName = rs.getString(1);
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    } finally {
	        pool.freeConnection(con, pstmt, rs);
	    }
	    return stadiumName;
	}

}
