package org.generals.listener;

import org.springframework.context.ApplicationListener;
import org.springframework.security.core.session.SessionDestroyedEvent;
import org.springframework.stereotype.Component;

import lombok.extern.log4j.Log4j;

@Log4j
@Component
public class TestListener implements ApplicationListener<SessionDestroyedEvent> {

	@Override
	public void onApplicationEvent(SessionDestroyedEvent event) {

		log.info("-------------------------------------------");
		log.info("Session Destroyed Listener"+ event);
		log.info(event.getSource().getClass().toString());
		log.info(event.getSecurityContexts());
		
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
