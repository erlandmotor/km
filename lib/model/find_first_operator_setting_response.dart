class FindFirstOperatorSettingResponse {
  final int? id;
  final String? name;
  final String? listproductid;
  final String? createdAt;
  final String? updatedAt;

  FindFirstOperatorSettingResponse({
    this.id,
    this.name,
    this.listproductid,
    this.createdAt,
    this.updatedAt,
  });

  FindFirstOperatorSettingResponse.fromJson(Map<String, dynamic> json)
    : id = json['id'] as int?,
      name = json['name'] as String?,
      listproductid = json['listproductid'] as String?,
      createdAt = json['created_at'] as String?,
      updatedAt = json['updated_at'] as String?;

  Map<String, dynamic> toJson() => {
    'id' : id,
    'name' : name,
    'listproductid' : listproductid,
    'created_at' : createdAt,
    'updated_at' : updatedAt
  };
}