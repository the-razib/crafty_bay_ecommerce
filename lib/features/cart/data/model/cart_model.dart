import 'package:crafty_bay_ecommerce/features/common/data/models/product_model.dart';

class CartModel {
  String? sId;
  ProductModel? product;
  String? user;
  int? quantity;
  String? color;
  String? size;
  String? createdAt;
  String? updatedAt;
  int? iV;

  CartModel(
      {this.sId,
      this.product,
      this.user,
      this.quantity,
      this.color,
      this.size,
      this.createdAt,
      this.updatedAt,
      this.iV});

  CartModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    product =
        json['product'] != null ? ProductModel.fromJson(json['product']) : null;
    user = json['user'];
    quantity = json['quantity'];
    color = json['color'];
    size = json['size'];
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
    data['quantity'] = quantity;
    data['color'] = color;
    data['size'] = size;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}
