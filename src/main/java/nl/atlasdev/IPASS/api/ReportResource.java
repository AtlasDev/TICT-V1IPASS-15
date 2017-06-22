package nl.atlasdev.IPASS.api;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;

import javax.annotation.security.RolesAllowed;
import javax.json.Json;
import javax.json.JsonArrayBuilder;
import javax.json.JsonObjectBuilder;
import javax.ws.rs.Consumes;
import javax.ws.rs.DELETE;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.QueryParam;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

import nl.atlasdev.IPASS.api.exceptions.NotFoundException;
import nl.atlasdev.IPASS.builder.AnswerBuilder;
import nl.atlasdev.IPASS.builder.ReportBuilder;
import nl.atlasdev.IPASS.dao.AnswerDAO;
import nl.atlasdev.IPASS.dao.MemberDAO;
import nl.atlasdev.IPASS.dao.ReportDAO;
import nl.atlasdev.IPASS.model.Answer;
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
	
	@POST
	@RolesAllowed({"D", "T", "I"})
	@Consumes(MediaType.APPLICATION_JSON)
	@Produces(MediaType.APPLICATION_JSON)
	public Response addReport(
		AddBody body
	) throws SQLException {
		ReportBuilder reportBuilder = new ReportBuilder();
		Date now = new Date();
		reportBuilder.setCreateDate(now);
		reportBuilder.setUpdateDate(now);
		reportBuilder.setTargetId(body.teacher);
		reportBuilder.setCreatorId(new MemberDAO().findByEmail(body.watcher).getId());
		reportBuilder.setComment(body.comment);
		new ReportDAO().insert(new Report(reportBuilder));
		Iterator<AnswerReq> answersIter = body.answers.iterator();
		Report rep = new ReportDAO().findByReport(new Report(reportBuilder));
		while(answersIter.hasNext()) {
			AnswerReq answer = answersIter.next();
			AnswerBuilder answerBuilder = new AnswerBuilder();
			answerBuilder.setReport(rep);
			answerBuilder.setRating(answer.rating);
			answerBuilder.setIndicator(answer.indicator);
			new AnswerDAO().insert(new Answer(answerBuilder));
		}
		Report finalRep = new ReportDAO().findById(rep.getId());
		return Response.ok(finalRep.exportJSON().build().toString()).build();
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

class AddBody {
	public String comment;
	public int teacher;
	public String watcher;
	public ArrayList<AnswerReq> answers;
}

class AnswerReq {
	public boolean rating;
	public String indicator;
}