package nl.atlasdev.IPASS.builder;

import nl.atlasdev.IPASS.model.Member;

public class MemberBuilder {
	public int id;
	public String email;
	public String firstName;
	public String middleName;
	public String lastName;
	public String password;
	public char type;
	public Member IBer;
	public int IBerId;

	public MemberBuilder(int id) {
		this.id = id;
	}

	public MemberBuilder setEmail(String email) {
		this.email = email;
		return this;
	}

	public MemberBuilder setFirstName(String firstName) {
		this.firstName = firstName;
		return this;
	}

	public MemberBuilder setMiddleName(String middleName) {
		this.middleName = middleName;
		return this;
	}

	public MemberBuilder setLastName(String lastName) {
		this.lastName = lastName;
		return this;
	}

	public MemberBuilder setPassword(String password) {
		this.password = password;
		return this;
	}

	public MemberBuilder setIBer(Member IBer) {
		this.IBer = IBer;
		this.IBerId = IBer.getId();
		return this;
	}

	public MemberBuilder setIBerId(int IBerId) {
		this.IBerId = IBerId;
		return this;
	}

	public MemberBuilder setType(char type) {
		if(type != 'D' && type != 'T' && type != 'I' && type != 'L') throw new IllegalArgumentException();
		this.type = type;
		return this;
	}
}
