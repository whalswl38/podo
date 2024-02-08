package com.sist.web.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import com.sist.common.util.StringUtil;
import com.sist.web.db.DBManager;
import com.sist.web.model.Board;
import com.sist.web.model.User;

public class BoardDao {
	private static Logger logger = LogManager.getLogger(BoardDao.class);
	//기업회원 공고목록 조회 
	public List<Board> comJobList(Board board) {
		List<Board> list = new ArrayList<Board>();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		StringBuilder sql = new StringBuilder();
		
		sql.append("SELECT JOB_SEQ, "); 
		sql.append("       JOB_TITLE, "); 
		sql.append("       USER_NAME, "); 
		sql.append("       REG_DATE, "); 
		sql.append("       EXP_DATE, "); 
		sql.append("       JOB_HITS, "); 
		sql.append("       EXP_FLAG "); 
		sql.append(" FROM (SELECT ROWNUM AS RNUM, "); 
		sql.append("              JOB_SEQ, "); 
		sql.append("              JOB_TITLE, "); 
		sql.append("              USER_NAME, "); 
		sql.append("              REG_DATE, "); 
		sql.append("              EXP_DATE, "); 
		sql.append("              JOB_HITS, "); 
		sql.append("              EXP_FLAG "); 
		sql.append("       FROM (SELECT A.JOB_SEQ JOB_SEQ, "); 
		sql.append("                    NVL(A.JOB_TITLE, '') JOB_TITLE, "); 
		sql.append("                    NVL(B.USER_NAME, '') USER_NAME, "); 
		sql.append("                    NVL(TO_CHAR(A.REG_DATE,'YYYY-MM-DD'),  '') REG_DATE, "); 
		sql.append("                    NVL(TO_CHAR(A.EXP_DATE,'YYYY-MM-DD'), '') EXP_DATE,  "); 
		sql.append("                    NVL(A.JOB_HITS, 0) JOB_HITS, "); 
		sql.append("                    NVL(A.EXP_FLAG, 'N') EXP_FLAG "); 
		sql.append("             FROM P_JOB A, P_USER B "); 
		sql.append("             WHERE A.USER_ID = B.USER_ID "); 
		sql.append("             AND A.USER_ID = ? ");

		if(board != null) {
			if(!StringUtil.isEmpty(board.getJobFlag())) {
				sql.append("     AND A.JOB_FLAG = ? "); 
			}
			
			if(!StringUtil.isEmpty(board.getJobTitle())) {
				sql.append("     AND A.JOB_TITLE LIKE '%' || ? || '%' "); 
			}
			
			if(!StringUtil.isEmpty(board.getJobContent())) {
				sql.append("     AND A.JOB_CONTENT LIKE '%' || ? || '%' "); 
			}
		}
		sql.append("             ORDER BY A.JOB_SEQ DESC)) "); 
		
		if(board != null) {
		sql.append(" WHERE RNUM BETWEEN ? AND  ? "); 
		}
		
		try {
			 int idx = 0;
			 conn = DBManager.getConnection();
			 pstmt = conn.prepareStatement(sql.toString());
			 
			 pstmt.setString(++idx, board.getUserId());
			 logger.info("id = "+board.getUserId());
			 if(board != null) {
				 if(!StringUtil.isEmpty(board.getJobFlag())) {
					 pstmt.setString(++idx, board.getJobFlag());
				 }
				 
				 if(!StringUtil.isEmpty(board.getJobTitle())) {
					 pstmt.setString(++idx, board.getJobTitle());
				 }
				 
				 if(!StringUtil.isEmpty(board.getJobContent())) {
					 pstmt.setString(++idx, board.getJobContent());
				 }
				 
				 pstmt.setInt(++idx, board.getStartRow());
				 pstmt.setInt(++idx, board.getEndRow());
				 
				 logger.info("RnStart = " + board.getStartRow());
				 logger.info("RnEnd = " + board.getEndRow());
			 }
			 
			 logger.debug("===================================");
			 logger.debug("sql : " + sql.toString());
			 logger.debug("===================================");
			 
			 rs = pstmt.executeQuery();
			 
			 logger.info("시작전 = " + rs.getRow());
			 while(rs.next()) {
				 Board board2 = new Board();
				 
				 board2.setJobSeq(rs.getInt("JOB_SEQ"));
				 board2.setJobTitle(rs.getString("JOB_TITLE"));
				 board2.setUserName(rs.getString("USER_NAME"));
				 board2.setRegDate(rs.getString("REG_DATE"));
				 board2.setExpDate(rs.getString("EXP_DATE"));
				 board2.setJobHits(rs.getInt("JOB_HITS"));
				 board2.setExpFlag(rs.getString("EXP_FLAG"));

				 logger.info("board2 = " + board2);
				 
				 list.add(board2);
				 
				 logger.info("list = " + list.get(0));
			 }
		} catch (Exception e) {
			logger.error("[BoardDao] comJobList SQLException", e);
		} finally {
			DBManager.close(rs, pstmt, conn);
		}
		return list;
	}
	
