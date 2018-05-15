package org.generals.domain;

import lombok.Data;

@Data
public class PageMaker {

	private int start, end, total, page;
	private boolean prev, next;
	private Criteria cri;
	
	public PageMaker(Criteria cri, int total) {
		this.cri = cri;
		this.total = total;
		this.page = cri.getPage() > 0 ? cri.getPage() : 1;
		
		end = ((page - 1) / 10) * 10 + 10;
		
		start = end - 9;
		
		if(total < end * 10) {
			end = ((total - 1) / 10) + 1;
		}
		prev = start != 1 ? true : false;
		next = end * 10 <= total ? true : false;
		
	}
	
	
}
