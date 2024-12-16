class UserAuthModel{
  final String email;
  final String password;

  UserAuthModel({required this.email, required this.password});

  Map<String, dynamic> toJson(){
    return {
      'email': email,
      'password': password,
    };
  }
}