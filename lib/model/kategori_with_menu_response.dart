class KategoriWithMenuResponse {
  final Kategoridata? kategoridata;
  final List<Menulist>? menulist;

  KategoriWithMenuResponse({
    this.kategoridata,
    this.menulist,
  });

  KategoriWithMenuResponse.fromJson(Map<String, dynamic> json)
    : kategoridata = (json['kategoridata'] as Map<String,dynamic>?) != null ? Kategoridata.fromJson(json['kategoridata'] as Map<String,dynamic>) : null,
      menulist = (json['menulist'] as List?)?.map((dynamic e) => Menulist.fromJson(e as Map<String,dynamic>)).toList();

  Map<String, dynamic> toJson() => {
    'kategoridata' : kategoridata?.toJson(),
    'menulist' : menulist?.map((e) => e.toJson()).toList()
  };
}

class Kategoridata {
  final int? id;
  final String? name;
  final int? order;
  final String? createdAt;
  final String? updatedAt;

  Kategoridata({
    this.id,
    this.name,
    this.order,
    this.createdAt,
    this.updatedAt,
  });

  Kategoridata.fromJson(Map<String, dynamic> json)
    : id = json['id'] as int?,
      name = json['name'] as String?,
      order = json['order'] as int?,
      createdAt = json['created_at'] as String?,
      updatedAt = json['updated_at'] as String?;

  Map<String, dynamic> toJson() => {
    'id' : id,
    'name' : name,
    'order' : order,
    'created_at' : createdAt,
    'updated_at' : updatedAt
  };
}

class Menulist {
  final int? id;
  final String? name;
  final String? type;
  final String? operatorid;
  final String? icon;
  final String? containercolor;
  final int? order;
  final String? url;
  final int? settingMenuKategoriId;
  final String? createdAt;
  final String? updatedAt;

  Menulist({
    this.id,
    this.name,
    this.type,
    this.operatorid,
    this.icon,
    this.containercolor,
    this.order,
    this.url,
    this.settingMenuKategoriId,
    this.createdAt,
    this.updatedAt,
  });

  Menulist.fromJson(Map<String, dynamic> json)
    : id = json['id'] as int?,
      name = json['name'] as String?,
      type = json['type'] as String?,
      operatorid = json['operatorid'] as String?,
      icon = json['icon'] as String?,
      containercolor = json['containercolor'] as String?,
      order = json['order'] as int?,
      url = json['url'] as String?,
      settingMenuKategoriId = json['setting_menu_kategori_id'] as int?,
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
    'url' : url,
    'setting_menu_kategori_id' : settingMenuKategoriId,
    'created_at' : createdAt,
    'updated_at' : updatedAt
  };
}