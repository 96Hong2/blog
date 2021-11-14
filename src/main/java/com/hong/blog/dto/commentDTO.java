package com.hong.blog.dto;

public class commentDTO {
	private int cmtId;
	private String cmtContent;
	private String cmtRegDate;
	private String cmtWriter;
	private String cmtWriterNick;
	private int postId;
	private String cmtDepth;
	private int cmtParent;
	private String isDel;
	public int getCmtId() {
		return cmtId;
	}
	public void setCmtId(int cmtId) {
		this.cmtId = cmtId;
	}
	public String getCmtContent() {
		return cmtContent;
	}
	public void setCmtContent(String cmtContent) {
		this.cmtContent = cmtContent;
	}
	public String getCmtRegDate() {
		return cmtRegDate;
	}
	public void setCmtRegDate(String cmtRegDate) {
		this.cmtRegDate = cmtRegDate;
	}
	public String getCmtWriter() {
		return cmtWriter;
	}
	public void setCmtWriter(String cmtWriter) {
		this.cmtWriter = cmtWriter;
	}
	public String getCmtWriterNick() {
		return cmtWriterNick;
	}
	public void setCmtWriterNick(String cmtWriterNick) {
		this.cmtWriterNick = cmtWriterNick;
	}
	public int getPostId() {
		return postId;
	}
	public void setPostId(int postId) {
		this.postId = postId;
	}
	public String getCmtDepth() {
		return cmtDepth;
	}
	public void setCmtDepth(String cmtDepth) {
		this.cmtDepth = cmtDepth;
	}
	public int getCmtParent() {
		return cmtParent;
	}
	public void setCmtParent(int cmtParent) {
		this.cmtParent = cmtParent;
	}
	public String getIsDel() {
		return isDel;
	}
	public void setIsDel(String isDel) {
		this.isDel = isDel;
	}
	
	
}
