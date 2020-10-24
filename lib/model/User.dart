class Token{
	final String token;

	Token({this.token});

	factory Token.fromJson(Map<String, dynamic> json) {
		return Token(
			token: json['token'],
		);
	}
}

class MiddlewareToken{
	final Token success;

	MiddlewareToken({this.success});

	factory MiddlewareToken.fromJson(Map<String, dynamic> json) {
		return MiddlewareToken(
			success: Token.fromJson(json['success']),
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

class InvitationCode {
	int id;
	String code;
	String used_by;

	InvitationCode({this.id, this.code, this.used_by});

	factory InvitationCode.fromJson(Map<String, dynamic> json) {
		return InvitationCode(
			id: json['id'],
			code: json['code'],
			used_by: json['used_by'],
		);
	}
}