package org.generals.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.UUID;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import lombok.extern.log4j.Log4j;
import net.coobird.thumbnailator.Thumbnailator;

@RestController
@RequestMapping("/file/*")
@Log4j
public class FileController {

	@PostMapping(value="/upload", produces="application/json")
	public ResponseEntity<List<String>> upload(MultipartFile[] files) throws Exception{
		
		log.info("File upload Post");
		
		List<String> fileNames = new ArrayList<>();
		
		for (MultipartFile file : files) {
			
			UUID uid = UUID.randomUUID();
			
			String fileName = uid.toString() + "_" + file.getOriginalFilename();
			
			FileOutputStream fos = new FileOutputStream(new File("C:\\zzz\\upload", fileName));
			
			FileCopyUtils.copy(file.getInputStream(), fos);
			fos.close();
			
			FileOutputStream thfos = new FileOutputStream(new File("C:\\zzz\\upload\\thumbnails", fileName));
			Thumbnailator.createThumbnail(file.getInputStream(),thfos,100,100);
			
			thfos.close();
			
			fileNames.add(fileName);			
		}
		
		return new ResponseEntity<List<String>>(fileNames, HttpStatus.OK);
	}
	
	@GetMapping("/thumbnail")
	public void viewThumbnail(String fileName) throws Exception{
		
		FileInputStream fin = new FileInputStream(new File("C:\\zzz\\upload\\thumbnails", fileName));
		
		
	}
}
