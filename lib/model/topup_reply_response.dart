class TopupReplyResponse {
  final bool? success;
  final String? msg;
  final int? jumlah;

  TopupReplyResponse({
    this.success,
    this.msg,
    this.jumlah,
  });

  TopupReplyResponse.fromJson(Map<String, dynamic> json)
    : success = json['success'] as bool?,
      msg = json['msg'] as String?,
      jumlah = json['jumlah'] as int?;

  Map<String, dynamic> toJson() => {
    'success' : success,
    'msg' : msg,
    'jumlah' : jumlah
  };
}