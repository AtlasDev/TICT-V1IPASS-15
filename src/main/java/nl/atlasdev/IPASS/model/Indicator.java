package nl.atlasdev.IPASS.model;

import javax.json.Json;
import javax.json.JsonObjectBuilder;

import nl.atlasdev.IPASS.builder.IndicatorBuilder;

public class Indicator {
	private String id;
	private String section;
	private String subsection;
	private String question;

	public Indicator(IndicatorBuilder builder) {
		this.id = builder.id;
		this.section = builder.section;
		this.subsection = builder.subsection;
		this.question = builder.question;
	}

	public JsonObjectBuilder exportJSON() {
		JsonObjectBuilder object = Json.createObjectBuilder();
		object.add("id", this.id);
		object.add("section", this.section);
		object.add("subsection", this.subsection);
		object.add("question", this.question);
		return object;
	}

	@Override
	public String toString() {
		return "Indicator " + this.id + " - " + this.question;
	}

	@Override
	public boolean equals(Object e) {
		if(!(e instanceof Indicator)) return false;
		return this.id == ((Indicator) e).id;
	}
}
