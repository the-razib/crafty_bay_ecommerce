import 'package:crafty_bay_ecommerce/features/brand/data/model/brand_model.dart';
import 'package:crafty_bay_ecommerce/features/common/data/models/category_model.dart';

class ProductModel {
  String? sId;
  String? title;
  Object? brand;
  List<Object>? categories;
  String? slug;
  String? metaDescription;
  String? description;
  List<String>? photos;
  List<String>? colors;
  List<String>? sizes;
  List<String>? tags;
  int? regularPrice;
  int? currentPrice;
  int? quantity;
  String? createdAt;
  String? updatedAt;
  bool? inCart;
  bool? inWishlist;

  ProductModel(
      {this.sId,
      this.title,
      this.brand,
      this.categories,
      this.slug,
      this.metaDescription,
      this.description,
      this.photos,
      this.colors,
      this.sizes,
      this.tags,
      this.regularPrice,
      this.currentPrice,
      this.quantity,
      this.createdAt,
      this.updatedAt,
      this.inCart,
      this.inWishlist});

  ProductModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    if (json['brand'] != null) {
      if (json['brand'] is String) {
        brand = json['brand'];
      }
      if (json['brand'] is Map<String, dynamic>) {
        brand = BrandModel.fromJson(json['brand']);
      }
    } else {
      brand = null;
    }

    if (json['categories'] != null) {
      if (json['categories'] is List<CategoryModel>) {
        categories = <CategoryModel>[];
        json['categories'].forEach((v) {
          categories!.add(CategoryModel.fromJson(v));
        });
      }
      if (json['categories'] is List<String>) {
        categories = json['categories'];
      }
    } else {
      categories = null;
    }
    slug = json['slug'];
    metaDescription = json['meta_description'];
    description = json['description'];
    // photos = json['photos']?.cast<String>();
    if (json['photos'] != null) {
      photos = <String>[];
      json['photos'].forEach((v) {
        photos!.add(v);
      });
    } else {
      photos = null;
    }
    // colors = json['colors']?.cast<String>();
    if (json['colors'] != null) {
      colors = <String>[];
      json['colors'].forEach((v) {
        colors!.add(v);
      });
    } else {
      colors = null;
    }
    // sizes = json['sizes']?.cast<String>();
    if (json['sizes'] != null) {
      sizes = <String>[];
      json['sizes'].forEach((v) {
        sizes!.add(v);
      });
    } else {
      sizes = null;
    }
    if (json['tags'] != null) {
      tags = <String>[];
      json['tags'].forEach((v) {
        tags!.add(v);
      });
    } else {
      tags = null;
    }
    regularPrice = json['regular_price'];
    currentPrice = json['current_price'];
    quantity = json['quantity'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    inCart = json['in_cart'];
    inWishlist = json['in_wishlist'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['title'] = title;
    if (brand != null) {
      if (data['brand'] is BrandModel) {
        data['brand'] = (brand as BrandModel).toJson();
      }
      if (data['brand'] is String) {
        data['brand'] = brand;
      }
    }
    if (categories != null) {
      if (data['categories'] is List<CategoryModel>) {
        data['categories'] =
            categories?.map((v) => (v as CategoryModel).toJson()).toList();
      }
      if (data['categories'] is List<String>) {
        data['categories'] = categories?.map((v) => v).toList();
      }
    }
    data['slug'] = slug;
    data['meta_description'] = metaDescription;
    data['description'] = description;
    data['photos'] = photos;
    data['colors'] = colors;
    data['sizes'] = sizes;
    data['tags'] = tags;
    data['regular_price'] = regularPrice;
    data['current_price'] = currentPrice;
    data['quantity'] = quantity;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['in_cart'] = inCart;
    data['in_wishlist'] = inWishlist;
    return data;
  }
}
