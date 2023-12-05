class FindLastTransactionResponse {
  final String? idtransaksi;
  final int? hARGAJUAL;

  FindLastTransactionResponse({
    this.idtransaksi,
    this.hARGAJUAL,
  });

  FindLastTransactionResponse.fromJson(Map<String, dynamic> json)
    : idtransaksi = json['idtransaksi'] as String?,
      hARGAJUAL = json['HARGAJUAL'] as int?;

  Map<String, dynamic> toJson() => {
    'idtransaksi' : idtransaksi,
    'HARGAJUAL' : hARGAJUAL
  };
}