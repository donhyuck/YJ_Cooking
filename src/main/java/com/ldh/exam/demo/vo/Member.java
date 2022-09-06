package com.ldh.exam.demo.vo;

import com.ldh.exam.demo.util.Ut;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Member {

	private int id;
	private String regDate;
	private String updateDate;
	private String loginId;
	private String loginPw;
	private int authLevel;
	private String nickname;
	private String cellphoneNo;
	private String email;
	private boolean delStatus;
	private String delDate;

	public String getForPrintCellphoneNo() {
		return Ut.f("%s-%s-%s", cellphoneNo.substring(0, 3), cellphoneNo.substring(3, 7), cellphoneNo.substring(7, 11));
	}

	public String getForPrintRegDate_Type2() {
		return regDate.substring(0, 10);
	}

	public String getForPrintUpdateDate_Type2() {
		return updateDate.substring(0, 10);
	}

	public boolean isAdmin() {
		return this.authLevel == 7;
	}
}
