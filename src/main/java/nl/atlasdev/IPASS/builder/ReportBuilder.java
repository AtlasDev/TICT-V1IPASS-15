package nl.atlasdev.IPASS.builder;

import java.util.ArrayList;
import java.util.Date;

import nl.atlasdev.IPASS.model.Answer;
import nl.atlasdev.IPASS.model.Member;

public class ReportBuilder {
	public int id;
	public Member creator;
	public int creatorId;
	public Member target;
	public int targetId;
	public Date createdAt;
	public Date updatedAt;
	public String comment;
	public ArrayList<Answer> answers;

	public ReportBuilder(int id) {
		this.id = id;
	}

	public ReportBuilder setCreator(Member creator) {
		this.creator = creator;
		this.creatorId = creator.getId();
		return this;
	}

	public ReportBuilder setTarget(Member target) {
		this.target = target;
		this.targetId = target.getId();
		return this;
	}

	public ReportBuilder setCreateDate(Date createdAt) {
		this.createdAt = createdAt;
		return this;
	}

	public ReportBuilder setUpdateDate(Date updatedAt) {
		this.updatedAt = updatedAt;
		return this;
	}

	public ReportBuilder setComment(String comment) {
		this.comment = comment;
		return this;
	}

	public ReportBuilder setAnswers(ArrayList<Answer> answers) {
		this.answers = answers;
		return this;
	}

	public ReportBuilder setCreatorId(int id) {
		this.creatorId = id;
		return this;
	}

	public ReportBuilder setTargetId(int id) {
		this.targetId = id;
		return this;
	}
}
