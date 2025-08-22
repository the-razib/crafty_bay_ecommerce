import 'package:crafty_bay_ecommerce/features/home/data/models/slider_model.dart';

class PaginateModel {
  List<SliderModel>? results;
  int? total;
  int? firstPage;
  int? previous;
  int? next;
  int? lastPage;

  PaginateModel(
      {this.results,
      this.total,
      this.firstPage,
      this.previous,
      this.next,
      this.lastPage});

  PaginateModel.fromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      results = <SliderModel>[];
      json['results'].forEach((v) {
        results!.add(SliderModel.fromJson(v));
      });
    }
    total = json['total'];
    firstPage = json['first_page'];
    previous = json['previous'];
    next = json['next'];
    lastPage = json['last_page'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (results != null) {
      data['results'] = results!.map((v) => v.toJson()).toList();
    }
    data['total'] = total;
    data['first_page'] = firstPage;
    data['previous'] = previous;
    data['next'] = next;
    data['last_page'] = lastPage;
    return data;
  }
}
