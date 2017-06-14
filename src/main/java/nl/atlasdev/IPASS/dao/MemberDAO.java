package nl.atlasdev.IPASS.dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import nl.atlasdev.IPASS.builder.MemberBuilder;
import nl.atlasdev.IPASS.model.Member;

public class MemberDAO extends BaseDAO {
	public ArrayList<Member> findAll() throws SQLException {
		PreparedStatement stat = super.getConnection().prepareStatement("select * from member");
		ResultSet result = stat.executeQuery();

		ArrayList<Member> data = new ArrayList<Member>();
		while(result.next()) {
			data.add(new Member(this.createBuilder(result)));
		}
		return data;
	}

	public Member findById(int id) throws SQLException {
		PreparedStatement stat = super.getConnection().prepareStatement("select * from member where id=?");
		stat.setInt(1, id);
		ResultSet result = stat.executeQuery();
		if(!result.next()) return null;
		return new Member(this.createBuilder(result));
	}

	public Member findByEmail(String email) throws SQLException {
		PreparedStatement stat = super.getConnection().prepareStatement("select * from member where email = ?");
		stat.setString(1, email);
		ResultSet result = stat.executeQuery();
		if(!result.next()) return null;
		return new Member(this.createBuilder(result));
	}

	private MemberBuilder createBuilder(ResultSet result) throws SQLException {
		return new MemberBuilder(result.getInt("id"))
			.setEmail(result.getString("email"))
			.setFirstName(result.getString("firstName"))
			.setMiddleName(result.getString("middleName"))
			.setLastName(result.getString("lastName"))
			.setPassword(result.getString("password"))
			.setType(result.getString("type").charAt(0))
			.setIBerId(result.getInt("IBer"));
	}
}
