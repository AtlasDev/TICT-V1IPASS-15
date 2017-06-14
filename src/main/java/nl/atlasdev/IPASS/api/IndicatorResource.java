package nl.atlasdev.IPASS.api;

import java.sql.SQLException;

import javax.annotation.security.RolesAllowed;
import javax.json.Json;
import javax.json.JsonArrayBuilder;
import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.Response;

import nl.atlasdev.IPASS.dao.IndicatorDAO;
import nl.atlasdev.IPASS.model.Indicator;

@Path("/indicator")
public class IndicatorResource {
	@GET
	@RolesAllowed({"D", "T", "I", "L"})
	@Produces("application/json")
	public Response getReports() throws SQLException {
		IndicatorDAO dao = new IndicatorDAO();
		JsonArrayBuilder indicators = Json.createArrayBuilder();
		for (Indicator i : dao.findAll()) {
			indicators.add(i.exportJSON());
		}
		return Response.ok(indicators.build().toString()).build();
	}
}
