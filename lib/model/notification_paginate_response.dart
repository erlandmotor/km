class NotificationPaginateResponse {
  final List<NotificationData>? data;
  final Paginate? paginate;

  NotificationPaginateResponse({
    this.data,
    this.paginate,
  });

  NotificationPaginateResponse.fromJson(Map<String, dynamic> json)
    : data = (json['data'] as List?)?.map((dynamic e) => NotificationData.fromJson(e as Map<String,dynamic>)).toList(),
      paginate = (json['paginate'] as Map<String,dynamic>?) != null ? Paginate.fromJson(json['paginate'] as Map<String,dynamic>) : null;

  Map<String, dynamic> toJson() => {
    'data' : data?.map((e) => e.toJson()).toList(),
    'paginate' : paginate?.toJson()
  };
}

class NotificationData {
  final int? id;
  final String? title;
  final String? content;
  final String? createdAt;
  final String? updatedAt;

  NotificationData({
    this.id,
    this.title,
    this.content,
    this.createdAt,
    this.updatedAt,
  });

  NotificationData.fromJson(Map<String, dynamic> json)
    : id = json['id'] as int?,
      title = json['title'] as String?,
      content = json['content'] as String?,
      createdAt = json['created_at'] as String?,
      updatedAt = json['updated_at'] as String?;

  Map<String, dynamic> toJson() => {
    'id' : id,
    'title' : title,
    'content' : content,
    'created_at' : createdAt,
    'updated_at' : updatedAt
  };
}

class Paginate {
  final int? perPage;
  final int? totalPage;
  final int? count;
  final int? currentPage;

  Paginate({
    this.perPage,
    this.totalPage,
    this.count,
    this.currentPage,
  });

  Paginate.fromJson(Map<String, dynamic> json)
    : perPage = json['per_page'] as int?,
      totalPage = json['total_page'] as int?,
      count = json['count'] as int?,
      currentPage = json['current_page'] as int?;

  Map<String, dynamic> toJson() => {
    'per_page' : perPage,
    'total_page' : totalPage,
    'count' : count,
    'current_page' : currentPage
  };
}