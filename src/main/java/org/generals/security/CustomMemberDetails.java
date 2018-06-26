package org.generals.security;

import java.util.Collection;
import java.util.stream.Collectors;

import org.generals.domain.MemberVO;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;

import lombok.Data;

@Data
public class CustomMemberDetails extends User{

	private MemberVO member;
	private String displayName;
	
	
	public CustomMemberDetails(String username, String password, Collection<? extends GrantedAuthority> authorities) {
		super(username, password, authorities);
	}

	public CustomMemberDetails(MemberVO member) {
		this(member.getId(), member.getPw(), 
				member.getAuthList().stream()
                .map(auth -> new SimpleGrantedAuthority(auth))
                .collect(Collectors.toList()));
		this.member = member;
		this.displayName = member.getName();
		
	}

}
