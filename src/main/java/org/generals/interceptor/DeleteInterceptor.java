package org.generals.interceptor;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.generals.domain.FileVO;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import lombok.extern.log4j.Log4j;
@Log4j
public class DeleteInterceptor extends HandlerInterceptorAdapter {

	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
		log.info("Delete Interceptor PostHandle ------------------------------------------");
		List<FileVO> deleteList = (List<FileVO>) modelAndView.getModel().get("deleteList");
		log.info("delete File List : "+ deleteList);
		request.getSession().setAttribute("deleteList", deleteList);
		super.postHandle(request, response, handler, modelAndView);
	}
	
}
