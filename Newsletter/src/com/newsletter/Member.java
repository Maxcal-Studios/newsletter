package com.newsletter;

public class Member {

	private String address, hash;
	
	public Member(String address, String hash) {
		this.address = address;
		this.hash = hash;
	}
	
	public String getAddress() {
		return address;
	}
	
	public String getHash() {
		return hash;
	}
}
