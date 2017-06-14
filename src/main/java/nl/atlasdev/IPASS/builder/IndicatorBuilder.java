package nl.atlasdev.IPASS.builder;

public class IndicatorBuilder {
	public String id;
	public String section;
	public String subsection;
	public String question;

	public IndicatorBuilder(String id) {
		this.id = id;
	}

	public IndicatorBuilder setSection(String section) {
		this.section = section;
		return this;
	}

	public IndicatorBuilder setSubsection(String subsction) {
		this.subsection = subsction;
		return this;
	}

	public IndicatorBuilder setQuestion(String question) {
		this.question = question;
		return this;
	}
}
