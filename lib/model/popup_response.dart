class PopupResponse {
  final int? id;
  final String? image;
  final int? status;
  final String? createdAt;
  final String? updatedAt;

  PopupResponse({
    this.id,
    this.image,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  PopupResponse.fromJson(Map<String, dynamic> json)
    : id = json['id'] as int?,
      image = json['image'] as String?,
      status = json['status'] as int?,
      createdAt = json['created_at'] as String?,
      updatedAt = json['updated_at'] as String?;

  Map<String, dynamic> toJson() => {
    'id' : id,
    'image' : image,
    'status' : status,
    'created_at' : createdAt,
    'updated_at' : updatedAt
  };
}