package org.generals.listener;

import org.springframework.context.ApplicationListener;
import org.springframework.security.core.session.SessionCreationEvent;
import org.springframework.security.core.session.SessionDestroyedEvent;
import org.springframework.security.core.session.SessionInformation;
import org.springframework.security.web.session.SessionInformationExpiredEvent;
import org.springframework.stereotype.Component;

import lombok.extern.log4j.Log4j;

@Log4j
@Component
public class Test3Listener implements ApplicationListener<SessionInformationExpiredEvent> {

	@Override
	public void onApplicationEvent(SessionInformationExpiredEvent event) {

		log.info("-------------------------------------------");
		log.info("Session SessionInformationExpiredEvent Listener"+ event.getSessionInformation());
		
		log.info("Session SessionInformationExpiredEvent Listener"+ event.getSessionInformation().isExpired());
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
