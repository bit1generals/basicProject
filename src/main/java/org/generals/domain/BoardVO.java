package org.generals.domain;

import java.util.Date;
import java.util.List;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class BoardVO {

	private Integer bno, pno;
	private String btype, id, title, content;
	private Date regdate, updatedate;
	private List<FileVO> files;
	
	public BoardVO(String btype, String id, String title, String content) {
		super();
		this.btype = btype;
		this.id = id;
		this.title = title;
		this.content = content;
	}
	
}
