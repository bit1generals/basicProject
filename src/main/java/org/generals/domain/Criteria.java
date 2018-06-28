package org.generals.domain;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

import lombok.Data;
import lombok.extern.log4j.Log4j;

@Data
@Log4j
public class Criteria {

	private int page;
	private String type, btype, keyword, state;

	public Criteria() {
		this.page = 1;
	}
	
	public Criteria(int page) {
		this.page = page < 0 ? 1 : page;
	}

	public int getSkip() {
		return (this.page-1) * PageMaker.PER_PAGE_NUM;
	}
	
	public String[] getArr() {
		if(type !=null) {
			log.info("getARR-------------------------------"+this.type.split("-").toString());
			log.info("getARR-------------------------------"+Arrays.toString(this.type.split("-")));
			return this.type.split("-");
		}
		return null;
	}
	public String[] getSearchRooftopArr() {
		if(getArr() != null) {
			List<String> resultList = Arrays.asList(getArr()).stream().filter(target -> !"w".equals(target)).collect(Collectors.toList());
			log.info("getSearchRooftop : "+ Arrays.toString((String[]) resultList.toArray(new String[0])));
			if(((String[]) resultList.toArray(new String[0])).length ==0) {
				return null;
			}
			return (String[]) resultList.toArray(new String[0]);
		}else {
			return null;
		}
		
	}
	public String[] getSearchBoardArr() {
		if(getArr() != null) {
			List<String> resultList = Arrays.asList(getArr()).stream().filter(target -> "w".equals(target)).collect(Collectors.toList());
			log.info("getSearchBoardArr : "+ resultList);
			return (String[]) resultList.toArray(new String[0]);
		}else {
			return null;
		}
	}
	
	
	public String getKeyword() {
		log.info("getKeyword---------------------------------"+this.keyword);
		return this.keyword;
	}

	public void setPage(int page) {
		this.page = page < 0 ? 1 : page;
	}
	public static void main(String[] args) {
		Criteria cri = new Criteria();
		cri.type = null;
		
		/*cri.getSearchBoard();*/
		
		System.out.println(cri.getSearchRooftopArr());
	}
}
