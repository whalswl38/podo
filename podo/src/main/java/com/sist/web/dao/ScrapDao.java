package com.sist.web.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import com.sist.web.db.DBManager;
import com.sist.web.model.Board;
import com.sist.web.model.Scrap;

public class ScrapDao {
	private static Logger logger = LogManager.getLogger(ScrapDao.class);

	// ajax 체크용
	public int selectScrap(String jobSeq, String userId) {
		int  cnt = 0;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		StringBuilder sql = new StringBuilder();
		// sql을 문자열로 만들기
		sql.append("SELECT COUNT(*) as CNT ");
		sql.append(" FROM P_SCRAP ");
		sql.append(" WHERE JOB_SEQ = ? AND USER_ID = ? ");
		try {
			conn = DBManager.getConnection();
			pstmt = conn.prepareStatement(sql.toString());
			pstmt.setString(1, jobSeq); 
			pstmt.setString(2, userId); 

			rs = pstmt.executeQuery(); 
			while(rs.next()) {
				cnt = Integer.valueOf(rs.getString("cnt"));
			}
		} catch (Exception e) {
			logger.error("[UserDao] userIdSelectCount SQLException", e);
		} finally {
			DBManager.close(rs, pstmt, conn);
		}
		return cnt;
	}
	
	//스크랩 목록에 추가
	public int insertScrap(String jobSeq, String userId) {
		int cnt = 0;
		Connection conn = null;
		PreparedStatement pstmt = null;
		StringBuilder sql = new StringBuilder();
		// sql을 문자열로 만들기
		sql.append("INSERT INTO P_SCRAP(JOB_SEQ, USER_ID) ");
		sql.append(" VALUES(?, ?)");
		try {
			conn = DBManager.getConnection();
			pstmt = conn.prepareStatement(sql.toString());
			pstmt.setString(1, jobSeq); // 첫번째 ?에 userId를 셋팅
			pstmt.setString(2, userId); // 첫번째 ?에 userId를 셋팅

			cnt = pstmt.executeUpdate(); // query 실행 후 그 결과값을 rs에 저장

		} catch (Exception e) {
			logger.error("[UserDao] userIdSelectCount SQLException", e);
		} finally {
			DBManager.close(pstmt, conn);
		}
		return cnt;
	}

	//스크랩 목록에서 제거
	public int deleteScrap(String jobSeq, String userId) {
		int cnt = 0;
		Connection conn = null;
		PreparedStatement pstmt = null;
		StringBuilder sql = new StringBuilder();
		// sql을 문자열로 만들기
		sql.append("DELETE FROM P_SCRAP");
		sql.append(" WHERE JOB_SEQ = ? AND USER_ID = ? ");
		try {
			conn = DBManager.getConnection();
			pstmt = conn.prepareStatement(sql.toString());
			pstmt.setString(1, jobSeq); // 첫번째 ?에 userId를 셋팅
			pstmt.setString(2, userId); // 첫번째 ?에 userId를 셋팅

			cnt = pstmt.executeUpdate(); // query 실행 후 그 결과값을 rs에 저장

		} catch (Exception e) {
			logger.error("[UserDao] userIdSelectCount SQLException", e);
		} finally {
			DBManager.close(pstmt, conn);
		}
		return cnt;
	}
	
	//스크랩 목록 가져오기
	public List<Scrap> selectScrapList(Scrap scrap) {
		List<Scrap> list = new ArrayList<Scrap>();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		StringBuilder sql = new StringBuilder();
		
		sql.append("SELECT A.JOB_SEQ, 									"); 
		sql.append("       A.JOB_TITLE, 								"); 
		sql.append("       B.USER_NAME, 								"); 
		sql.append("       TO_CHAR(A.REG_DATE,'YYYY-MM-DD') REG_DATE, "); 
		sql.append("       TO_CHAR(A.EXP_DATE,'YYYY-MM-DD') EXP_DATE, "); 
		sql.append("       A.JOB_HITS,  								"); 
		sql.append("       A.EXP_FLAG, 								 	"); 
		sql.append("       NVL2(C.JOB_SEQ,'Y','N') AS SCARP_YN 			"); 
		sql.append(" FROM P_JOB A, P_USER B, P_SCRAP C 					"); 
		sql.append(" WHERE A.USER_ID = B.USER_ID  					 	"); 
		sql.append(" AND A.JOB_SEQ = C.JOB_SEQ 							"); 
		sql.append(" AND C.USER_ID = ? ORDER BY A.JOB_SEQ 				"); 

		try {
			conn = DBManager.getConnection();
			pstmt = conn.prepareStatement(sql.toString());
			pstmt.setString(1, scrap.getUserId()); // 첫번째 ?에 userId를 셋팅

			rs = pstmt.executeQuery(); // query 실행 후 그 결과값을 rs에 저장
			while(rs.next()) {
				Scrap scrap2 = new Scrap();
				scrap2.setJobSeq(rs.getInt("JOB_SEQ"));
				scrap2.setJobTitle(rs.getString("JOB_TITLE"));
				scrap2.setUserName(rs.getString("USER_NAME"));
				scrap2.setRegDate(rs.getString("REG_DATE"));
				scrap2.setExpDate(rs.getString("EXP_DATE"));
				scrap2.setJobHits(rs.getString("JOB_HITS"));
				scrap2.setExpFlag(rs.getString("EXP_FLAG"));
				scrap2.setScrapYn(rs.getString("SCARP_YN"));
				list.add(scrap2);
				
			}
		} catch (Exception e) {
			logger.error("[UserDao] userIdSelectCount SQLException", e);
		} finally {
			DBManager.close(pstmt, conn);
		}
		return list;
	}
	
	
}
