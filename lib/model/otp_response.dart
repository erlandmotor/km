class OtpResponse {
  final bool? success;
  final String? message;

  OtpResponse({
    this.success,
    this.message,
  });

  OtpResponse.fromJson(Map<String, dynamic> json)
    : success = json['success'] as bool?,
      message = json['message'] as String?;

  Map<String, dynamic> toJson() => {
    'success' : success,
    'message' : message
  };
}