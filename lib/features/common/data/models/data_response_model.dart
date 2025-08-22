import 'package:crafty_bay_ecommerce/features/common/data/models/paginate_model.dart';

class DataResponseModel<T> {
  final int code;
  final String status;
  final String msg;
  final PaginateModel<T> data;

  DataResponseModel({
    required this.code,
    required this.status,
    required this.msg,
    required this.data,
  });

  factory DataResponseModel.fromJson(
      Map<String, dynamic> json, T Function(Object? json) fromJsonT) {
    return DataResponseModel<T>(
      code: json['code'],
      status: json['status'],
      msg: json['msg'],
      data: PaginateModel<T>.fromJson(json['data'], fromJsonT),
    );
  }

  Map<String, dynamic> toJson(Object? Function(T value) toJsonT) {
    return {
      'code': code,
      'status': status,
      'msg': msg,
      'data': data.toJson(toJsonT),
    };
  }
}
