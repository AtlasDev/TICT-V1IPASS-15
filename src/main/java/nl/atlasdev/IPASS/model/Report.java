package nl.atlasdev.IPASS.model;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;

import javax.json.Json;
import javax.json.JsonArrayBuilder;
import javax.json.JsonObjectBuilder;

import nl.atlasdev.IPASS.builder.ReportBuilder;
import nl.atlasdev.IPASS.dao.AnswerDAO;
import nl.atlasdev.IPASS.dao.MemberDAO;

public class Report {
	private int id;
	private Member creator;
	private int creatorId;
	private Member target;
	private int targetId;
	private Date createdAt;
	private Date updatedAt;
	private String comment;
	private ArrayList<Answer> answers;

	public Report(ReportBuilder builder) {
		this.id = builder.id;
		this.creator = builder.creator;
		this.creatorId = builder.creatorId;
		this.target = builder.target;
		this.targetId = builder.targetId;
		this.createdAt = builder.createdAt;
		this.updatedAt = builder.updatedAt;
		this.comment = builder.comment;
		this.answers = builder.answers;
	}

	public int getId() {
		return this.id;
	}

	public void populate() throws SQLException {
		MemberDAO memberDAO = new MemberDAO();
		if(this.creator == null) this.creator = memberDAO.findById(this.creatorId);
		if(this.target == null) this.target = memberDAO.findById(this.targetId);

		AnswerDAO answerDAO = new AnswerDAO();
		if(this.answers == null) this.answers = answerDAO.findByReport(this.id);
	}

	public JsonObjectBuilder exportJSON() {
		JsonObjectBuilder object = Json.createObjectBuilder();
		object.add("id", this.id);
		if(this.creator != null) {
			object.add("creator", this.creator.exportJSON());
		} else {
			object.add("creator", this.creatorId);
		}
		if(this.target != null) {
			object.add("target", this.target.exportJSON());
		} else {
			object.add("target", this.targetId);
		}
		object.add("createdAt", this.createdAt.toString());
		object.add("updatedAt", this.updatedAt.toString());
		if(this.comment != null) object.add("comment", this.comment);

		if(this.answers != null) {
			JsonArrayBuilder answersArray = Json.createArrayBuilder();
			for(int i = 0; i < answers.size(); i++) {
				answersArray.add(this.answers.get(i).exportJSON());
			}
			object.add("answers", answersArray);
		}

		return object;
	}

	@Override
	public String toString() {
		return "Report #" + this.id;
	}

	@Override
	public boolean equals(Object e) {
		if(!(e instanceof Report)) return false;
		return this.id == ((Report) e).id;
	}
}
