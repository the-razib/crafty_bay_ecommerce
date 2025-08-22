import 'package:crafty_bay_ecommerce/features/common/data/models/category_model.dart';

class ProductModel {
  String? sId;
  String? title;
  List<CategoryModel>? categories;
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
  CategoryModel? brand;

  ProductModel(
      {this.sId,
      this.title,
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
      this.brand});

  ProductModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    // if (json['categories'] != null) {
    //   categories = <CategoryModel>[];
    //   json['categories'].forEach((v) {
    //     categories!.add(CategoryModel.fromJson(v));
    //   });
    // }
    // Handle categories (list of strings or list of objects)
    if (json['categories'] != null) {
      categories = <CategoryModel>[];
      if (json['categories'].isNotEmpty && json['categories'][0] is String) {
        // Case 1: categories is a list of strings (category IDs)
        json['categories'].forEach((v) {
          categories!.add(CategoryModel(sId: v)); // Only set the _id field
        });
      } else {
        // Case 2: categories is a list of objects (full category details)
        json['categories'].forEach((v) {
          categories!.add(CategoryModel.fromJson(v));
        });
      }
    }
    slug = json['slug'];
    metaDescription = json['meta_description'];
    description = json['description'];
    if (json['photos'] != null) {
      photos = <String>[];
      json['photos'].forEach((v) {
        photos!.add(v);
      });
    }
    if (json['colors'] != null) {
      colors = <String>[];
      json['colors'].forEach((v) {
        colors!.add(v);
      });
    }
    if (json['sizes'] != null) {
      sizes = <String>[];
      json['sizes'].forEach((v) {
        sizes!.add(v);
      });
    }
    if (json['tags'] != null) {
      tags = <String>[];
      json['tags'].forEach((v) {
        tags!.add(v);
      });
    }
    regularPrice = json['regular_price'];
    currentPrice = json['current_price'];
    quantity = json['quantity'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    if (json['brand'] != null) {
      if (json['brand'] is String) {
        // Case 1: brand is a string (brand ID)
        brand = CategoryModel(sId: json['brand']);
      } else {
        // Case 2: brand is a JSON object (full brand details)
        brand = CategoryModel.fromJson(json['brand']);
      }
    }
    // brand =
    //     json['brand'] != null ? CategoryModel.fromJson(json['brand']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['title'] = title;
    if (categories != null) {
      data['categories'] = categories!.map((v) => v.toJson()).toList();
    }
    data['slug'] = slug;
    data['meta_description'] = metaDescription;
    data['description'] = description;
    if (photos != null) {
      data['photos'] = photos!.map((v) => v).toList();
    }
    data['colors'] = colors;
    data['sizes'] = sizes;
    if (tags != null) {
      data['tags'] = tags!.map((v) => v).toList();
    }
    data['regular_price'] = regularPrice;
    data['current_price'] = currentPrice;
    data['quantity'] = quantity;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    if (brand != null) {
      data['brand'] = brand!.toJson();
    }
    return data;
  }
}
