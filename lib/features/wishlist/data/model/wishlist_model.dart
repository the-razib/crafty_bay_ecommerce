import 'package:crafty_bay_ecommerce/features/common/data/models/product_model.dart';

class WishlistModel {
  String? sId;
  ProductModel? product;
  String? user;
  String? createdAt;
  String? updatedAt;
  int? iV;

  WishlistModel(
      {this.sId,
      this.product,
      this.user,
      this.createdAt,
      this.updatedAt,
      this.iV});

  WishlistModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    product =
        json['product'] != null ? ProductModel.fromJson(json['product']) : null;
    user = json['user'];
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
    data['user'] = user;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}
