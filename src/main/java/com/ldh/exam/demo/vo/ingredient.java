package com.ldh.exam.demo.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Ingredient {

	private int id;
	private String regDate;
	private String updateDate;
	private int recipeId;
	private String rowArr;
	private String rowValueArr;
	private String sauceArr;
	private String sauceValueArr;

}