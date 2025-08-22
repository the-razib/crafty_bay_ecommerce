class PaginateModel<T> {
  final List<T> results;
  final int total;
  final int? firstPage;
  final int? previous;
  final int? next;
  final int? lastPage;

  PaginateModel({
    required this.results,
    required this.total,
    this.firstPage,
    this.previous,
    this.next,
    this.lastPage,
  });

  factory PaginateModel.fromJson(
    Map<String, dynamic> json,
    T Function(Map<String, dynamic> json) fromJsonT,
  ) {
    return PaginateModel<T>(
      results: json['results'] != null
          ? (json['results'] as List).map((item) => fromJsonT(item)).toList()
          : <T>[], // Handle null results by returning an empty list
      total: json['total'] ?? 0, // Handle null total by defaulting to 0
      firstPage: json['first_page'],
      previous: json['previous'],
      next: json['next'],
      lastPage: json['last_page'],
    );
  }

  Map<String, dynamic> toJson(Object? Function(T value) toJsonT) {
    return {
      'results': results.map((item) => toJsonT(item)).toList(),
      'total': total,
      'first_page': firstPage,
      'previous': previous,
      'next': next,
      'last_page': lastPage,
    };
  }
}
