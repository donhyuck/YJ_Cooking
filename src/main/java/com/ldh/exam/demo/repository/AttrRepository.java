package com.ldh.exam.demo.repository;

import org.apache.ibatis.annotations.Mapper;

import com.ldh.exam.demo.vo.Attr;

@Mapper
public interface AttrRepository {

	public void remove(String relTypeCode, int relId, String typeCode, String type2Code);

	public int setValue(String relTypeCode, int relId, String typeCode, String type2Code, String value,
			String expireDate);

	public Attr get(String relTypeCode, int relId, String typeCode, String type2Code);

	public String getValue(String relTypeCode, int relId, String typeCode, String type2Code);
}