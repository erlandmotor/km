class ConnectedBluetoothData {
  final String? remoteId;
  final String? deviceName;

  ConnectedBluetoothData({
    this.remoteId,
    this.deviceName,
  });

  ConnectedBluetoothData.fromJson(Map<String, dynamic> json)
    : remoteId = json['remoteId'] as String?,
      deviceName = json['deviceName'] as String?;

  Map<String, dynamic> toJson() => {
    'remoteId' : remoteId,
    'deviceName' : deviceName
  };
}