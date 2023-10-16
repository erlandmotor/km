class HistoryTopupResponse {
  final bool? success;
  final int? count;
  final int? countTotal;
  final String? pages;
  final List<dynamic>? data;

  HistoryTopupResponse({
    this.success,
    this.count,
    this.countTotal,
    this.pages,
    this.data,
  });

  HistoryTopupResponse.fromJson(Map<String, dynamic> json)
    : success = json['success'] as bool?,
      count = json['count'] as int?,
      countTotal = json['count_total'] as int?,
      pages = json['pages'] as String?,
      data = json['data'] as List?;

  Map<String, dynamic> toJson() => {
    'success' : success,
    'count' : count,
    'count_total' : countTotal,
    'pages' : pages,
    'data' : data
  };
}