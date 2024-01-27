class AlfamartPaymentResponse {
  final bool? success;
  final Data? data;

  AlfamartPaymentResponse({
    this.success,
    this.data,
  });

  AlfamartPaymentResponse.fromJson(Map<String, dynamic> json)
    : success = json['success'] as bool?,
      data = (json['data'] as Map<String,dynamic>?) != null ? Data.fromJson(json['data'] as Map<String,dynamic>) : null;

  Map<String, dynamic> toJson() => {
    'success' : success,
    'data' : data?.toJson()
  };
}

class Data {
  final String? retailOutletName;
  final String? paymentCode;
  final String? name;
  final int? transferAmount;

  Data({
    this.retailOutletName,
    this.paymentCode,
    this.name,
    this.transferAmount,
  });

  Data.fromJson(Map<String, dynamic> json)
    : retailOutletName = json['retail_outlet_name'] as String?,
      paymentCode = json['payment_code'] as String?,
      name = json['name'] as String?,
      transferAmount = json['transfer_amount'] as int?;

  Map<String, dynamic> toJson() => {
    'retail_outlet_name' : retailOutletName,
    'payment_code' : paymentCode,
    'name' : name,
    'transfer_amount' : transferAmount
  };
}