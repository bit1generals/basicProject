package org.generals.controller;

import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import org.generals.domain.FileVO;
import org.generals.service.BoardService;
import org.generals.utils.MimeTypeUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import lombok.Setter;
import lombok.extern.log4j.Log4j;
import net.coobird.thumbnailator.Thumbnailator;

@RestController
@RequestMapping("/file/*")
@Log4j
public class FileController {

	public final static String ROOT = "C:\\zzz\\upload\\";
	public final static String IMG_TYPE = "Y";
	public final static String OTHER_TYPE = "N"; 
	public final static String[] IMG_TYPE_ARR = {"jpg","jpeg","png","gif"}; 

	@Setter(onMethod_ = { @Autowired })
	private BoardService service;
	
	@PostMapping(value = "/delete")
	public void deleteFile(FileVO file, Model model) throws Exception{
				
	}
	

	@PostMapping(value = "/upload", produces = "application/json")
	public ResponseEntity<List<FileVO>> upload(MultipartFile[] files) throws Exception {

		log.info("File upload Post");

		List<FileVO> fileVOList = new ArrayList<>();

		String date = new SimpleDateFormat("yyyy/MM/dd").format(new Date());

		String allPath = ROOT + date + "\\thumbnails";
		String filePath = ROOT + date;

		checkDirectory(allPath);

		for (MultipartFile file : files) {

			UUID uid = UUID.randomUUID();
			String originName = file.getOriginalFilename();
			String fileName = uid.toString() + "_" + originName;
			String fileType = checkType(originName);
			
			fileMaker(file,filePath,fileName);
			thumbnailMaker(file, fileName, fileType, allPath);

			fileVOList.add(new FileVO(originName, uid.toString(), fileType, date));
		}
		service.registerAjax(fileVOList);
		return new ResponseEntity<List<FileVO>>(fileVOList, HttpStatus.OK);
	}


	@GetMapping("/show")
	public ResponseEntity<byte[]> showFile(FileVO fileVO) throws Exception {

		log.info("show file");
		ResponseEntity<byte[]> result = null;
		
		HttpHeaders headers = new HttpHeaders();
		
		String fileName = fileVO.getFname();
		
		MediaType mType = MimeTypeUtils.getMimeType(fileName.substring(fileName.lastIndexOf(".") + 1));
		
		try(ByteArrayOutputStream baos = new ByteArrayOutputStream()) {
			
			File target = new File(ROOT + fileVO.getPath() + fileVO.getFullName());
					
			FileCopyUtils.copy(new FileInputStream(target), baos);
			
			if(mType != null) {
				headers.setContentType(mType);
			}else {
				headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);
				headers.setContentDispositionFormData("filename", new String(fileName.getBytes("UTF-8"), "ISO-8859-1"));
			}
			 
			
			result = new ResponseEntity<byte[]>(baos.toByteArray(), headers, HttpStatus.OK);
			
		}catch (Exception e) {
			e.printStackTrace();
			result = new ResponseEntity<byte[]>(HttpStatus.BAD_REQUEST);
		}		
	
		return result;
	}
	
	public void checkDirectory(String allPath) {
		File directory = new File(allPath);
		if (!directory.exists()) {
			directory.mkdirs();
		}
	}

	public String checkType(String fileName) {
		
		String extension = fileName.split("\\.")[1];
		
		for (String type : IMG_TYPE_ARR) {
			if(extension.equalsIgnoreCase(type)) {
				return IMG_TYPE;
			}
		}
		return OTHER_TYPE;
	}
	
	public void fileMaker(MultipartFile file, String filePath, String fileName) throws Exception {
		FileOutputStream fos = new FileOutputStream(new File(filePath, fileName));
		FileCopyUtils.copy(file.getInputStream(), fos);
		fos.close();
	}

	public void thumbnailMaker(MultipartFile file, String fileName, String fileType, String allPath) throws Exception {
		if (fileType.equals(IMG_TYPE)) {
			FileOutputStream thfos = new FileOutputStream(new File(allPath, fileName));
			Thumbnailator.createThumbnail(file.getInputStream(), thfos, 100 , 100);
			thfos.close();
		}
	}

}
