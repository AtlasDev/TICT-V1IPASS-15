package nl.atlasdev.IPASS.api;

import java.sql.SQLException;

import javax.json.Json;
import javax.json.JsonArrayBuilder;
import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.Response;

import nl.atlasdev.IPASS.dao.MemberDAO;
import nl.atlasdev.IPASS.model.Member;

@Path("/member")
public class MemberResource {
	@GET
	@Produces("application/json")
	public Response getUsers() throws SQLException {
		MemberDAO dao = new MemberDAO();
		JsonArrayBuilder users = Json.createArrayBuilder();
		for (Member m : dao.findAll()) {
			m.populate();
			users.add(m.exportJSON());
		}
		return Response.ok(users.build().toString()).build();
	}
}
