class MainMenuMobile {
  final int? id;
  final String? name;
  final String? type;
  final String? operatorid;
  final String? icon;
  final String? containercolor;
  final int? order;
  final String? createdAt;
  final String? updatedAt;

  MainMenuMobile({
    this.id,
    this.name,
    this.type,
    this.operatorid,
    this.icon,
    this.containercolor,
    this.order,
    this.createdAt,
    this.updatedAt,
  });

  MainMenuMobile.fromJson(Map<String, dynamic> json)
    : id = json['id'] as int?,
      name = json['name'] as String?,
      type = json['type'] as String?,
      operatorid = json['operatorid'] as String?,
      icon = json['icon'] as String?,
      containercolor = json['containercolor'] as String?,
      order = json['order'] as int?,
      createdAt = json['created_at'] as String?,
      updatedAt = json['updated_at'] as String?;

  Map<String, dynamic> toJson() => {
    'id' : id,
    'name' : name,
    'type' : type,
    'operatorid' : operatorid,
    'icon' : icon,
    'containercolor' : containercolor,
    'order' : order,
    'created_at' : createdAt,
    'updated_at' : updatedAt
  };
}