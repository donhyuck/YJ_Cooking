package com.ldh.exam.demo.vo;

import java.util.Map;

import com.ldh.exam.demo.util.Ut;

import lombok.Data;

@Data
public class ResultData<DT> {

	// 처리결과 성공 S-xx, 실패 F-xx
	private String resultCode;
	private String msg;
	private String data1Name;
	private DT data1;
	private Object data2;
	private Map<String, Object> body;

	public ResultData() {
	}

	public ResultData(String resultCode, String msg, Object... args) {
		this.resultCode = resultCode;
		this.msg = msg;
		this.body = Ut.mapOf(args);
	}

	public static ResultData from(String resultCode, String msg) {

		return from(resultCode, msg, null, null);
	}

	public static <DT> ResultData<DT> from(String resultCode, String msg, String data1Name, DT data1) {

		ResultData<DT> rd = new ResultData<DT>();
		rd.resultCode = resultCode;
		rd.msg = msg;
		rd.data1Name = data1Name;
		rd.data1 = data1;

		return rd;
	}

	public static <DT> ResultData<DT> from(String resultCode, String msg, DT data1, DT data2) {

		ResultData<DT> rd = new ResultData<DT>();
		rd.resultCode = resultCode;
		rd.msg = msg;
		rd.data1 = data1;
		rd.data2 = data2;

		return rd;
	}

	public boolean isSuccess() {
		return resultCode.startsWith("S-");
	}

	public boolean isFail() {
		return isSuccess() == false;
	}

	public static <DT> ResultData<DT> newData(ResultData Rd, String data1Name, DT newData) {

		return from(Rd.getResultCode(), Rd.getMsg(), data1Name, newData);
	}

	public void setData2(String dataName, Object data) {
		dataName = dataName;
		data = data;
	}
}