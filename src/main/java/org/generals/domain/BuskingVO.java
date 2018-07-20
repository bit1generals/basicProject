package org.generals.domain;

import java.util.Date;

import lombok.Data;

@Data
public class BuskingVO {
	
	private Long bkno, rno;
	private String bkTitle, bkContent;
	private Date regdate, updatedate;
}
