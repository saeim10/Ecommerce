class AuthModel{
  final String msg;
  final String data;

  AuthModel({
    required this.msg,
    required this.data,
  });

  factory AuthModel.fromJson(Map<String, dynamic> json) {
    return AuthModel(
      msg: json['msg'] ,
      data: json['data'] ,
    );
  }
}