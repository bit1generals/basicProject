package org.generals.utils;

import java.util.HashMap;
import java.util.Map;

import org.springframework.http.MediaType;

public enum MimeTypeUtils {

	instance;
	
	public static Map<String, MediaType> map;
	
	static {
		map = new HashMap<>();
		map.put("jpeg", MediaType.IMAGE_JPEG);
		map.put("jpg", MediaType.IMAGE_JPEG);
		map.put("png", MediaType.IMAGE_PNG);
		map.put("gif", MediaType.IMAGE_GIF);
	}
	
	public static MediaType getMimeType(String extension) {
		return map.get(extension.toLowerCase());
	}
	
}
