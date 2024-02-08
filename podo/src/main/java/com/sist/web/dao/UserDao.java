package com.sist.web.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import com.sist.web.db.DBManager;
import com.sist.web.model.User;

public class UserDao {
	private static Logger logger = LogManager.getLogger(UserDao.class);
	
	//1. 아이디 중복체크
	public int userIdSelectCount(String userId){
		int count = 0;
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		StringBuilder sql = new StringBuilder();
		//sql을 문자열로 만들기
		sql.append("SELECT COUNT(USER_ID) CNT ");
		sql.append(" FROM P_USER ");
		sql.append(" WHERE USER_ID = ? ");
		
		try{
		    conn = DBManager.getConnection();
		    pstmt = conn.prepareStatement(sql.toString());
		    pstmt.setString(1, userId);	//첫번째 ?에 userId를 셋팅
		    
		    rs = pstmt.executeQuery(); //query 실행 후 그 결과값을 rs에 저장
		    
		    if(rs.next()){				//결과값 불러오기
		    	count = rs.getInt("CNT");
		    }
		}catch (Exception e){
			logger.error("[UserDao] userIdSelectCount SQLException", e);
		}finally{
			DBManager.close(rs, pstmt, conn);
		}
		return count;
	}
	
	//2. 사용자 등록
	public int userInsert(User user){
		int count = 0;
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		StringBuilder sql = new StringBuilder();
		
		sql.append("INSERT INTO P_USER ");
		sql.append(" (USER_ID, USER_PWD, USER_NAME, USER_EMAIL, USER_PHONE, ZIPCODE, ADDR1, ADDR2, USER_STATUS, USER_FLAG) ");
		sql.append(" VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?, ?) ");

		try{
			int idx = 0;
		    conn = DBManager.getConnection();
		    pstmt = conn.prepareStatement(sql.toString());
		    
		    pstmt.setString(++idx, user.getUserId());	
		    pstmt.setString(++idx, user.getUserPwd());	
		    pstmt.setString(++idx, user.getUserName());	
		    pstmt.setString(++idx, user.getUserEmail());	
		    pstmt.setString(++idx, user.getUserPhone());	
		    pstmt.setString(++idx, user.getZipcode());	
		    pstmt.setString(++idx, user.getAddr1());	
		    pstmt.setString(++idx, user.getAddr2());	
		    pstmt.setString(++idx, user.getUserStatus());	
		    pstmt.setString(++idx, user.getUserFlag());	

		    count = pstmt.executeUpdate(); //user객체를 반환해주고 나머지는 INT형으로 표현해서 SQL성공시 0이상을 보내주는 방식을 표현
		}catch (Exception e){
			logger.error("[UserDao] userInsert SQLException", e);
		}finally{
			DBManager.close(pstmt, conn);
		}
		return count;
	}
	
	//3.사용자 조회
	public User userSelect(String userId){
		User user = null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		StringBuilder sql = new StringBuilder();
		
		sql.append("SELECT USER_ID, ");
	    sql.append("	   NVL(USER_PWD, '') USER_PWD, ");
	    sql.append("       NVL(USER_NAME, '') USER_NAME, ");
	    sql.append("       NVL(USER_EMAIL, '') USER_EMAIL, ");
	    sql.append("       NVL(USER_PHONE, '') USER_PHONE, ");
	    sql.append("       NVL(ZIPCODE, '') ZIPCODE, ");
	    sql.append("       NVL(ADDR1, '') ADDR1, ");
	    sql.append("       NVL(ADDR2, '') ADDR2, ");
	    sql.append("       NVL(USER_STATUS, 'Y') USER_STATUS, ");
	    sql.append("       NVL(USER_FLAG, 'U') USER_FLAG ");
	    sql.append("FROM P_USER ");
	    sql.append("WHERE USER_ID = ? ");

	    
	    try{
		    conn = DBManager.getConnection(); // 공통모듈 사용
		    pstmt = conn.prepareStatement(sql.toString());
		    pstmt.setString(1, userId);
		    
		    logger.debug("userId : " + userId);
		    logger.debug("sqlTostring() : " +  sql.toString());
		    rs = pstmt.executeQuery();  //단일레코드니까 for문 말고 if로 감싼다
	    	
		    if(rs.next()){
	    		user = new User();
	    		
	    		user.setUserId(rs.getString("USER_ID"));
	    		user.setUserPwd(rs.getString("USER_PWD"));
	    		user.setUserName(rs.getString("USER_NAME"));
	    		user.setUserEmail(rs.getString("USER_EMAIL"));
	    		user.setUserPhone(rs.getString("USER_PHONE"));
	    		user.setZipcode(rs.getString("ZIPCODE"));
	    		user.setAddr1(rs.getString("ADDR1"));
	    		user.setAddr2(rs.getString("ADDR2"));
	    		user.setUserStatus(rs.getString("USER_STATUS"));
	    		user.setUserFlag(rs.getString("USER_FLAG"));
	    	}
	    }catch(Exception e){
	    	logger.error("[UserDao] userSelect SQLException", e);
	    	
	    }finally{
	    	DBManager.close(rs, pstmt, conn);
	    }
		return user;
	}
	
