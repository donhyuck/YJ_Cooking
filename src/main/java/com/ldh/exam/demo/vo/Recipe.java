package com.ldh.exam.demo.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Recipe {

	private int id;
	private String regDate;
	private String updateDate;
	private int memberId;
	private int guideId;
	private String title;
	private String body;
	private int amount;
	private int time;
	private int level;
	private int hitCount;
	private int goodRP;
	private int scrap;
	private String tip;

	private String extra__writerName;
	private boolean extra__actorCanModify;
	private boolean extra__actorCanDelete;

	public String getForPrintRegDate_Type1() {
		return regDate.substring(2, 16).replace(" ", "</br>");
	}

	public String getForPrintUpdateDate_Type1() {
		return updateDate.substring(2, 16).replace(" ", "</br>");
	}

	public String getForPrintRegDate_Type2() {
		return regDate.substring(2, 16);
	}

	public String getForPrintUpdateDate_Type2() {
		return updateDate.substring(2, 16);
	}

	public String getForPrintTime() {

		if (time > 60) {
			if (time % 60 == 0) {
				return (time / 60) + "시간 ";
			}
			return (time / 60) + "시간 " + (time % 60) + "분";
		}

		return time + "분";
	}

	public String getForPrintLevel() {

		String levelStr = "";

		switch (level) {
		case 1:
			levelStr = "누구나";
			break;
		case 2:
			levelStr = "초급";
			break;
		case 3:
			levelStr = "중급";
			break;
		case 4:
			levelStr = "고급";
			break;
		}

		return levelStr;
	}
}
