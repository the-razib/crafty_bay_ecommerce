import 'package:crafty_bay_ecommerce/features/auth/data/models/user_model.dart';
import 'package:crafty_bay_ecommerce/features/common/data/models/product_model.dart';

class ReviewModel {
  String? sId;
  ProductModel? product;
  UserModel? user;
  double? rating;
  String? comment;
  String? createdAt;
  String? updatedAt;
  int? iV;

  ReviewModel({
    this.sId,
    this.product,
    this.user,
    this.rating,
    this.comment,
    this.createdAt,
    this.updatedAt,
    this.iV,
  });

  ReviewModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    product =
        json['product'] != null ? ProductModel.fromJson(json['product']) : null;
    user = json['user'] != null ? UserModel.fromJson(json['user']) : null;
    rating = json['rating'].toDouble(); // Convert int to double
    comment = json['comment'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    if (product != null) {
      data['product'] = product!.toJson();
    }
    if (user != null) {
      data['user'] = user!.toJson();
    }
    data['rating'] = rating;
    data['comment'] = comment;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}
