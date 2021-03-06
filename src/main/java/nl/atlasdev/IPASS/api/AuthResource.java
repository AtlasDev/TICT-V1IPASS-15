package nl.atlasdev.IPASS.api;

import java.sql.SQLException;
import java.util.Calendar;

import javax.annotation.security.RolesAllowed;
import javax.json.Json;
import javax.ws.rs.Consumes;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.container.ContainerRequestContext;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;
import nl.atlasdev.IPASS.api.exceptions.AccessDeniedException;
import nl.atlasdev.IPASS.api.exceptions.NotFoundException;
import nl.atlasdev.IPASS.dao.MemberDAO;
import nl.atlasdev.IPASS.model.Member;

@Path("/auth")
public class AuthResource {
	public final static String key = "qfafvaSh$YfheBCaeFVP49YVbadC9YB39PVysBVSR";

	@POST
	@RolesAllowed("G")
	@Consumes(MediaType.APPLICATION_JSON)
	@Produces(MediaType.APPLICATION_JSON)
	public Response login(LoginBody body) throws SQLException {
		Member member = new MemberDAO().findByEmail(body.username);
		if(member == null || !member.comparePassword(body.password)) throw new AccessDeniedException("Gebruikersnaam en/of wachtwoord onbekend!");
		return Response.ok(Json.createObjectBuilder().add("token", this.createToken(member)).build().toString()).build();
	}

	@POST
	@Path("/refresh")
	@RolesAllowed({"D", "T", "I", "L"})
	@Produces(MediaType.APPLICATION_JSON)
	public Response refresh(ContainerRequestContext requestCtx) throws SQLException {
		Member member = new MemberDAO().findByEmail(requestCtx.getSecurityContext().getUserPrincipal().getName());
		if(member == null) throw new NotFoundException("Gebruiker onbekend!");
		return Response.ok(Json.createObjectBuilder().add("token", this.createToken(member)).build().toString()).build();
	}

	private String createToken(Member member) {
		Calendar expiration = Calendar.getInstance();
		expiration.add(Calendar.MINUTE, 30);
		return Jwts.builder()
			.setSubject(member.getEmail())
			.setExpiration(expiration.getTime())
			.claim("id", member.getId())
			.claim("name", member.getFullName())
			.claim("role", member.getRole())
			.signWith(SignatureAlgorithm.HS512, AuthResource.key)
			.compact();
	}
}

class LoginBody {
	public String username;
	public String password;
}