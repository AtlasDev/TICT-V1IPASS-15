package nl.atlasdev.IPASS.dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import nl.atlasdev.IPASS.builder.IndicatorBuilder;
import nl.atlasdev.IPASS.model.Indicator;

public class IndicatorDAO extends BaseDAO {
	public ArrayList<Indicator> findAll() throws SQLException {
		PreparedStatement stat = super.getConnection().prepareStatement("select * from indicator");
		ResultSet result = stat.executeQuery();
		ArrayList<Indicator> data = new ArrayList<Indicator>();
		while(result.next()) {
			data.add(new Indicator(this.createBuilder(result)));
		}
		return data;
	}

	private IndicatorBuilder createBuilder(ResultSet result) throws SQLException {
		return new IndicatorBuilder(result.getString("id"))
			.setSection(result.getString("section"))
			.setSubsection(result.getString("subsection"))
			.setQuestion(result.getString("question"));
	}
}
