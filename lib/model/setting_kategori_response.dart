class SettingKategoriResponse {
  final int? id;
  final String? name;
  final String? title;
  final String? image;
  final String? kategori;
  final String? kodeproduk;
  final String? createdAt;
  final String? updatedAt;

  SettingKategoriResponse({
    this.id,
    this.name,
    this.title,
    this.image,
    this.kategori,
    this.kodeproduk,
    this.createdAt,
    this.updatedAt,
  });

  SettingKategoriResponse.fromJson(Map<String, dynamic> json)
    : id = json['id'] as int?,
      name = json['name'] as String?,
      title = json['title'] as String?,
      image = json['image'] as String?,
      kategori = json['kategori'] as String?,
      kodeproduk = json['kodeproduk'] as String?,
      createdAt = json['created_at'] as String?,
      updatedAt = json['updated_at'] as String?;

  Map<String, dynamic> toJson() => {
    'id' : id,
    'name' : name,
    'title' : title,
    'image' : image,
    'kategori' : kategori,
    'kodeproduk' : kodeproduk,
    'created_at' : createdAt,
    'updated_at' : updatedAt
  };
}