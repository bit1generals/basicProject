package org.generals.domain;

import java.sql.Timestamp;
import java.util.Date;
import java.util.List;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
public class StageVO {

	private Integer rtno,bno, openTime, closeTime;
	private String rtname, address, state;
	private int maximum;
	private double lat, lng;

	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date opendate, closedate;
	private BoardVO boardVO;
	
	@Override
	public String toString() {
		return "StageVO ['rtno' :" + rtno + ", bno : " + bno + ", openTime : " + openTime + ", closeTime : " + closeTime
				+ ", rtname : " + rtname + ", address : " + address + ", state : " + state + ", maximum : " + maximum + ", lat : "
				+ lat + ", lng=" + lng + ", opendate=" + opendate + ", closedate=" + closedate + ", boardVO=" + boardVO
				+ "]";
	}

	
}

 