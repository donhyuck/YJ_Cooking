package com.ldh.exam.demo.service;

import org.springframework.stereotype.Service;

import com.ldh.exam.demo.repository.AttrRepository;
import com.ldh.exam.demo.vo.Attr;

@Service
public class AttrService {

	private AttrRepository attrRepository;

	public AttrService(AttrRepository attrRepository) {
		this.attrRepository = attrRepository;
	}

	public Attr get(String name) {

		String[] nameBits = name.split("__");
		String relTypeCode = nameBits[0];
		int relId = Integer.parseInt(nameBits[1]);
		String typeCode = nameBits[2];
		String type2Code = nameBits[3];

		return get(relTypeCode, relId, typeCode, type2Code);
	}

	public Attr get(String relTypeCode, int relId, String typeCode, String type2Code) {

		return attrRepository.get(relTypeCode, relId, typeCode, type2Code);
	}

	public int setValue(String name, String value, String expireDate) {

		String[] nameBits = name.split("__");
		String relTypeCode = nameBits[0];
		int relId = Integer.parseInt(nameBits[1]);
		String typeCode = nameBits[2];
		String type2Code = nameBits[3];

		return setValue(relTypeCode, relId, typeCode, type2Code, value, expireDate);
	}

	public String getValue(String name) {

		String[] nameBits = name.split("__");
		String relTypeCode = nameBits[0];
		int relId = Integer.parseInt(nameBits[1]);
		String typeCode = nameBits[2];
		String type2Code = nameBits[3];

		return getValue(relTypeCode, relId, typeCode, type2Code);
	}

	public String getValue(String relTypeCode, int relId, String typeCode, String type2Code) {

		String value = attrRepository.getValue(relTypeCode, relId, typeCode, type2Code);

		if (value == null) {
			return "";
		}

		return value;
	}

	public void remove(String name) {

		String[] nameBits = name.split("__");
		String relTypeCode = nameBits[0];
		int relId = Integer.parseInt(nameBits[1]);
		String typeCode = nameBits[2];
		String type2Code = nameBits[3];

		remove(relTypeCode, relId, typeCode, type2Code);
	}

	public void remove(String relTypeCode, int relId, String typeCode, String type2Code) {

		attrRepository.remove(relTypeCode, relId, typeCode, type2Code);
	}

	public int setValue(String relTypeCode, int relId, String typeCode, String type2Code, String value,
			String expireDate) {

		attrRepository.setValue(relTypeCode, relId, typeCode, type2Code, value, expireDate);
		Attr attr = get(relTypeCode, relId, typeCode, type2Code);

		if (attr != null) {
			return attr.getId();
		}

		return -1;
	}
}
