class RunningTextData {
  final int? id;
  final String? text;
  final String? kategori;
  final String? createdAt;
  final String? updatedAt;

  RunningTextData({
    this.id,
    this.text,
    this.kategori,
    this.createdAt,
    this.updatedAt,
  });

  RunningTextData.fromJson(Map<String, dynamic> json)
    : id = json['id'] as int?,
      text = json['text'] as String?,
      kategori = json['kategori'] as String?,
      createdAt = json['created_at'] as String?,
      updatedAt = json['updated_at'] as String?;

  Map<String, dynamic> toJson() => {
    'id' : id,
    'text' : text,
    'kategori' : kategori,
    'created_at' : createdAt,
    'updated_at' : updatedAt
  };
}