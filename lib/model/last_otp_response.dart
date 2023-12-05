class LastOtpResponse {
  final String? message;
  final String? expiredDate;

  LastOtpResponse({
    this.message,
    this.expiredDate,
  });

  LastOtpResponse.fromJson(Map<String, dynamic> json)
    : message = json['message'] as String?,
      expiredDate = json['expired_date'] as String?;

  Map<String, dynamic> toJson() => {
    'message' : message,
    'expired_date' : expiredDate
  };
}