package com.ldh.exam.demo.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class CookingOrder {

	private int id;
	private String regDate;
	private String updateDate;
	private int recipeId;
	private String body;

}
