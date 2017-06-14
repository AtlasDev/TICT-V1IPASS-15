package nl.atlasdev.IPASS.dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import nl.atlasdev.IPASS.builder.AnswerBuilder;
import nl.atlasdev.IPASS.model.Answer;

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
}
