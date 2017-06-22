package nl.atlasdev.IPASS.dao;

import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import nl.atlasdev.IPASS.builder.AnswerBuilder;
import nl.atlasdev.IPASS.model.Answer;
import nl.atlasdev.IPASS.model.Report;

public class AnswerDAO extends BaseDAO {
	public ArrayList<Answer> findByReport(int reportId) throws SQLException {
		PreparedStatement stat = super.getConnection().prepareStatement("select * from answer where report = ?");
		stat.setInt(1, reportId);
		ResultSet result = stat.executeQuery();
		ArrayList<Answer> data = new ArrayList<Answer>();
		while(result.next()) data.add(new Answer(this.createBuilder(result)));
		return data;
	}

	private AnswerBuilder createBuilder(ResultSet result) throws SQLException {
		return new AnswerBuilder(result.getInt("id"))
			.setReportId(result.getInt("report"))
			.setIndicator(result.getString("indicator"))
			.setRating(result.getBoolean("rating"))
			.setComment(result.getString("comment"));
	}

	public int findByReportAndDelete(int reportId) throws SQLException {
		PreparedStatement stat = super.getConnection().prepareStatement("delete from answer where report = ?");
		stat.setInt(1, reportId);
		return stat.executeUpdate();
	}


	public boolean insert(Answer answer) throws SQLException {
		PreparedStatement stat = super.getConnection().prepareStatement("insert into answer (report, indicator, rating) values (?, ?, ?)");
		stat.setInt(1, answer.getReportId());
		stat.setString(2, answer.getIndicator());
		stat.setBoolean(3, answer.getRating());
		int result = stat.executeUpdate();
		return result == 0;
	}
}
