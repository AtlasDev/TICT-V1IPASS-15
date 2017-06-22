package nl.atlasdev.IPASS.model;

import java.sql.Date;

import javax.json.Json;
import javax.json.JsonObjectBuilder;

import nl.atlasdev.IPASS.builder.AnswerBuilder;

public class Answer {
	private int id;
	private Report report;
	private int reportId;
	private String indicator;
	private boolean rating;
	private String comment;

	public Answer(AnswerBuilder builder) {
		this.id = builder.id;
		this.report = builder.report;
		this.reportId = builder.reportId;
		this.indicator = builder.indicator;
		this.rating = builder.rating;
		this.comment = builder.comment;
	}

	public int getReportId() {
		return this.reportId;
	}

	public boolean getRating() {
		return this.rating;
	}

	public String getIndicator() {
		return this.indicator;
	}

	public JsonObjectBuilder exportJSON() {
		JsonObjectBuilder object = Json.createObjectBuilder();
		object.add("id", this.id);
		if(this.report != null) {
			object.add("report", this.report.getId());
		} else {
			object.add("report", this.reportId);
		}
		object.add("indicator", this.indicator);
		object.add("rating", this.rating);
		if(this.comment != null) object.add("comment", this.comment);
		return object;
	}

	@Override
	public String toString() {
		return "Answer #" + this.id + " of Indicator " + this.indicator + " Rating " + String.valueOf(this.rating) + " " + this.comment;
	}

	@Override
	public boolean equals(Object e) {
		if(!(e instanceof Answer)) return false;
		return this.id == ((Answer) e).id;
	}
}
