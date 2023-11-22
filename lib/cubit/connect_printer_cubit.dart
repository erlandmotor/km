import 'package:bloc/bloc.dart';
import 'package:blue_thermal_printer/blue_thermal_printer.dart';
import 'package:equatable/equatable.dart';

part 'connect_printer_state.dart';

class ConnectPrinterCubit extends Cubit<ConnectPrinterState> {
  ConnectPrinterCubit() : super(ConnectPrinterInitial(
    isLoadingState: false,
    selectedDeviceState: BluetoothDevice("", ""),
    deviceListState: const []
  ));


  void updateState(List<BluetoothDevice> deviceList,
  BluetoothDevice selectedDevice, bool isLoading) {
    emit(ConnectPrinterInitial(deviceListState: deviceList, 
    selectedDeviceState: selectedDevice, 
    isLoadingState: false));
  }
}
