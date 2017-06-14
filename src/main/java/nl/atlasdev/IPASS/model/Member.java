package nl.atlasdev.IPASS.model;

import java.sql.SQLException;

import javax.json.Json;
import javax.json.JsonObjectBuilder;

import org.mindrot.jbcrypt.BCrypt;

import nl.atlasdev.IPASS.builder.MemberBuilder;
import nl.atlasdev.IPASS.dao.MemberDAO;

public class Member {
	private int id;
	private String email;
	private String firstName;
	private String middleName;
	private String lastName;
	private String password;
	private char type;
	private Member IBer;
	private int IBerId;

	public Member(MemberBuilder builder) {
		this.id = builder.id;
		this.email = builder.email;
		this.firstName = builder.firstName;
		this.middleName = builder.middleName;
		this.lastName = builder.lastName;
		this.password = builder.password;
		this.type = builder.type;
		this.IBer = builder.IBer;
		this.IBerId = builder.IBerId;
	}

	public int getId() {
		return this.id;
	}

	public String getEmail() {
		return this.email;
	}

	public String getFullName() {
		String name = this.firstName + " ";
		if(this.middleName != null) name += this.middleName + " ";
		name += this.lastName;
		return name;
	}

	public String getRole() {
		return String.valueOf(this.type);
	}

	public boolean comparePassword(String password) {
		return BCrypt.checkpw(password, this.password);
	}

	public void populate() throws SQLException {
		MemberDAO dao = new MemberDAO();
		if(this.IBerId != 0) this.IBer = dao.findById(this.IBerId);
	}

	public JsonObjectBuilder exportJSON() {
		JsonObjectBuilder object = Json.createObjectBuilder();
		object.add("id", this.id);
		object.add("email", this.email);
		object.add("firstName", this.firstName);
		if(this.middleName != null) object.add("middleName", this.middleName);
		object.add("lastName", this.lastName);
		object.add("type", String.valueOf(this.type));
		if(this.IBer != null) {
			object.add("IBer", this.IBer.exportJSON());
		} else if(this.IBerId != 0) {
			object.add("IBer", this.IBerId);
		}
		return object;
	}

	@Override
	public String toString() {
		return "Member #" + this.id + " - " + this.getFullName();
	}

	@Override
	public boolean equals(Object e) {
		if(!(e instanceof Member)) return false;
		return this.id == ((Member) e).id;
	}
}