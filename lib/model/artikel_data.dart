class ArtikelData {
  final int? id;
  final String? title;
  final String? content;
  final String? coverImage;
  final int? status;
  final String? createdAt;
  final String? updatedAt;

  ArtikelData({
    this.id,
    this.title,
    this.content,
    this.coverImage,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  ArtikelData.fromJson(Map<String, dynamic> json)
    : id = json['id'] as int?,
      title = json['title'] as String?,
      content = json['content'] as String?,
      coverImage = json['cover_image'] as String?,
      status = json['status'] as int?,
      createdAt = json['created_at'] as String?,
      updatedAt = json['updated_at'] as String?;

  Map<String, dynamic> toJson() => {
    'id' : id,
    'title' : title,
    'content' : content,
    'cover_image' : coverImage,
    'status' : status,
    'created_at' : createdAt,
    'updated_at' : updatedAt
  };
}