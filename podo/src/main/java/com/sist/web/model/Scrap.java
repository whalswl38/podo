package com.sist.web.model;

public class Scrap {
	private int scrapSeq;
	private int jobSeq;
	private String userId;
	private String jobTitle;
	private String userName;
	private String regDate;
	private String expDate;
	private String jobHits;
	private String expFlag;
	private String scrapYn;
	
	public Scrap() {
		scrapSeq = 0;
		jobSeq = 0;
		userId = "";
	}

	public int getScrapSeq() {
		return scrapSeq;
	}

	public void setScrapSeq(int scrapSeq) {
		this.scrapSeq = scrapSeq;
	}

	public int getJobSeq() {
		return jobSeq;
	}

	public void setJobSeq(int jobSeq) {
		this.jobSeq = jobSeq;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getJobTitle() {
		return jobTitle;
	}

	public void setJobTitle(String jobTitle) {
		this.jobTitle = jobTitle;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getRegDate() {
		return regDate;
	}

	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}

	public String getExpDate() {
		return expDate;
	}

	public void setExpDate(String expDate) {
		this.expDate = expDate;
	}

	public String getJobHits() {
		return jobHits;
	}

	public void setJobHits(String jobHits) {
		this.jobHits = jobHits;
	}

	public String getExpFlag() {
		return expFlag;
	}

	public void setExpFlag(String expFlag) {
		this.expFlag = expFlag;
	}

	public String getScrapYn() {
		return scrapYn;
	}

	public void setScrapYn(String scrapYn) {
		this.scrapYn = scrapYn;
	}
	
	
}
