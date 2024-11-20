class UserCreateModel{
  final String nickname;
  final String email;
  final String password;

  UserCreateModel({required this.nickname, required this.email, required this.password});
  
  Map<String, dynamic> toJson() {
    return {
      'nickname': nickname,
      'email': email,
      'password': password,
    };
  }
}