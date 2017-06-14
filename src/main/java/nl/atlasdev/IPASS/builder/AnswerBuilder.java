package nl.atlasdev.IPASS.builder;

import nl.atlasdev.IPASS.model.Report;

public class AnswerBuilder {
	public int id;
	public Report report;
	public int reportId;
	public String indicator;
	public boolean rating;
	public String comment;

	public AnswerBuilder(int id) {
		this.id = id;
	}

	public AnswerBuilder setReport(Report report) {
		this.report = report;
		this.reportId = report.getId();
		return this;
	}

	public AnswerBuilder setIndicator(String indicator) {
		this.indicator = indicator;
		return this;
	}

	public AnswerBuilder setRating(boolean rating) {
		this.rating = rating;
		return this;
	}

	public AnswerBuilder setComment(String comment) {
		this.comment = comment;
		return this;
	}

	public AnswerBuilder setReportId(int reportId) {
		this.reportId = reportId;
		return this;
	}
}
