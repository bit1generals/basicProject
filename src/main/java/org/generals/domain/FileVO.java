package org.generals.domain;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class FileVO {

	private Integer fno, bno;
	private String fname, uuid, ftype, path;
	
	
	public FileVO(String fname, String uuid, String ftype, String path) {
		super();
		this.fname = fname;
		this.uuid = uuid;
		this.ftype = ftype;
		this.path = path;
	}
	public String getFullName() {
		return uuid + "_" + fname;
	}
	
	
}
