import "dart:async";
import "dart:convert";

import "package:adamulti_mobile_clone_new/components/container_gradient_background.dart";
import "package:adamulti_mobile_clone_new/components/custom_container_appbar.dart";
import "package:adamulti_mobile_clone_new/components/dynamic_size_button_component.dart";
import "package:adamulti_mobile_clone_new/components/dynamic_snackbar.dart";
import "package:adamulti_mobile_clone_new/components/light_decoration_container_component.dart";
import "package:adamulti_mobile_clone_new/constant/constant.dart";
import "package:adamulti_mobile_clone_new/cubit/connected_devices_cubit.dart";
import "package:adamulti_mobile_clone_new/cubit/setting_applikasi_cubit.dart";
import "package:adamulti_mobile_clone_new/locator.dart";
import "package:adamulti_mobile_clone_new/model/connected_bluetooth_data.dart";
import "package:adamulti_mobile_clone_new/services/secure_storage.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:google_fonts/google_fonts.dart";
import "package:iconsax/iconsax.dart";
import "package:print_bluetooth_thermal/print_bluetooth_thermal.dart";
import "package:responsive_sizer/responsive_sizer.dart";
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

class ConnectPrinterScreen extends StatefulWidget {

  const ConnectPrinterScreen({ super.key });

  @override
  State<ConnectPrinterScreen> createState() => _ConnectPrinterScreenState();
}

class _ConnectPrinterScreenState extends State<ConnectPrinterScreen> {

  late StreamSubscription<BluetoothAdapterState> bluetoothSubscription;

  @override
  void initState() {

    bluetoothSubscription = FlutterBluePlus.adapterState.listen((state) {
      if(state == BluetoothAdapterState.on) {
        PrintBluetoothThermal.connectionStatus.then((isConnectedStatus) {
          if(isConnectedStatus == false) {
            locator.get<SecureStorageService>().readSecureData("printer").then((value) {
              if(value != null) {
                final deviceObject = ConnectedBluetoothData.fromJson(jsonDecode(value));
                final device = BluetoothDevice.fromId(deviceObject.remoteId!);
                // device.connect().then((_) {
                //   locator.get<ConnectedDevicesCubit>().updateState(true, device, deviceObject.deviceName!);
                // });
                PrintBluetoothThermal.connect(macPrinterAddress: deviceObject.remoteId!);
                locator.get<ConnectedDevicesCubit>().updateState(true, device, deviceObject.deviceName!);
              }
            });
          }
        });
      }
    });
    // locator.get<SecureStorageService>().deleteSecureData("printer");
    super.initState();
  }


