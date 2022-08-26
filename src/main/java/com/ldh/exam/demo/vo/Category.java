package com.ldh.exam.demo.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Category {

	private int id;
	private String regDate;
	private String updateDate;
	private int boardId;
	private int relId;
	private String name;
	private boolean delStatus;

}