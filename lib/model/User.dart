class Token{
	final String access_token;
	final String token_type;
	final String expire_at;

	Token({this.access_token, this.expire_at, this.token_type});

	factory Token.fromJson(Map<String, dynamic> json) {
		return Token(
			access_token: json['access_token'],
			token_type: json['token_type'],
			expire_at: json['expire_at'],
		);
	}
}

class User{
	final String id;
	final String full_name;
	final String email;
	final String email_verified_at;
	final String ngo_name;
	final String ngo_email;
	final String phone_number;
	final String username;
	final String language;
	final String time_available;
	final String remarks;

  User({this.id, this.full_name, this.email, this.email_verified_at, this.ngo_name, this.ngo_email, this.phone_number, this.username, this.language, this.time_available, this.remarks});

	factory User.fromJson(Map<String, dynamic> json) {
		return User(
			id: json['id'].toString(),
			full_name: json['full_name'],
			email: json['email'],
			email_verified_at:json['email_verified_at'],
			ngo_name:json['ngo_name'],
			ngo_email:json['ngo_email'],
			phone_number:json['phone_number'],
			username:json['username'],
			language:json['language'],
			time_available:json['time_available'],
			remarks:json['remarks'],
		);
	}
}