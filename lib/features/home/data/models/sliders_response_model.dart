import 'package:crafty_bay_ecommerce/features/home/data/models/paginate_model.dart';

class SlidersResponseModel {
  int? code;
  String? status;
  String? msg;
  PaginateModel? data;

  SlidersResponseModel({this.code, this.status, this.msg, this.data});

  SlidersResponseModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    status = json['status'];
    msg = json['msg'];
    data = json['data'] != null ? PaginateModel.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['status'] = status;
    data['msg'] = msg;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}
