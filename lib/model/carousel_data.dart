class CarouselData {
  final int? id;
  final String? filename;
  final String? createdAt;
  final String? updatedAt;

  CarouselData({
    this.id,
    this.filename,
    this.createdAt,
    this.updatedAt,
  });

  CarouselData.fromJson(Map<String, dynamic> json)
    : id = json['id'] as int?,
      filename = json['filename'] as String?,
      createdAt = json['created_at'] as String?,
      updatedAt = json['updated_at'] as String?;

  Map<String, dynamic> toJson() => {
    'id' : id,
    'filename' : filename,
    'created_at' : createdAt,
    'updated_at' : updatedAt
  };
}