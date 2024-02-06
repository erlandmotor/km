import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

part 'connected_devices_state.dart';

class ConnectedDevicesCubit extends Cubit<ConnectedDevicesState> {
  ConnectedDevicesCubit() : super(ConnectedDevicesInitial(isConnectedState: false, 
  connectedDeviceNameState: "",
  connectedDeviceState: BluetoothDevice(
    remoteId: const DeviceIdentifier(""))));

  void updateState(bool isConnected, BluetoothDevice connectedDevice, String connectedDeviceName) {
    emit(ConnectedDevicesInitial(isConnectedState: isConnected, connectedDeviceState: connectedDevice, connectedDeviceNameState: connectedDeviceName));
  }
}
