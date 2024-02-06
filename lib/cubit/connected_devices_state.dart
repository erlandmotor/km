part of 'connected_devices_cubit.dart';

sealed class ConnectedDevicesState extends Equatable {
  const ConnectedDevicesState({ required this.isConnected, required this.connectedDevice, required this.connectedDeviceName });

  final bool isConnected;
  final BluetoothDevice connectedDevice;
  final String connectedDeviceName;

  @override
  List<Object> get props => [
    isConnected,
    connectedDevice,
    connectedDeviceName
  ];
}

final class ConnectedDevicesInitial extends ConnectedDevicesState {
  final bool isConnectedState;
  final BluetoothDevice connectedDeviceState;
  final String connectedDeviceNameState;

  const ConnectedDevicesInitial({ required this.isConnectedState, required this.connectedDeviceState, required this.connectedDeviceNameState }) :
  super(isConnected: isConnectedState, connectedDevice: connectedDeviceState, connectedDeviceName: connectedDeviceNameState);
}
