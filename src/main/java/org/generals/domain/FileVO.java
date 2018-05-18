package org.generals.domain;

import java.net.URLEncoder;

import org.springframework.web.util.UriComponents;
import org.springframework.web.util.UriComponentsBuilder;

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

	public String urlBuilder() throws Exception{
		
		UriComponents builder = UriComponentsBuilder.newInstance()
				.queryParam("fname", this.fname)
				.queryParam("uuid", this.uuid)
				.queryParam("ftype", this.ftype)
				.queryParam("path", this.path).build();
		return builder.toUriString();
	}
	
}
