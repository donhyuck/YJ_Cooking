package com.ldh.exam.demo.util;

public class Ut {

	public static boolean empty(Object obj) {

		if (obj == null) {
			return true;
		}

		if (obj instanceof Integer) {
			return ((int) obj) == 0;
		}

		if (obj instanceof Long) {
			return ((long) obj) == 0;
		}

		if (obj instanceof String == false) {
			return true;
		}

		String str = (String) obj;

		return str.trim().length() == 0;
	}

	public static Object f(String msg, Object... args) {
		
		return String.format(msg, args);
	}
}
