package org.generals.domain;

import java.sql.Timestamp;
import java.util.Date;
import java.util.List;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
public class RooftopVO {

	private Integer rtno,bno, openTime, closeTime;
	private String rtname, address;
	private int maximum;
	private double lat, lng;

	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date opendate, closedate;
	private BoardVO boardVO;


}

 