package nl.atlasdev.IPASS.api;

import java.io.IOException;
import java.security.Principal;

import javax.annotation.Priority;
import javax.ws.rs.Priorities;
import javax.ws.rs.container.ContainerRequestContext;
import javax.ws.rs.container.ContainerRequestFilter;
import javax.ws.rs.core.HttpHeaders;
import javax.ws.rs.core.SecurityContext;
import javax.ws.rs.ext.Provider;

import io.jsonwebtoken.Claims;
import io.jsonwebtoken.JwtException;
import io.jsonwebtoken.JwtParser;
import io.jsonwebtoken.Jwts;
import nl.atlasdev.IPASS.api.exceptions.AccessDeniedException;

@Provider
@Priority(Priorities.AUTHENTICATION)
public class AuthFilter implements ContainerRequestFilter {
	@Override
	public void filter(ContainerRequestContext requestCtx) throws IOException {
		boolean isSecure = requestCtx.getSecurityContext().isSecure();
		Context msc = new Context("Unknown", "guest", isSecure);
		String authHeader = requestCtx.getHeaderString(HttpHeaders.AUTHORIZATION);
		if (authHeader != null && authHeader.startsWith("Bearer ")) {
			String token = authHeader.substring("Bearer".length()).trim();
			try {
				JwtParser parser = Jwts.parser().setSigningKey(AuthResource.key);
				Claims claims = parser.parseClaimsJws(token).getBody();
				String user = claims.getSubject();
				String role = claims.get("role").toString();
				msc = new Context(user, role, isSecure);
			} catch (JwtException | IllegalArgumentException e) {
				throw new AccessDeniedException("Invalid JWT token.");
			}
		}
		requestCtx.setSecurityContext(msc);
	}
}

class Context implements SecurityContext {
	private String name;
	private String role;
	private boolean isSecure;

	public Context(String name, String role, boolean isSecure) {
		this.name = name;
		this.role = role;
		this.isSecure = isSecure;
	}

	public Principal getUserPrincipal() {
		return new Principal() {
			public String getName() { return name; }
		};
	}

	public boolean isUserInRole(String role) {
		return role.equals(this.role);
	}

	public boolean isSecure() {
		return isSecure;
	}

	public String getAuthenticationScheme() {
		return "Bearer";
	}
}
