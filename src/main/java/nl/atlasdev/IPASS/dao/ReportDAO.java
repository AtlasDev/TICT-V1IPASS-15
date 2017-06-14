package nl.atlasdev.IPASS.dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import nl.atlasdev.IPASS.builder.ReportBuilder;
import nl.atlasdev.IPASS.model.Report;

public class ReportDAO extends BaseDAO {
	public ArrayList<Report> findAll() throws SQLException {
		PreparedStatement stat = super.getConnection().prepareStatement("select * from report");
		ResultSet result = stat.executeQuery();
		ArrayList<Report> data = new ArrayList<Report>();
		while(result.next()) data.add(new Report(this.createBuilder(result)));
		return data;
	}

	public Report findById(int reportId) throws SQLException {
		PreparedStatement stat = super.getConnection().prepareStatement("select * from report where id = ?");
		stat.setInt(1, reportId);
		ResultSet result = stat.executeQuery();
		if(!result.next()) return null;
		return new Report(this.createBuilder(result).setAnswers(new AnswerDAO().findByReport(reportId)));
	}

	public ReportBuilder createBuilder(ResultSet result) throws SQLException {
		return new ReportBuilder(result.getInt("id"))
			.setCreatorId(result.getInt("creator"))
			.setTargetId(result.getInt("target"))
			.setCreateDate(result.getTimestamp("createdAt"))
			.setUpdateDate(result.getTimestamp("updatedAt"))
			.setComment(result.getString("comment"));
	}
}
