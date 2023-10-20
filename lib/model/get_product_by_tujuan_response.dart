class GetProductByTujuanResponse {
  final bool? succes;
  final List<Data>? data;

  GetProductByTujuanResponse({
    this.succes,
    this.data,
  });

  GetProductByTujuanResponse.fromJson(Map<String, dynamic> json)
    : succes = json['succes'] as bool?,
      data = (json['data'] as List?)?.map((dynamic e) => Data.fromJson(e as Map<String,dynamic>)).toList();

  Map<String, dynamic> toJson() => {
    'succes' : succes,
    'data' : data?.map((e) => e.toJson()).toList()
  };
}

class Data {
  final int? idoperator;
  final String? namaoperator;
  final String? imgurl;
  final List<Produk>? produk;

  Data({
    this.idoperator,
    this.namaoperator,
    this.imgurl,
    this.produk,
  });

  Data.fromJson(Map<String, dynamic> json)
    : idoperator = json['idoperator'] as int?,
      namaoperator = json['namaoperator'] as String?,
      imgurl = json['imgurl'] as String?,
      produk = (json['produk'] as List?)?.map((dynamic e) => Produk.fromJson(e as Map<String,dynamic>)).toList();

  Map<String, dynamic> toJson() => {
    'idoperator' : idoperator,
    'namaoperator' : namaoperator,
    'imgurl' : imgurl,
    'produk' : produk?.map((e) => e.toJson()).toList()
  };
}

class Produk {
  final int? hargajual;
  final int? komisi;
  final int? poin;
  final String? kodeproduk;
  final int? idproduk;
  final String? namaproduk;
  final String? namaoperator;
  final String? imgurl;
  final String? keterangan;
  final int? nominal;
  final int? isgangguan;
  final int? isstokkosong;
  final bool? ispromo;

  Produk({
    this.hargajual,
    this.komisi,
    this.poin,
    this.kodeproduk,
    this.idproduk,
    this.namaproduk,
    this.namaoperator,
    this.imgurl,
    this.keterangan,
    this.nominal,
    this.isgangguan,
    this.isstokkosong,
    this.ispromo,
  });

  Produk.fromJson(Map<String, dynamic> json)
    : hargajual = json['hargajual'] as int?,
      komisi = json['komisi'] as int?,
      poin = json['poin'] as int?,
      kodeproduk = json['kodeproduk'] as String?,
      idproduk = json['idproduk'] as int?,
      namaproduk = json['namaproduk'] as String?,
      namaoperator = json['namaoperator'] as String?,
      imgurl = json['imgurl'] as String?,
      keterangan = json['keterangan'] as String?,
      nominal = json['nominal'] as int?,
      isgangguan = json['isgangguan'] as int?,
      isstokkosong = json['isstokkosong'] as int?,
      ispromo = json['ispromo'] as bool?;

  Map<String, dynamic> toJson() => {
    'hargajual' : hargajual,
    'komisi' : komisi,
    'poin' : poin,
    'kodeproduk' : kodeproduk,
    'idproduk' : idproduk,
    'namaproduk' : namaproduk,
    'namaoperator' : namaoperator,
    'imgurl' : imgurl,
    'keterangan' : keterangan,
    'nominal' : nominal,
    'isgangguan' : isgangguan,
    'isstokkosong' : isstokkosong,
    'ispromo' : ispromo
  };
}