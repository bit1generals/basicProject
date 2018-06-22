package org.generals.domain;

import lombok.Data;
import lombok.extern.log4j.Log4j;

@Data
@Log4j
public class PageMaker {

	private int start, end, total;
	private boolean prev, next;
	private Criteria cri;
	public static final int PER_PAGE_NUM = 12;
	

	public PageMaker(Criteria cri, int total) {
		this.cri = cri;
		this.total = total;
/*		int totalPage = (int) Math.ceil(this.total / PER_PAGE_NUM);
		this.cri.setPage(cri.getPage() > totalPage ? totalPage : cri.getPage());
*/		setUp();
	}

	private void setUp() {
		end = ((cri.getPage() - 1) / 10) * 10 + 10;
		start = end - 9;
		if (total < end * PER_PAGE_NUM) {
			end = (int) (total / PER_PAGE_NUM)+ 1;
		}

		prev = start != 1 ? true : false;
		next = end * PER_PAGE_NUM <= total ? true : false;
		
	}

}
