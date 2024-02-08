package com.sist.date;

import java.net.DatagramSocket;
import java.net.SocketException;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import com.sist.web.dao.BoardDao;
import com.sist.web.dao.ScrapDao;

public class expireFlag extends Thread {
	private static Logger logger = LogManager.getLogger(ScrapDao.class);

	public synchronized void run() {
		synchronized (this) {
			try {
				//index 페이지 접근 시, 최초 4444번의 포트로 쓰레드 생성 및 실행
				//이후 index 페이지 다시 접근시, 4444포트가 사용중이기때문에 쓰레드 중복 실행불가
				// catch문으로 빠져서 끝남.
				DatagramSocket ds = new DatagramSocket(4444);
				System.out.println("Thread Begin  DATE : " + LocalDateTime.now());
				BoardDao boardDao = new BoardDao();
				//LocalDate now = LocalDate.now().minusDays(1); 
				LocalDate now = LocalDate.now(); 
				String diffDate = "";
				logger.info("11111111");
				while (true) {
					int cnt = 0;
					// 현재날짜구하기(시스템 시계)
					diffDate = now.format(DateTimeFormatter.ofPattern("YYYY/MM/DD"));
					logger.info("diffDate : " + diffDate);
					cnt = boardDao.expFlagUpdate(diffDate);
					logger.info("cnt : " + cnt);
					if (cnt > 0) {
						logger.info("Expire Count : " + cnt);
					}
					// 5초에 한번씩
					Thread.sleep(1000 * 5);
				}
			} catch (InterruptedException e ) {
				e.getStackTrace();
			} catch(SocketException e){
				//스레드가 실행되고 있는데 또 실행시 
				logger.error("동일한 스레드가 돌고 있습니다.");
			}
		}
	}
}
