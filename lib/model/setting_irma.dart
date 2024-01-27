class SettingIrma {
  final int? id;
  final String? serverKey;
  final String? createdAt;
  final String? updatedAt;

  SettingIrma({
    this.id,
    this.serverKey,
    this.createdAt,
    this.updatedAt,
  });

  SettingIrma.fromJson(Map<String, dynamic> json)
    : id = json['id'] as int?,
      serverKey = json['server_key'] as String?,
      createdAt = json['created_at'] as String?,
      updatedAt = json['updated_at'] as String?;

  Map<String, dynamic> toJson() => {
    'id' : id,
    'server_key' : serverKey,
    'created_at' : createdAt,
    'updated_at' : updatedAt
  };
}