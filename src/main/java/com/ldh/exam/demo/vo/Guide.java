package com.ldh.exam.demo.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Guide {

	private int id;
	private String regDate;
	private String updateDate;
	private int recipeId;
	private int sortId;
	private int methodId;
	private int contentId;
	private int freeId;
	private boolean delStatus;

}