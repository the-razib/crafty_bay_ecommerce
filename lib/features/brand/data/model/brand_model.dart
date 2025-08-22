class BrandModel {
  String? sId;
  String? title;
  String? slug;
  String? icon;

  BrandModel({this.sId, this.title, this.slug, this.icon});

  BrandModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    slug = json['slug'];
    icon = json['icon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['title'] = title;
    data['slug'] = slug;
    data['icon'] = icon;
    return data;
  }
}