	//개인회원 공고목록 조회
	public List<Board> userJobList(Board board) {
		List<Board> list = new ArrayList<Board>();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		StringBuilder sql = new StringBuilder();
		
		//페이징 초기 처리를 위한 start, endRow 셋팅
		//if(board.getRnStart() == 0) {
		//	board.setRnStart(1);
		//	board.setRnEnd(10);
		//}
		
		sql.append("SELECT A.JOB_SEQ, "); 
		sql.append("       A.JOB_TITLE, "); 
		sql.append("       A.USER_NAME, "); 
		sql.append("       A.REG_DATE, "); 
		sql.append("       A.EXP_DATE, "); 
		sql.append("       A.JOB_HITS, "); 
		sql.append("       A.EXP_FLAG, "); 
		sql.append("       NVL2(B.JOB_SEQ, 'Y', 'N') as SCRAP_YN "); 
		sql.append(" FROM (SELECT ROWNUM AS RNUM, "); 
		sql.append("              JOB_SEQ, "); 
		sql.append("              JOB_TITLE, "); 
		sql.append("              USER_NAME, "); 
		sql.append("              REG_DATE, "); 
		sql.append("              EXP_DATE, "); 
		sql.append("              JOB_HITS, "); 
		sql.append("              EXP_FLAG "); 
		sql.append("       FROM (SELECT A.JOB_SEQ JOB_SEQ, "); 
		sql.append("                    NVL(A.JOB_TITLE, '') JOB_TITLE, "); 
		sql.append("                    NVL(B.USER_NAME, '') USER_NAME, "); 
		sql.append("                    NVL(TO_CHAR(A.REG_DATE,'YYYY-MM-DD'),  '') REG_DATE, "); 
		sql.append("                    NVL(TO_CHAR(A.EXP_DATE,'YYYY-MM-DD'), '') EXP_DATE,  "); 
		sql.append("                    NVL(A.JOB_HITS, 0) JOB_HITS, "); 
		sql.append("                    NVL(A.EXP_FLAG, 'N') EXP_FLAG "); 
		sql.append("             FROM P_JOB A, P_USER B "); 
		sql.append("             WHERE A.USER_ID = B.USER_ID "); 
	
		if(board != null) {
			if(!StringUtil.isEmpty(board.getJobFlag())) {
				sql.append("     AND A.JOB_FLAG LIKE '%' || ? || '%' "); 
			}
			
			if(!StringUtil.isEmpty(board.getJobTitle())) {
				sql.append("     AND A.JOB_TITLE LIKE '%' || ? || '%' "); 
			}
			
			if(!StringUtil.isEmpty(board.getJobContent())) {
				sql.append("     AND A.JOB_CONTENT LIKE '%' || ? || '%' "); 
			}
		}
		sql.append("             ORDER BY A.JOB_SEQ DESC)) A, P_SCRAP B "); 
		
		if(board != null) {
			sql.append(" WHERE A.JOB_SEQ =  B.JOB_SEQ(+) AND RNUM BETWEEN ? AND  ?  ORDER BY RNUM"); 
		}
		
		try {
			 int idx = 0;
			 conn = DBManager.getConnection();
			 pstmt = conn.prepareStatement(sql.toString());
			 
			 if(board != null) {
				 if(!StringUtil.isEmpty(board.getJobFlag())) {
					 pstmt.setString(++idx, board.getJobFlag());
				 }
				 
				 if(!StringUtil.isEmpty(board.getJobTitle())) {
					 pstmt.setString(++idx, board.getJobTitle());
				 }
				 
				 if(!StringUtil.isEmpty(board.getJobContent())) {
					 pstmt.setString(++idx, board.getJobContent());
				 }
				 
				 pstmt.setInt(++idx, board.getStartRow());
				 pstmt.setInt(++idx, board.getEndRow());
				 logger.info("RnStart = " + board.getStartRow());
				 logger.info("RnEnd = " + board.getEndRow());
			 }
			 
			 logger.debug("===================================");
			 logger.debug("sql : " + sql.toString());
			 logger.debug("===================================");
			 rs = pstmt.executeQuery();
			 logger.info("시작전 = " + rs.getRow());
			 while(rs.next()) {
				 Board board2 = new Board();
				 
				 board2.setJobSeq(rs.getInt("JOB_SEQ"));
				 board2.setJobTitle(rs.getString("JOB_TITLE"));
				 board2.setUserName(rs.getString("USER_NAME"));
				 board2.setRegDate(rs.getString("REG_DATE"));
				 board2.setExpDate(rs.getString("EXP_DATE"));
				 board2.setJobHits(rs.getInt("JOB_HITS"));
				 board2.setExpFlag(rs.getString("EXP_FLAG"));
				 board2.setScrapYn(rs.getString("SCRAP_YN"));

				 logger.info("board2 = " + board2);
				 list.add(board2);
				 
				 logger.info("list = " + list.get(0));
			 }
		} catch (Exception e) {
			logger.error("[BoardDao] boardList SQLException", e);
		} finally {
			DBManager.close(rs, pstmt, conn);
		}
		return list;
	}
	
