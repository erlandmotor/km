class PricelistGroupResponse {
  final bool? success;
  final List<Data>? data;

  PricelistGroupResponse({
    this.success,
    this.data,
  });

  PricelistGroupResponse.fromJson(Map<String, dynamic> json)
    : success = json['success'] as bool?,
      data = (json['data'] as List?)?.map((dynamic e) => Data.fromJson(e as Map<String,dynamic>)).toList();

  Map<String, dynamic> toJson() => {
    'success' : success,
    'data' : data?.map((e) => e.toJson()).toList()
  };
}

class Data {
  final int? idoperator;
  final String? namaoperator;
  final List<Produk>? produk;

  Data({
    this.idoperator,
    this.namaoperator,
    this.produk,
  });

  Data.fromJson(Map<String, dynamic> json)
    : idoperator = json['idoperator'] as int?,
      namaoperator = json['namaoperator'] as String?,
      produk = (json['produk'] as List?)?.map((dynamic e) => Produk.fromJson(e as Map<String,dynamic>)).toList();

  Map<String, dynamic> toJson() => {
    'idoperator' : idoperator,
    'namaoperator' : namaoperator,
    'produk' : produk?.map((e) => e.toJson()).toList()
  };
}

class Produk {
  final int? hargajual;
  final int? komisi;
  final String? kodeproduk;
  final String? namaproduk;
  final String? namaoperator;
  final String? imgurl;
  final String? keterangan;
  final String? jenisproduk;

  Produk({
    this.hargajual,
    this.komisi,
    this.kodeproduk,
    this.namaproduk,
    this.namaoperator,
    this.imgurl,
    this.keterangan,
    this.jenisproduk,
  });

  Produk.fromJson(Map<String, dynamic> json)
    : hargajual = json['hargajual'] as int?,
      komisi = json['komisi'] as int?,
      kodeproduk = json['kodeproduk'] as String?,
      namaproduk = json['namaproduk'] as String?,
      namaoperator = json['namaoperator'] as String?,
      imgurl = json['imgurl'] as String?,
      keterangan = json['keterangan'] as String?,
      jenisproduk = json['jenisproduk'] as String?;

  Map<String, dynamic> toJson() => {
    'hargajual' : hargajual,
    'komisi' : komisi,
    'kodeproduk' : kodeproduk,
    'namaproduk' : namaproduk,
    'namaoperator' : namaoperator,
    'imgurl' : imgurl,
    'keterangan' : keterangan,
    'jenisproduk' : jenisproduk
  };
}