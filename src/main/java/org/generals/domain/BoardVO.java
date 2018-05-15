package org.generals.domain;

import java.util.Date;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class BoardVO {

	private Integer bno;
	private String btype, id, title, content;
	private Date regdate, updatedate;
	
	public BoardVO(String btype, String id, String title, String content) {
		super();
		this.btype = btype;
		this.id = id;
		this.title = title;
		this.content = content;
	}
	
}