	//4. ID찾기
	public String userFindId(String userName, String userEmail){
		String id = null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		StringBuilder sql = new StringBuilder();
		
		sql.append("SELECT USER_ID ");
	    sql.append(" FROM P_USER ");
	    sql.append(" WHERE USER_NAME = ? ");
	    sql.append(" AND USER_EMAIL = ? ");

	    try{
		    conn = DBManager.getConnection(); // 공통모듈 사용
		    pstmt = conn.prepareStatement(sql.toString());
		    pstmt.setString(1, userName);
		    pstmt.setString(2, userEmail);
		    
		    rs = pstmt.executeQuery();  //단일레코드니까 for문 말고 if로 감싼다
		    while(rs.next()) {
		    	id = rs.getString("USER_ID");
		    }
	    }catch(Exception e){
	    	logger.error("[UserDao] userSelect SQLException", e);
	    	
	    }finally{
	    	DBManager.close(rs, pstmt, conn);
	    }
		return id;
	}
	
	//5.비밀번호 재설정
	public int userUpdatePwd(User user){
		int count = 0;
		Connection conn = null;
		PreparedStatement pstmt = null; 
		StringBuilder sql = new StringBuilder();
	
		sql.append("UPDATE P_USER  ");
		sql.append(" SET USER_PWD = ? ");
		sql.append(" WHERE USER_ID = ? ");
		sql.append(" AND USER_EMAIL = ? ");
		
		try{
			int idx = 0;
			conn = DBManager.getConnection();
			pstmt = conn.prepareStatement(sql.toString()); 
			
			pstmt.setString(++idx, user.getUserPwd());
			pstmt.setString(++idx, user.getUserId());
			pstmt.setString(++idx, user.getUserEmail());

			count = pstmt.executeUpdate();
		} catch(Exception e) {
			logger.error("[UserDao] userUpdate SQLException", e);
		} finally {
			DBManager.close(pstmt, conn);
		}
		return count;
	}
	
	//7.회원정보수정
	public int userUpdate(User user){
		int count = 0;
		Connection conn = null;
		PreparedStatement pstmt = null; 
		StringBuilder sql = new StringBuilder();
	
		sql.append("UPDATE P_USER SET ");
		sql.append(" USER_PWD = ?, ");
		sql.append(" USER_NAME = ?, ");
		sql.append(" USER_EMAIL = ?, ");
		sql.append(" USER_PHONE = ?, ");
		sql.append(" ZIPCODE = ?, ");
		sql.append(" ADDR1 = ?, ");
		sql.append(" ADDR2 = ? ");
		sql.append(" WHERE USER_ID = ? ");
		
		try{
			int idx = 0;
			conn = DBManager.getConnection();
			pstmt = conn.prepareStatement(sql.toString()); 
			
			pstmt.setString(++idx, user.getUserPwd());
			pstmt.setString(++idx, user.getUserName());
			pstmt.setString(++idx, user.getUserEmail());
			pstmt.setString(++idx, user.getUserPhone());
			pstmt.setString(++idx, user.getZipcode());
			pstmt.setString(++idx, user.getAddr1());
			pstmt.setString(++idx, user.getAddr2());
			pstmt.setString(++idx, user.getUserId());

			count = pstmt.executeUpdate();
		} catch(Exception e) {
			logger.error("[UserDao] userUpdate SQLException", e);
		} finally {
			DBManager.close(pstmt, conn);
		}
		return count;
	}
	
	//8.회원탈퇴
	public int userResign(User user){
		int count = 0;
		Connection conn = null;
		PreparedStatement pstmt = null; 
		StringBuilder sql = new StringBuilder();
	
		sql.append("UPDATE P_USER SET ");
		sql.append(" USER_STATUS = 'N' ");
		sql.append(" WHERE USER_ID = ? ");
		
		try{
			conn = DBManager.getConnection();
			pstmt = conn.prepareStatement(sql.toString()); 
			
			pstmt.setString(1, user.getUserId());

			count = pstmt.executeUpdate();
		} catch(Exception e) {
			logger.error("[UserDao] userUpdate SQLException", e);
		} finally {
			DBManager.close(pstmt, conn);
		}
		return count;
	}
}
