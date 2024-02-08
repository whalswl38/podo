package com.sist.web.model;

import java.io.Serializable;

public class Paging implements Serializable {
	private static final long serialVersionUID = 1L;
	private int totalCount;	//총 게시물 수
	private int totalPage;		//총 페이지 수
	private int startRow;		//게시물 시작 row(oracle rownum)
	private int endRow;		//게시물 끝 row(oracle rownum)
	private int listCount;		//한 페이지의 게시물 수
	private int pageCount;		//페이징 범위 수
	private int curPage;		//현재 페이지

	private int startPage;		//시작 페이지 번호
	private int endPage;		//마지막 페이지 번호

	private int totalBlock;	//총 블럭 수
	private int curBlock;		//현재 블럭

	private int prevBlockPage;	//이전 블럭 페이지
	private int nextBlockPage;	//다음 블럭 페이지

	private int startNum;		//시작번호(게시물 번호 적용 desc)

	public Paging(int totalCount, int listCount, int pageCount, int curPage) {
		this.totalCount = totalCount;
		this.listCount = listCount;
		this.pageCount = pageCount;
		this.curPage = curPage;
		
		if(totalCount > 0) {
			pagingProc();
		}
	}

	public int getTotalCount() {
		return totalCount;
	}
	
	public void setTotalCount(int totalCount) {
		this.totalCount = totalCount;
	}
	
	public int getTotalPage() {
		return totalPage;
	}
	
	public void setTotalPage(int totalPage) {
		this.totalPage = totalPage;
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
	
	public int getListCount() {
		return listCount;
	}
	
	public void setListCount(int listCount) {
		this.listCount = listCount;
	}
	
	public int getPageCount() {
		return pageCount;
	}
	
	public void setPageCount(int pageCount) {
		this.pageCount = pageCount;
	}
	
	public int getCurPage() {
		return curPage;
	}
	
	public void setCurPage(int curPage) {
		this.curPage = curPage;
	}
	
	public int getStartPage() {
		return startPage;
	}
	
	public void setStartPage(int startPage) {
		this.startPage = startPage;
	}
	
	public int getEndPage() {
		return endPage;
	}
	
	public void setEndPage(int endPage) {
		this.endPage = endPage;
	}
	
	public int getTotalBlock() {
		return totalBlock;
	}
	
	public void setTotalBlock(int totalBlock) {
		this.totalBlock = totalBlock;
	}
	
	public int getCurBlock() {
		return curBlock;
	}
	
	public void setCurBlock(int curBlock) {
		this.curBlock = curBlock;
	}
	
	public int getPrevBlockPage() {
		return prevBlockPage;
	}
	
	public void setPrevBlockPage(int prevBlockPage) {
		this.prevBlockPage = prevBlockPage;
	}
	
	public int getNextBlockPage() {
		return nextBlockPage;
	}
	
	public void setNextBlockPage(int nextBlockPage) {
		this.nextBlockPage = nextBlockPage;
	}
	
	public int getStartNum() {
		return startNum;
	}
	
	public void setStartNum(int startNum) {
		this.startNum = startNum;
	}
	
	//페이징 계산 프로세스
		private void pagingProc() {
			//총 페이지 수 구함
			totalPage = (int)Math.ceil((double)totalCount / listCount);
			
			System.out.println("=====================================");
			System.out.println("totalCount : " + totalCount + ", listCount : " + listCount);
			System.out.println("totalPage : " + totalPage);
			System.out.println("=====================================");
			
			//총 블럭수를 구함
			totalBlock = (int)Math.ceil((double)totalPage / pageCount);
			//현재 블럭을 구함
			curBlock = (int)Math.ceil((double)curPage / pageCount);
			//시작페이지
			startPage = ((curBlock - 1) * pageCount) + 1;
			//끝페이지
			endPage = (startPage + pageCount) - 1;
			
			//마지막 페이지 보정
			//총 페이지에서 보다 끝페이지가 크다면 총 페이지를 마지막 페이지로 변환
			if(endPage > totalPage) {
				endPage = totalPage;
			}
			
			//시작 rownum(oracle rownum)
			startRow = ((curPage - 1) * listCount) + 1;
			
			//끝 rownum(oracle rownum)
			endRow = (startRow + listCount) - 1;
			
			//게시물 시작 번호
			startNum = totalCount - ((curPage-1) * listCount);
			
			//이전 블럭 페이지 번호
			if(curBlock > 1) {
				prevBlockPage  = startPage - 1;
			}
			
			//다음 블럭 페이지 번호
			if(curBlock < totalBlock) {
				nextBlockPage = endPage + 1;
			}
		}
}

