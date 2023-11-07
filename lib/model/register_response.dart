class RegisterResponse {
  final bool? success;
  final String? msg;
  final Datareg? datareg;

  RegisterResponse({
    this.success,
    this.msg,
    this.datareg,
  });

  RegisterResponse.fromJson(Map<String, dynamic> json)
    : success = json['success'] as bool?,
      msg = json['msg'] as String?,
      datareg = (json['datareg'] as Map<String,dynamic>?) != null ? Datareg.fromJson(json['datareg'] as Map<String,dynamic>) : null;

  Map<String, dynamic> toJson() => {
    'success' : success,
    'msg' : msg,
    'datareg' : datareg?.toJson()
  };
}

class Datareg {
  final String? idreseller;
  final String? idupline;
  final String? namareseller;
  final String? alamatreseller;
  final String? namapemilik;
  final String? idareadomisili;
  final String? patokanhargajual;
  final int? limitTrfsaldo;
  final int? pendapatandownLine;
  final String? tambahanhargapribadi;
  final int? aktif;
  final String? alias;
  final String? waktujoin;
  final int? flagTambahDownLine;
  final int? flagsmspemberitahuanKomisi;
  final int? cityId;
  final int? provinceId;
  final int? districtId;
  final String? koordinat;

  Datareg({
    this.idreseller,
    this.idupline,
    this.namareseller,
    this.alamatreseller,
    this.namapemilik,
    this.idareadomisili,
    this.patokanhargajual,
    this.limitTrfsaldo,
    this.pendapatandownLine,
    this.tambahanhargapribadi,
    this.aktif,
    this.alias,
    this.waktujoin,
    this.flagTambahDownLine,
    this.flagsmspemberitahuanKomisi,
    this.cityId,
    this.provinceId,
    this.districtId,
    this.koordinat,
  });

  Datareg.fromJson(Map<String, dynamic> json)
    : idreseller = json['idreseller'] as String?,
      idupline = json['idupline'] as String?,
      namareseller = json['namareseller'] as String?,
      alamatreseller = json['alamatreseller'] as String?,
      namapemilik = json['namapemilik'] as String?,
      idareadomisili = json['idareadomisili'] as String?,
      patokanhargajual = json['patokanhargajual'] as String?,
      limitTrfsaldo = json['limit_trfsaldo'] as int?,
      pendapatandownLine = json['pendapatandownLine'] as int?,
      tambahanhargapribadi = json['tambahanhargapribadi'] as String?,
      aktif = json['aktif'] as int?,
      alias = json['alias'] as String?,
      waktujoin = json['waktujoin'] as String?,
      flagTambahDownLine = json['flagTambahDownLine'] as int?,
      flagsmspemberitahuanKomisi = json['flagsmspemberitahuanKomisi'] as int?,
      cityId = json['city_id'] as int?,
      provinceId = json['province_id'] as int?,
      districtId = json['district_id'] as int?,
      koordinat = json['koordinat'] as String?;

  Map<String, dynamic> toJson() => {
    'idreseller' : idreseller,
    'idupline' : idupline,
    'namareseller' : namareseller,
    'alamatreseller' : alamatreseller,
    'namapemilik' : namapemilik,
    'idareadomisili' : idareadomisili,
    'patokanhargajual' : patokanhargajual,
    'limit_trfsaldo' : limitTrfsaldo,
    'pendapatandownLine' : pendapatandownLine,
    'tambahanhargapribadi' : tambahanhargapribadi,
    'aktif' : aktif,
    'alias' : alias,
    'waktujoin' : waktujoin,
    'flagTambahDownLine' : flagTambahDownLine,
    'flagsmspemberitahuanKomisi' : flagsmspemberitahuanKomisi,
    'city_id' : cityId,
    'province_id' : provinceId,
    'district_id' : districtId,
    'koordinat' : koordinat
  };
}