class UserModel {
  String? email;
  String? pass;

  UserModel({
    this.email,
    this.pass,
  });

  UserModel.fromJson(Map<String, dynamic> json)
      : email = json['email'],
        pass = json['pass'];

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'pass': pass,
    };
  }
}
