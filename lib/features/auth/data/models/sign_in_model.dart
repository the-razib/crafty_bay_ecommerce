import 'package:crafty_bay_ecommerce/features/auth/data/models/user_model.dart';

// class SignInModel {
//   int? code;
//   String? status;
//   String? msg;
//   Data? data;
//
//   SignInModel({this.code, this.status, this.msg, this.data});
//
//   SignInModel.fromJson(Map<String, dynamic> json) {
//     code = json['code'];
//     status = json['status'];
//     msg = json['msg'];
//     data = json['data'] != null ? Data.fromJson(json['data']) : null;
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['code'] = code;
//     data['status'] = status;
//     data['msg'] = msg;
//     if (this.data != null) {
//       data['data'] = this.data!.toJson();
//     }
//     return data;
//   }
// }

class SignInModel {
  String? token;
  UserModel? user;

  SignInModel({this.token, this.user});

  SignInModel.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    user = json['user'] != null ? UserModel.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['token'] = token;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}
