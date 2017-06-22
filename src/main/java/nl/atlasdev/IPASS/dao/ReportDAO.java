package nl.atlasdev.IPASS.dao;

import java.sql.Date;
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

	public int findAndDelete(int reportId) throws SQLException {
		AnswerDAO answerDAO = new AnswerDAO();
		if(answerDAO.findByReportAndDelete(reportId) == 0) return 0;
		PreparedStatement stat = super.getConnection().prepareStatement("delete from report where id = ?");
		stat.setInt(1, reportId);
		return stat.executeUpdate();
	}

	public boolean insert(Report report) throws SQLException {
		PreparedStatement stat = super.getConnection().prepareStatement("insert into report (creator, target, createdAt, updatedAt, comment) values (?, ?, ?, ?, ?)");
		stat.setInt(1, report.getCreatorId());
		stat.setInt(2, report.getTargetId());
		stat.setDate(3, new Date(report.getCreatedAt().getTime()));
		stat.setDate(4, new Date(report.getUpdatedAt().getTime()));
		stat.setString(5, report.getComment());
		int result = stat.executeUpdate();
		return result == 0;
	}

	public Report findByReport(Report report) throws SQLException {
		PreparedStatement stat = super.getConnection().prepareStatement("select * from report where createdAt = ? and updatedAt = ? and creator = ? and target = ? and comment = ?");
		stat.setDate(1, new Date(report.getCreatedAt().getTime()));
		stat.setDate(2, new Date(report.getUpdatedAt().getTime()));
		stat.setInt(3, report.getCreatorId());
		stat.setInt(4, report.getTargetId());
		stat.setString(5, report.getComment());
		ResultSet result = stat.executeQuery();
		if(!result.next()) return null;
		return new Report(this.createBuilder(result));
	}
}
