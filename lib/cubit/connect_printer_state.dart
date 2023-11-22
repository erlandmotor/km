part of 'connect_printer_cubit.dart';

sealed class ConnectPrinterState extends Equatable {
  const ConnectPrinterState({ required this.deviceList, required this.selectedDevice,
  required this.isLoading });

  final List<BluetoothDevice> deviceList;
  final BluetoothDevice selectedDevice;
  final bool isLoading;  

  @override
  List<Object> get props => [
    deviceList,
    selectedDevice,
    isLoading
  ];
}

final class ConnectPrinterInitial extends ConnectPrinterState {

  final List<BluetoothDevice> deviceListState;
  final BluetoothDevice selectedDeviceState;
  final bool isLoadingState;

  const ConnectPrinterInitial({ required this.deviceListState,
  required this.selectedDeviceState, required this.isLoadingState }) : 
  super(deviceList: deviceListState, selectedDevice: selectedDeviceState, isLoading: isLoadingState);
}
