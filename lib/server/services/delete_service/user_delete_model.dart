class UserDeleteModel{
  final String email;
  final String password;

  UserDeleteModel({required this.email, required this.password});

  Map<String, dynamic> toJson(){
    return {
      'email': email,
      'password': password,
    };
  }
}