  @override
  void dispose() {
    bluetoothSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ContainerGradientBackground(
          child: Stack(
            children: [
              const Column(
                children: [
                  SizedBox(
                    height: 150,
                  ),
                  Expanded(
                    child: LightDecorationContainerComponent()
                  )
                ],
              ),
              Column(
                children: [
                  const CustomContainerAppBar(title: "Connect Printer", height: 80),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      surfaceTintColor: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            StreamBuilder<BluetoothAdapterState>(
                              stream: FlutterBluePlus.adapterState,
                              builder: (context, snapshot) {
                                return Column(
                                  children: [
                                    Container(
                                      width: 96.w,
                                      padding: const EdgeInsets.all(18),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(
                                          width: 0.5,
                                          color: HexColor.fromHex(locator.get<SettingApplikasiCubit>().state.settingData.lightTextColor!)
                                        )
                                      ),
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              CircleAvatar(
                                                backgroundColor: snapshot.data == BluetoothAdapterState.off ? 
                                                HexColor.fromHex(locator.get<SettingApplikasiCubit>().state.settingData.errorColor!) : const Color(0xff0a3b8c),
                                                child: const Icon(Iconsax.bluetooth, color: Colors.white,),
                                              ),
                                              const SizedBox(width: 12,),
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      snapshot.data == BluetoothAdapterState.off ?
                                                      "Bluetooth Tidak Aktif"
                                                      : "Bluetooth Aktif", style: GoogleFonts.openSans(
                                                      fontSize: 14,
                                                      fontWeight: FontWeight.w500,
                                                      color: Colors.black
                                                    ),),
                                                    const SizedBox(height: 4,),
                                                    BlocBuilder<ConnectedDevicesCubit, ConnectedDevicesState>(
                                                      bloc: locator.get<ConnectedDevicesCubit>(),
                                                      builder: (_, stateConnected) {
                                                        if(snapshot.data == BluetoothAdapterState.off) {
                                                          return Text("Nyalakan Bluetooth Anda.", style: GoogleFonts.openSans(
                                                            fontSize: 12,
                                                            color: HexColor.fromHex(locator.get<SettingApplikasiCubit>().state.settingData.textColor!)
                                                          ),);
                                                        } else if(snapshot.data == BluetoothAdapterState.on && stateConnected.isConnected == true) {
                                                          return Text("Connected : ${stateConnected.connectedDeviceName}", style: GoogleFonts.openSans(
                                                            fontSize: 12,
                                                            color: HexColor.fromHex(locator.get<SettingApplikasiCubit>().state.settingData.textColor!)
                                                          ),);
                                                        } else {
                                                          return Text("Silahkan Pilih Printer untuk Dikoneksikan.", style: GoogleFonts.openSans(
                                                            fontSize: 12,
                                                            color: HexColor.fromHex(locator.get<SettingApplikasiCubit>().state.settingData.textColor!)
                                                          ),);
                                                        }
                                                      }
                                                    )
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        ],
                                      )
                                    ),
                                    if(snapshot.data == BluetoothAdapterState.on) const SizedBox(height: 18,),
                                    if(snapshot.data == BluetoothAdapterState.on) DynamicSizeButtonComponent(
                                      label: "Scan Device", 
                                      buttonColor: HexColor.fromHex(locator.get<SettingApplikasiCubit>().state.settingData.secondaryColor!), 
                                      onPressed: () {
                                        FlutterBluePlus.startScan();
                                      }, 
                                      width: 100.w, 
                                      height: 50
                                    ),
                                  ],
                                );
                              }
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8,),
                  Expanded(
                    child: StreamBuilder<List<ScanResult>>(
                      stream: FlutterBluePlus.scanResults,
                      builder: (context, snapshot) {
                        if(snapshot.data != null) {
                            if(snapshot.data!.isEmpty) {
                            return const SizedBox();
                          } else {
                            return StreamBuilder<bool>(
                              stream: FlutterBluePlus.isScanning, 
                              builder: (context, snapshot2) {
                                if(snapshot.data!.isEmpty) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                } else {
                                  return ListView.separated(
                                    padding: const EdgeInsets.all(8),
                                    itemBuilder: (context, index) {
                                      return Card(
                                        color: Colors.white,
                                        surfaceTintColor: Colors.white,
                                        child: ListTile(
                                          leading: CircleAvatar(
                                            backgroundColor: HexColor.fromHex(locator.get<SettingApplikasiCubit>().state.settingData.infoColor!),
                                            child: const Icon(Iconsax.printer, color: Colors.white,),
                                          ),
                                          title: Text(
                                            snapshot.data![index].device.advName,
                                            style: GoogleFonts.openSans(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black
                                            ),
                                          ),
                                          onTap: () {
                                            PrintBluetoothThermal.connectionStatus.then((isConnectedStatus) {
                                              if(isConnectedStatus) {
                                                PrintBluetoothThermal.disconnect.then((disconnect) {
                                                  PrintBluetoothThermal.connect(macPrinterAddress: snapshot.data![index].device.remoteId.str).then((value) {
                                                    locator.get<SecureStorageService>().writeSecureData("printer", jsonEncode(ConnectedBluetoothData(
                                                      remoteId: snapshot.data![index].device.remoteId.str,
                                                      deviceName: snapshot.data![index].device.advName
                                                    )));
                                                    locator.get<ConnectedDevicesCubit>().updateState(true, snapshot.data![index].device, snapshot.data![index].device.advName);
                                                    showDynamicSnackBar(context, 
                                                      Iconsax.info_circle, 
                                                      "Koneksi Perangkat Bluetooth", 
                                                      "Berhasil terhubung dengan perangkat ${snapshot.data![index].device.advName}", 
                                                      Colors.blue
                                                    );
                                                  });
                                                });
                                              } else {
                                                PrintBluetoothThermal.connect(macPrinterAddress: snapshot.data![index].device.remoteId.str).then((value) {
                                                  locator.get<SecureStorageService>().writeSecureData("printer", jsonEncode(ConnectedBluetoothData(
                                                    remoteId: snapshot.data![index].device.remoteId.str,
                                                    deviceName: snapshot.data![index].device.advName
                                                  )));
                                                  locator.get<ConnectedDevicesCubit>().updateState(true, snapshot.data![index].device, snapshot.data![index].device.advName);
                                                  showDynamicSnackBar(context, 
                                                    Iconsax.info_circle, 
                                                    "Koneksi Perangkat Bluetooth", 
                                                    "Berhasil terhubung dengan perangkat ${snapshot.data![index].device.advName}", 
                                                    Colors.blue
                                                  );
                                                });
                                              }
                                            });
                                          },
                                          subtitle: Text(
                                            snapshot.data![index].device.remoteId.str,
                                            style: GoogleFonts.openSans(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.black
                                            ),
                                          ),
                                          trailing: BlocBuilder<ConnectedDevicesCubit, ConnectedDevicesState>(
                                            bloc: locator.get<ConnectedDevicesCubit>(),
                                            builder: (_, state) {
                                              return SizedBox(
                                                child: snapshot.data![index].device == state.connectedDevice && state.isConnected ? 
                                                const Icon(Iconsax.tick_circle, color: Colors.green,) : null,
                                              );
                                            },
                                          )
                                        ),
                                      );
                                    }, 
                                    separatorBuilder: (context, index) {
                                      return const SizedBox(height: 6,);
                                    }, 
                                    itemCount: snapshot.data!.length
                                  );
                                }
                              }
                            );
                          }
                        } else {
                          return const SizedBox();
                        }
                      },
                    )
                  )
                ],
              )
            ],
          )
        )
      ),
    );
  }
}