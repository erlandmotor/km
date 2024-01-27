class TopupMessageResponse {
  final bool? success;
  final String? msg;

  TopupMessageResponse({
    this.success,
    this.msg,
  });

  TopupMessageResponse.fromJson(Map<String, dynamic> json)
    : success = json['success'] as bool?,
      msg = json['msg'] as String?;

  Map<String, dynamic> toJson() => {
    'success' : success,
    'msg' : msg
  };
}