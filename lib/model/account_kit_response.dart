class AccountKitResponse {
  final bool? success;
  final int? rc;
  final String? msg;
  final String? idrs;
  final String? namars;
  final Datars? datars;
  final String? saldo;

  AccountKitResponse({
    this.success,
    this.rc,
    this.msg,
    this.idrs,
    this.namars,
    this.datars,
    this.saldo,
  });

  AccountKitResponse.fromJson(Map<String, dynamic> json)
    : success = json['success'] as bool?,
      rc = json['rc'] as int?,
      msg = json['msg'] as String?,
      idrs = json['idrs'] as String?,
      namars = json['namars'] as String?,
      datars = (json['datars'] as Map<String,dynamic>?) != null ? Datars.fromJson(json['datars'] as Map<String,dynamic>) : null,
      saldo = json['saldo'] as String?;

  Map<String, dynamic> toJson() => {
    'success' : success,
    'rc' : rc,
    'msg' : msg,
    'idrs' : idrs,
    'namars' : namars,
    'datars' : datars?.toJson(),
    'saldo' : saldo
  };
}

class Datars {
  final String? idreseller;
  final String? namareseller;
  final int? saldo;
  final int? blokir;
  final String? idupline;
  final String? nAMARESELLER;
  final String? alamatreseller;
  final String? pin;
  final int? komisilangsung;
  final int? patokanhargajual;
  final int? tambahanhargapribadi;
  final int? tambahanhargaupline;
  final String? aktif;
  final int? pendapatanDownLine;
  final String? flagTambahDownLine;
  final String? yM1;
  final String? yM2;
  final String? gt;
  final String? iPStatic;
  final String? urlReport;
  final int? periodepemberiankomisi;
  final String? flagSMSPemberitahuanKomisi;
  final String? waktuJoin;
  final int? isdealer;
  final String? aktivitasTerakhir;
  final int? idAreaDomisili;
  final String? usernameweb;
  final String? passwordweb;
  final int? ijinkantrxonline;
  final String? smspromo;
  final int? tempo;
  final int? maxnota;
  final int? limitpiutang;
  final String? tipe;
  final String? alias;
  final String? trxtanpapin;
  final String? tipesaldo;
  final String? blokirtrx;
  final String? autoubahjalurharga;
  final String? koordinat;
  final int? poin;
  final int? komisi;
  final int? limitTrfsaldo;
  final int? blokirAttemp;
  final String? namapemilik;
  final String? noktp;
  final String? tgllahir;
  final String? ibukandung;
  final String? telp;
  final String? email;
  final int? provinceId;
  final int? cityId;
  final int? districtId;
  final String? kodepos;
  final int? updateby;
  final String? updateAt;

  Datars({
    this.idreseller,
    this.namareseller,
    this.saldo,
    this.blokir,
    this.idupline,
    this.nAMARESELLER,
    this.alamatreseller,
    this.pin,
    this.komisilangsung,
    this.patokanhargajual,
    this.tambahanhargapribadi,
    this.tambahanhargaupline,
    this.aktif,
    this.pendapatanDownLine,
    this.flagTambahDownLine,
    this.yM1,
    this.yM2,
    this.gt,
    this.iPStatic,
    this.urlReport,
    this.periodepemberiankomisi,
    this.flagSMSPemberitahuanKomisi,
    this.waktuJoin,
    this.isdealer,
    this.aktivitasTerakhir,
    this.idAreaDomisili,
    this.usernameweb,
    this.passwordweb,
    this.ijinkantrxonline,
    this.smspromo,
    this.tempo,
    this.maxnota,
    this.limitpiutang,
    this.tipe,
    this.alias,
    this.trxtanpapin,
    this.tipesaldo,
    this.blokirtrx,
    this.autoubahjalurharga,
    this.koordinat,
    this.poin,
    this.komisi,
    this.limitTrfsaldo,
    this.blokirAttemp,
    this.namapemilik,
    this.noktp,
    this.tgllahir,
    this.ibukandung,
    this.telp,
    this.email,
    this.provinceId,
    this.cityId,
    this.districtId,
    this.kodepos,
    this.updateby,
    this.updateAt,
  });

