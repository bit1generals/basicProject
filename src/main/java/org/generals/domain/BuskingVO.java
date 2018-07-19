package org.generals.domain;

import java.util.Date;

import lombok.Data;

@Data
public class BuskingVO {
	
	private Long bkno;
	private String bkName, bkcontent;
	private Date regdate, updatedate;
	private ReserveVO reserveVO;
}
