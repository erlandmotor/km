class StrukModel {
  final String? nama;
  final String? alamat;
  final String? footer;

  StrukModel({ required this.nama, required this.alamat, required this.footer });

  StrukModel.fromJson(Map<String, dynamic> json)
    : nama = json['nama'] as String?,
      alamat = json['alamat'] as String?,
      footer = json['footer'] as String?;

  Map<String, dynamic> toJson() => {
    'nama' : nama,
    'alamat' : alamat,
    'footer': footer
  };
}