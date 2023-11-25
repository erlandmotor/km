class CetakMobileResponse {
  final String? idtrx;
  final String? struk;

  CetakMobileResponse({
    this.idtrx,
    this.struk,
  });

  CetakMobileResponse.fromJson(Map<String, dynamic> json)
    : idtrx = json['idtrx'] as String?,
      struk = json['struk'] as String?;

  Map<String, dynamic> toJson() => {
    'idtrx' : idtrx,
    'struk' : struk
  };
}