  Datars.fromJson(Map<String, dynamic> json)
    : idreseller = json['idreseller'] as String?,
      namareseller = json['namareseller'] as String?,
      saldo = json['saldo'] as int?,
      blokir = json['blokir'] as int?,
      idupline = json['idupline'] as String?,
      nAMARESELLER = json['NAMARESELLER'] as String?,
      alamatreseller = json['alamatreseller'] as String?,
      pin = json['pin'] as String?,
      komisilangsung = json['komisilangsung'] as int?,
      patokanhargajual = json['patokanhargajual'] as int?,
      tambahanhargapribadi = json['tambahanhargapribadi'] as int?,
      tambahanhargaupline = json['tambahanhargaupline'] as int?,
      aktif = json['Aktif'] as String?,
      pendapatanDownLine = json['PendapatanDownLine'] as int?,
      flagTambahDownLine = json['FlagTambahDownLine'] as String?,
      yM1 = json['YM1'] as String?,
      yM2 = json['YM2'] as String?,
      gt = json['gt'] as String?,
      iPStatic = json['IPStatic'] as String?,
      urlReport = json['UrlReport'] as String?,
      periodepemberiankomisi = json['periodepemberiankomisi'] as int?,
      flagSMSPemberitahuanKomisi = json['FlagSMSPemberitahuanKomisi'] as String?,
      waktuJoin = json['WaktuJoin'] as String?,
      isdealer = json['isdealer'] as int?,
      aktivitasTerakhir = json['AktivitasTerakhir'] as String?,
      idAreaDomisili = json['IdAreaDomisili'] as int?,
      usernameweb = json['usernameweb'] as String?,
      passwordweb = json['passwordweb'] as String?,
      ijinkantrxonline = json['ijinkantrxonline'] as int?,
      smspromo = json['smspromo'] as String?,
      tempo = json['tempo'] as int?,
      maxnota = json['maxnota'] as int?,
      limitpiutang = json['limitpiutang'] as int?,
      tipe = json['tipe'] as String?,
      alias = json['alias'] as String?,
      trxtanpapin = json['trxtanpapin'] as String?,
      tipesaldo = json['tipesaldo'] as String?,
      blokirtrx = json['blokirtrx'] as String?,
      autoubahjalurharga = json['autoubahjalurharga'] as String?,
      koordinat = json['koordinat'] as String?,
      poin = json['poin'] as int?,
      komisi = json['komisi'] as int?,
      limitTrfsaldo = json['limit_trfsaldo'] as int?,
      blokirAttemp = json['blokir_attemp'] as int?,
      namapemilik = json['namapemilik'] as String?,
      noktp = json['noktp'] as String?,
      tgllahir = json['tgllahir'] as String?,
      ibukandung = json['ibukandung'] as String?,
      telp = json['telp'] as String?,
      email = json['email'] as String?,
      provinceId = json['province_id'] as int?,
      cityId = json['city_id'] as int?,
      districtId = json['district_id'] as int?,
      kodepos = json['kodepos'] as String?,
      updateby = json['updateby'] as int?,
      updateAt = json['updateAt'] as String?;

  Map<String, dynamic> toJson() => {
    'idreseller' : idreseller,
    'namareseller' : namareseller,
    'saldo' : saldo,
    'blokir' : blokir,
    'idupline' : idupline,
    'NAMARESELLER' : nAMARESELLER,
    'alamatreseller' : alamatreseller,
    'pin' : pin,
    'komisilangsung' : komisilangsung,
    'patokanhargajual' : patokanhargajual,
    'tambahanhargapribadi' : tambahanhargapribadi,
    'tambahanhargaupline' : tambahanhargaupline,
    'Aktif' : aktif,
    'PendapatanDownLine' : pendapatanDownLine,
    'FlagTambahDownLine' : flagTambahDownLine,
    'YM1' : yM1,
    'YM2' : yM2,
    'gt' : gt,
    'IPStatic' : iPStatic,
    'UrlReport' : urlReport,
    'periodepemberiankomisi' : periodepemberiankomisi,
    'FlagSMSPemberitahuanKomisi' : flagSMSPemberitahuanKomisi,
    'WaktuJoin' : waktuJoin,
    'isdealer' : isdealer,
    'AktivitasTerakhir' : aktivitasTerakhir,
    'IdAreaDomisili' : idAreaDomisili,
    'usernameweb' : usernameweb,
    'passwordweb' : passwordweb,
    'ijinkantrxonline' : ijinkantrxonline,
    'smspromo' : smspromo,
    'tempo' : tempo,
    'maxnota' : maxnota,
    'limitpiutang' : limitpiutang,
    'tipe' : tipe,
    'alias' : alias,
    'trxtanpapin' : trxtanpapin,
    'tipesaldo' : tipesaldo,
    'blokirtrx' : blokirtrx,
    'autoubahjalurharga' : autoubahjalurharga,
    'koordinat' : koordinat,
    'poin' : poin,
    'komisi' : komisi,
    'limit_trfsaldo' : limitTrfsaldo,
    'blokir_attemp' : blokirAttemp,
    'namapemilik' : namapemilik,
    'noktp' : noktp,
    'tgllahir' : tgllahir,
    'ibukandung' : ibukandung,
    'telp' : telp,
    'email' : email,
    'province_id' : provinceId,
    'city_id' : cityId,
    'district_id' : districtId,
    'kodepos' : kodepos,
    'updateby' : updateby,
    'updateAt' : updateAt
  };
}