	//기업회원 공고 등록
	public int jobInsert(Board board) {
		int count = 0;
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		StringBuilder sql = new StringBuilder();
		
		sql.append("INSERT INTO P_JOB "); 
		sql.append(" (JOB_SEQ, JOB_TITLE, USER_ID, EXP_DATE, JOB_FLAG, "); 
		sql.append(" CAR_FLAG, SCHO_FLAG, RECRU_NUM, WORKER_FLAG, JOB_SAL, JOB_AREA, JOB_CONTENT) "); 
		sql.append(" VALUES "); 
		sql.append(" (?, ?, ?, ?, ?, "); 
		sql.append(" ?, ?, ?, ?, ?, ?, ?) "); 
		try {
			int idx = 0;
			int jobSeq = 0;
			conn = DBManager.getConnection();
			
			jobSeq = setJobSeq(conn);
			board.setJobSeq(jobSeq);

			pstmt = conn.prepareStatement(sql.toString());
			
			pstmt.setInt(++idx, board.getJobSeq());
			pstmt.setString(++idx, board.getJobTitle());
			pstmt.setString(++idx, board.getUserId());
			pstmt.setString(++idx, board.getExpDate());
			pstmt.setString(++idx, board.getJobFlag());
			pstmt.setString(++idx, board.getCarFlag());
			pstmt.setString(++idx, board.getSchoFlag());
			pstmt.setInt(++idx, board.getRecruNum());
			pstmt.setString(++idx, board.getWorkerFlag());
			pstmt.setString(++idx, board.getJobSal());
			pstmt.setString(++idx, board.getJobArea());
			pstmt.setString(++idx, board.getJobContent());

			count = pstmt.executeUpdate();
			if(count != 1) {
				logger.error("[BoardDao] jobInsert Fail : "  + count);
			}
		} catch (Exception e) {
			logger.error("[BoardDao] jobInsert SQLException", e);
		} finally {
			DBManager.close(pstmt, conn);
		}
		return count;
	}
	
