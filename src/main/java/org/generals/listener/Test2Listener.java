package org.generals.listener;

import org.springframework.context.ApplicationListener;
import org.springframework.security.core.session.SessionCreationEvent;
import org.springframework.security.core.session.SessionDestroyedEvent;
import org.springframework.stereotype.Component;

import lombok.extern.log4j.Log4j;

@Log4j
@Component
public class Test2Listener implements ApplicationListener<SessionCreationEvent> {

	@Override
	public void onApplicationEvent(SessionCreationEvent event) {

		log.info("-------------------------------------------");
		log.info("Session Createion Listener"+ event);
		log.info("-------------------------------------------");
		
		
			
		/*
		 * for (SecurityContext securityContext : event.getSecurityContexts()) {
		 * Authentication authentication = securityContext.getAuthentication();
		 * //YourPrincipalClass user = (YourPrincipalClass)
		 * authentication.getPrincipal(); // do something
		 * 
		 * }
		 */
	}

}
