package org.generals.test;

import java.util.Arrays;

public class Main {

	public void check() {
		System.out.println(Arrays.toString(this.getClass().getMethods()));
		
		System.out.println(new Throwable().getStackTrace()[0].getMethodName());
	}
	
	public static void main(String[] args) {
		
	}
}
