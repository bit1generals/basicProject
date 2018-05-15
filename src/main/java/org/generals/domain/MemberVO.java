package org.generals.domain;

import java.util.Date;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class MemberVO {
	
	private String id, name, pw, email;
	private Date regdate, updatedate;
	
	public MemberVO(String id, String name, String pw, String email) {
		super();
		this.id = id;
		this.name = name;
		this.pw = pw;
		this.email = email;
	}
	
}
