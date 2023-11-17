class ParsedCetakResponse {
  final int? cachedJumlah;
  final String? type;
  final String? judul;
  final String? waktu;
  final String? idtrx;
  final String? idpel;
  final String? tagihan;  
  final String? tarif;  
  final String? totalBayar;
  final String? nama;
  final String? alamat;  
  final String? tarifDaya;  
  final String? standMeter;
  final String? blnTag;
  final String? blnThn;
  final String? noReff;
  final String? pernyataan;
  final String? jumlahTag;  
  final String? denda;  
  final String? angsuranKe;  
  final String? jmlPeserta;  
  final String? rekening;  
  final String? namaBank;  
  final String? kodeBank;  
  final String? adminBank;  
  final String? jasaLoket;  
  final String? nominal;  
  final String? jatuhTempo;  
  final String? noMeter;  
  final String? outlet;  
  final String? td;  
  final String? kwh;  
  final String? noTujuan;
  final String? produk; 
  final String? serialNumber; 
  final String? akun; 
  final String? ecommerce; 
  final String? token; 
  final String? sn; 

  ParsedCetakResponse({
    this.cachedJumlah,
    this.type,
    this.judul,
    this.waktu,
    this.idtrx,
    this.idpel,
    this.tagihan,
    this.tarif,
    this.nama,
    this.alamat,
    this.tarifDaya,
    this.blnTag,
    this.blnThn,
    this.standMeter,
    this.noReff,
    this.totalBayar,
    this.pernyataan,
    this.jumlahTag,
    this.denda,
    this.angsuranKe,
    this.jmlPeserta,
    this.rekening,
    this.namaBank,
    this.kodeBank,
    this.adminBank,
    this.jasaLoket,
    this.nominal,
    this.jatuhTempo,
    this.noMeter,
    this.outlet,
    this.td,
    this.kwh,
    this.noTujuan,
    this.produk,
    this.serialNumber,
    this.akun,
    this.ecommerce,
    this.token,
    this.sn
  });

  ParsedCetakResponse.fromJson(Map<String, dynamic> json)
    : cachedJumlah = json['cached_jumlah'] as int?,
      type = json['type'] as String?,
      judul = json['judul'] as String?,
      waktu = json['waktu'] as String?,
      idtrx = json['idtrx'] as String?,
      idpel = json['idpel'] as String?,
      tagihan = json['tagihan'] as String?,  
      tarif = json['tarif'] as String?,  
      nama = json['nama'] as String?,
      alamat = json['alamat'] as String?,  
      tarifDaya = json['tarif_daya'] as String?,  
      blnTag = json['bln_tag'] as String?,
      blnThn = json['bln_thn'] as String?,
      standMeter = json['stand_meter'] as String?,
      noReff = json['no_reff'] as String?,
      totalBayar = json['total_bayar'] as String?,
      pernyataan = json['pernyataan'] as String?,
      jumlahTag = json['jumlah_tag'] as String?,  
      denda = json['denda'] as String?,  
      angsuranKe = json['angsuran_ke'] as String?,  
      jmlPeserta = json['jml_peserta'] as String?,
      rekening = json['rekening'] as String?,  
      namaBank = json['nama_bank'] as String?,  
      kodeBank = json['kode_bank'] as String?,   
      adminBank = json['admin_bank'] as String?,  
      jasaLoket = json['jasa_loket'] as String?,  
      nominal = json['nominal'] as String?,  
      jatuhTempo = json['jatuh_tempo'] as String?,  
      noMeter = json['no_meter'] as String?,  
      outlet = json['outlet'] as String?,  
      td = json['td'] as String?,  
      kwh = json['kwh'] as String?,  
      noTujuan = json['no_tujuan'] as String?,  
      produk = json['produk'] as String?,  
      serialNumber = json['serial_number'] as String?,  
      akun = json['akun'] as String?,  
      ecommerce = json['ecommerce'] as String?,  
      token = json['token'] as String?,  
      sn = json['sn'] as String?;  

  Map<String, dynamic> toJson() => {
    'cached_jumlah' : cachedJumlah,
    'type' : type,
    'judul' : judul,
    'waktu' : waktu,
    'idtrx' : idtrx,
    'idpel' : idpel,
    'tagihan': tagihan,
    'tarif': tarif,
    'nama' : nama,
    'alamat': alamat,
    'tarif_daya': tarifDaya,
    'bln_tag' : blnTag,
    'bln_thn' : blnThn,
    'stand_meter' : standMeter,
    'no_reff' : noReff,
    'total_bayar' : totalBayar,
    'pernyataan' : pernyataan,
    'jumlah_tag': jumlahTag,
    'denda': denda,
    'angsuran_ke': angsuranKe,
    'jml_peserta': jmlPeserta,
    'rekening': rekening,
    'nama_bank': namaBank,
    'kode_bank': kodeBank,
    'admin_bank': adminBank,
    'jasa_loket': jasaLoket,
    'nominal': nominal,
    'jatuh_tempo': jatuhTempo,
    'no_meter': noMeter,
    'outlet': outlet,
    'td': td,
    'kwh': kwh,
    'no_tujuan': noTujuan,
    'produk': produk,
    'serial_number': serialNumber,
    'akun': akun,
    'ecommerce': ecommerce,
    'token': token,
    'sn': sn
  };
}