package nl.atlasdev.IPASS.api;

import java.sql.SQLException;

import javax.annotation.security.RolesAllowed;
import javax.json.Json;
import javax.json.JsonArrayBuilder;
import javax.json.JsonObjectBuilder;
import javax.ws.rs.DELETE;
import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.QueryParam;
import javax.ws.rs.core.Response;

import nl.atlasdev.IPASS.api.exceptions.NotFoundException;
import nl.atlasdev.IPASS.dao.ReportDAO;
import nl.atlasdev.IPASS.model.Report;

@Path("/report")
public class ReportResource {
	@GET
	@RolesAllowed({"D", "T", "I"})
	@Produces("application/json")
	public Response getReports(
		@QueryParam("extended") boolean extended
	) throws SQLException {
		ReportDAO dao = new ReportDAO();
		JsonArrayBuilder reports = Json.createArrayBuilder();
		for (Report r : dao.findAll()) {
			if(extended) r.populate();
			reports.add(r.exportJSON());
		}
		return Response.ok(reports.build().toString()).build();
	}

	@GET
	@Path("/{report}")
	@RolesAllowed({"D", "T", "I"})
	@Produces("application/json")
	public Response getReport(
		@PathParam("report") int reportId
	) throws SQLException {
		ReportDAO dao = new ReportDAO();
		Report report = dao.findById(reportId);
		report.populate();
		return Response.ok(report.exportJSON().build().toString()).build();
	}

	@DELETE
	@Path("/{report}")
	@RolesAllowed({"D", "T", "I"})
	@Produces("application/json")
	public Response deleteReport(
		@PathParam("report") int reportId
	) throws SQLException {
		ReportDAO dao = new ReportDAO();
		int result = dao.findAndDelete(reportId);
		if(result != 1) throw new NotFoundException("Report not found or empty.");
		JsonObjectBuilder builder = Json.createObjectBuilder();
		builder.add("success", true);
		return Response.ok(builder.build().toString()).build();
	}
}