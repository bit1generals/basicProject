package org.generals.domain;

import lombok.Data;

@Data
public class BuskingVO {
	
	private Integer bkno, rno, bno;
	private BoardVO boardVO;
	private ReserveVO reserveVO;
}
