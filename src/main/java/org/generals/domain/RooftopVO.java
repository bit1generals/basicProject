package org.generals.domain;

import java.sql.Timestamp;
import java.util.Date;
import java.util.List;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
public class RooftopVO {

	private Integer rtno,bno;
	private String rtname;
	private int maximum;
	private double lat, lng;
	private Timestamp openTime, closeTime;
	private Date opendate, closedate;
	private BoardVO boardVO;

	public void setOpenTime(String openTime) {
		this.openTime = Timestamp.valueOf(openTime);
	}

	public void setCloseTime(String closeTime) {
		this.closeTime = Timestamp.valueOf(closeTime);
	}

}

 