	//공고 시퀀스 조회
	private int setJobSeq(Connection conn) {
		int jobSeq = 0;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		StringBuilder sql = new StringBuilder();
		
		sql.append("SELECT SEQ_P_JOB_SEQ.NEXTVAL FROM DUAL "); 

		try {
			pstmt = conn.prepareStatement(sql.toString());
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				jobSeq = rs.getInt(1);
			}
			
		} catch (Exception e) {
			logger.error("[BoardDao] setJobSeq SQLException", e);
		} finally {
			DBManager.close(rs, pstmt);
		}
		return jobSeq;
	}
	
	//총 공고 수 조회
	public int jobTotalCount(Board board) {
		int totalCount = 0;
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		StringBuilder sql = new StringBuilder();
		
		sql.append("SELECT COUNT(A.JOB_SEQ) AS TOTAL_COUNT "); 
		sql.append(" FROM P_JOB A, P_USER B "); 
		sql.append(" WHERE A.USER_ID = B.USER_ID "); 
		
		if(board != null) {
			if(!StringUtil.isEmpty(board.getJobFlag())) {
				sql.append(" AND A.JOB_FLAG LIKE '%' || ? || '%' "); 
			}
			
			if(!StringUtil.isEmpty(board.getJobTitle())) {
				sql.append(" AND A.JOB_TITLE LIKE '%' || ? || '%' "); 
			}
			
			if(!StringUtil.isEmpty(board.getJobContent())) {
				sql.append(" AND DBMS_LOB.INSTR(A.JOB_CONTENT, ?) > 0 "); 
			}
		}
		
		try {
			int idx = 0;

			conn = DBManager.getConnection();
			pstmt = conn.prepareStatement(sql.toString());
			
			if(board != null) {
				if(!StringUtil.isEmpty(board.getJobFlag())) {
					 pstmt.setString(++idx, board.getJobFlag());
				 }
				 
				 if(!StringUtil.isEmpty(board.getJobTitle())) {
					 pstmt.setString(++idx, board.getJobTitle());
				 }
				 
				 if(!StringUtil.isEmpty(board.getJobContent())) {
					 pstmt.setString(++idx, board.getJobContent());
				 }
			}
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				totalCount = rs.getInt("TOTAL_COUNT");
			}
			
		} catch (Exception e) {
			logger.error("[BoardDao] jobTotalCount SQLException", e);
		} finally {
			DBManager.close(rs, pstmt, conn);
		}
		return totalCount;
	}
	
	//공고 상세보기(detail)
	public Board jobDetail(int jobSeq){
		Board board = null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		StringBuilder sql = new StringBuilder();
		
		sql.append(" SELECT A.JOB_TITLE, B.USER_NAME, TO_CHAR(A.REG_DATE,'YYYY-MM-DD') 	AS REG_DATE, TO_CHAR(A.EXP_DATE,'YYYY-MM-DD') AS EXP_DATE, A.JOB_FLAG, A.CAR_FLAG, A.SCHO_FLAG, ");		
		sql.append(" A.RECRU_NUM, A.WORKER_FLAG, A.JOB_SAL, A.JOB_AREA, A.JOB_CONTENT, ");		
		sql.append(" B.USER_EMAIL, B.USER_PHONE, B.ZIPCODE, B.ADDR1, B.ADDR2, A.USER_ID ");		
		sql.append(" FROM P_JOB A, P_USER B ");		
		sql.append(" WHERE A.USER_ID = B.USER_ID ");		
		sql.append(" AND A.JOB_SEQ = ? ");		
		
		try {
			conn = DBManager.getConnection();
			pstmt = conn.prepareStatement(sql.toString());
			
			pstmt.setInt(1, jobSeq);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				board = new Board();
				board.setJobTitle(rs.getString("JOB_TITLE"));
				board.setUserName(rs.getString("USER_NAME"));
				board.setRegDate(rs.getString("REG_DATE"));
				board.setExpDate(rs.getString("EXP_DATE"));
				board.setJobFlag(rs.getString("JOB_FLAG"));
				board.setCarFlag(rs.getString("CAR_FLAG"));
				board.setSchoFlag(rs.getString("SCHO_FLAG"));
				board.setRecruNum(rs.getInt("RECRU_NUM"));
				board.setWorkerFlag(rs.getString("WORKER_FLAG"));
				board.setJobSal(rs.getString("JOB_SAL"));
				board.setJobArea(rs.getString("JOB_AREA"));
				board.setJobContent(rs.getString("JOB_CONTENT"));
				board.setUserEmail(rs.getString("USER_EMAIL"));
				board.setUserPhone(rs.getString("USER_PHONE"));
				board.setZipcode(rs.getString("ZIPCODE"));
				board.setAddr1(rs.getString("ADDR1"));
				board.setAddr2(rs.getString("ADDR2"));
				board.setUserId(rs.getString("USER_ID"));
			}
			return board;

		} catch (Exception e) {
			logger.error("[BoardDao] jobDetail SQLException", e);
		} finally {
			DBManager.close(rs, pstmt, conn);
		}
		return board;
	}
	
	//조회수 증가
		public int jobReadCntPlus(int jobSeq) {   
			int count = 0;
			Connection conn = null;
			PreparedStatement pstmt = null; 
			StringBuilder sql = new StringBuilder();
	        
	        sql.append(" UPDATE P_JOB SET JOB_HITS = (JOB_HITS+1) WHERE JOB_SEQ = ? ");	
	        
	        try {
	        	conn = DBManager.getConnection();
				pstmt = conn.prepareStatement(sql.toString()); 

				pstmt.setInt(1, jobSeq);
				
	            count = pstmt.executeUpdate();
	            
	        } catch (Exception e) {
	        	logger.error("[BoardDao] jobReadCntPlus SQLException", e);
			} finally {
				DBManager.close(pstmt, conn);
			}
	        return count;
	    }
	
	//공고 수정
	public int jobUpdate(Board board) {  
		int count = 0;
		
		Connection conn = null;
		PreparedStatement pstmt = null; 
		StringBuilder sql = new StringBuilder();
		
		sql.append(" UPDATE P_JOB ");
		sql.append(" SET  JOB_TITLE = ?, ");
		sql.append(" EXP_DATE = ?, ");
		sql.append(" JOB_FLAG = ?, ");
		sql.append(" CAR_FLAG = ?, ");
		sql.append(" SCHO_FLAG = ?, ");
		sql.append(" RECRU_NUM = ?,  ");
		sql.append(" WORKER_FLAG = ?, ");
		sql.append(" JOB_SAL = ?, ");
		sql.append(" JOB_AREA = ?, ");
		sql.append(" JOB_CONTENT = ? ");
		sql.append(" WHERE JOB_SEQ = ? ");
		
		try {
			int idx = 0;
			conn = DBManager.getConnection();
			pstmt = conn.prepareStatement(sql.toString());
			
			pstmt.setString(++idx, board.getJobTitle());
			pstmt.setString(++idx, board.getExpDate());
			pstmt.setString(++idx, board.getJobFlag());
			pstmt.setString(++idx, board.getCarFlag());
			pstmt.setString(++idx, board.getSchoFlag());
			pstmt.setInt(++idx, board.getRecruNum());
			pstmt.setString(++idx, board.getWorkerFlag());
			pstmt.setString(++idx, board.getJobSal());
			pstmt.setString(++idx, board.getJobArea());
			pstmt.setString(++idx, board.getJobContent());
			pstmt.setInt(++idx, board.getJobSeq());

			count = pstmt.executeUpdate();
		} catch (Exception e) {
			logger.error("[BoardDao] boardUpdate SQLException", e);
		} finally {
			DBManager.close(pstmt, conn);
		}
		return count;
	}
	
	//공고 삭제
	public int jobDelete(int jobSeq) {  
		int count = 0;
		Connection conn = null;
		PreparedStatement pstmt = null; 
		StringBuilder sql = new StringBuilder();
		
		sql.append(" DELETE FROM P_JOB WHERE JOB_SEQ = ? ");
		
        try {
        	conn = DBManager.getConnection();
			pstmt = conn.prepareStatement(sql.toString()); 

			pstmt.setLong(1, jobSeq);
			
            count = pstmt.executeUpdate();
            
        } catch (Exception e) {
        	logger.error("[UserDao] jobDelete SQLException", e);
		} finally {
			DBManager.close(pstmt, conn);
		}
		return count;
	}
	
	//마감여부 수정(스레드용/ 날짜 지나면 마감여부 'Y'로 바뀜)
	public int expFlagUpdate(String date){
		int count = 0;
		Connection conn = null;
		PreparedStatement pstmt = null; 
		StringBuilder sql = new StringBuilder();
	
		sql.append("UPDATE P_JOB  ");
		sql.append(" SET EXP_FLAG = 'Y' ");
		sql.append(" WHERE EXP_DATE < ? ");
		sql.append(" AND EXP_FLAG = 'N' ");
		
		try{
			conn = DBManager.getConnection();
			pstmt = conn.prepareStatement(sql.toString()); 
			
			pstmt.setString(1, date);

			count = pstmt.executeUpdate();
		} catch(Exception e) {
			logger.error("[UserDao] userUpdate SQLException", e);
		} finally {
			DBManager.close(pstmt, conn);
		}
		return count;
	}
	
	//마감여부 수정(스레드용/ 날짜 수정해서 날짜 안지났으면 마감여부 'N'로 바뀜)
	public int expFlagUpdate2(String date){
		int count = 0;
		Connection conn = null;
		PreparedStatement pstmt = null; 
		StringBuilder sql = new StringBuilder();
	
		sql.append("UPDATE P_JOB  ");
		sql.append(" SET EXP_FLAG = 'N' ");
		sql.append(" WHERE EXP_DATE > ? ");
		
		try{
			conn = DBManager.getConnection();
			pstmt = conn.prepareStatement(sql.toString()); 
			
			pstmt.setString(1, date);

			count = pstmt.executeUpdate();
		} catch(Exception e) {
			logger.error("[UserDao] userUpdate SQLException", e);
		} finally {
			DBManager.close(pstmt, conn);
		}
		return count;
	}
	
}
