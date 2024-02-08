package com.sist.web.model;

import java.io.Serializable;

public class Board implements Serializable {
	private static final long serialVersionUID = 1L;
	
	private int jobSeq;
	private String jobTitle = "";
	private String userId;
	private String regDate;
	private String updateDate;
	private String expDate;
	private int jobHits;
	private String expFlag;
	private String jobFlag;
	private String carFlag;
	private String schoFlag;
	private int recruNum;
	private String workerFlag;
	private String jobSal;
	private String jobArea;
	private String jobContent;
	private String userName;
	private String userEmail;
	private String userPhone;
	private String zipcode;
	private String addr1;
	private String addr2;
	private int startRow; 
	private int endRow; 
	private String scrapYn;
	
	
	

	public Board() {
		jobSeq = 0;
		jobTitle = "";
		userId = "";
		regDate = "";
		updateDate = "";
		expDate = "";
		jobHits = 0;
		expFlag = "N";
		jobFlag = "";
		carFlag = "";
		schoFlag = "";
		recruNum = 0;
		workerFlag = "";
		jobSal = "";
		jobArea = "";
		jobContent = "";
		userName = "";
		userEmail = "";
		userPhone = "";
		zipcode = "";
		addr1 = "";
		addr2 = "";
		startRow = 0;
		endRow = 0;
	}
	
	public int getJobSeq() {
		return jobSeq;
	}
	public void setJobSeq(int jobSeq) {
		this.jobSeq = jobSeq;
	}
	
	public String getJobTitle() {
		return jobTitle;
	}
	public void setJobTitle(String jobTitle) {
		this.jobTitle = jobTitle;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getRegDate() {
		return regDate;
	}
	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}
	public String getUpdateDate() {
		return updateDate;
	}
	public void setUpdateDate(String updateDate) {
		this.updateDate = updateDate;
	}
	public String getExpDate() {
		return expDate;
	}
	public void setExpDate(String expDate) {
		this.expDate = expDate;
	}
	public int getJobHits() {
		return jobHits;
	}
	public void setJobHits(int jobHits) {
		this.jobHits = jobHits;
	}
	public String getExpFlag() {
		return expFlag;
	}
	public void setExpFlag(String expFlag) {
		this.expFlag = expFlag;
	}
	public String getJobFlag() {
		return jobFlag;
	}
	public void setJobFlag(String jobFlag) {
		this.jobFlag = jobFlag;
	}
	public String getCarFlag() {
		return carFlag;
	}
	public void setCarFlag(String carFlag) {
		this.carFlag = carFlag;
	}
	public String getSchoFlag() {
		return schoFlag;
	}
	public void setSchoFlag(String schoFlag) {
		this.schoFlag = schoFlag;
	}
	public int getRecruNum() {
		return recruNum;
	}
	public void setRecruNum(int recruNum) {
		this.recruNum = recruNum;
	}
	public String getWorkerFlag() {
		return workerFlag;
	}
	public void setWorkerFlag(String workerFlag) {
		this.workerFlag = workerFlag;
	}
	public String getJobSal() {
		return jobSal;
	}
	public void setJobSal(String jobSal) {
		this.jobSal = jobSal;
	}
	public String getJobArea() {
		return jobArea;
	}
	public void setJobArea(String jobArea) {
		this.jobArea = jobArea;
	}
	public String getJobContent() {
		return jobContent;
	}
	public void setJobContent(String jobContent) {
		this.jobContent = jobContent;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public int getStartRow() {
		return startRow;
	}

	public void setStartRow(int startRow) {
		this.startRow = startRow;
	}

	public int getEndRow() {
		return endRow;
	}

	public void setEndRow(int endRow) {
		this.endRow = endRow;
	}

	public String getUserEmail() {
		return userEmail;
	}

	public void setUserEmail(String userEmail) {
		this.userEmail = userEmail;
	}

	public String getUserPhone() {
		return userPhone;
	}

	public void setUserPhone(String userPhone) {
		this.userPhone = userPhone;
	}

	public String getZipcode() {
		return zipcode;
	}

	public void setZipcode(String zipcode) {
		this.zipcode = zipcode;
	}

	public String getAddr1() {
		return addr1;
	}

	public void setAddr1(String addr1) {
		this.addr1 = addr1;
	}

	public String getAddr2() {
		return addr2;
	}

	public void setAddr2(String addr2) {
		this.addr2 = addr2;
	}
	public String getScrapYn() {
		return scrapYn;
	}
	public void setScrapYn(String scrapYn) {
		this.scrapYn = scrapYn;
	}
}
