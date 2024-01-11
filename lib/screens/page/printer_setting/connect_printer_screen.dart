import "dart:convert";

import "package:adamulti_mobile_clone_new/components/container_gradient_background.dart";
import "package:adamulti_mobile_clone_new/components/custom_container_appbar.dart";
import "package:adamulti_mobile_clone_new/components/dynamic_size_button_component.dart";
import "package:adamulti_mobile_clone_new/components/dynamic_snackbar.dart";
import "package:adamulti_mobile_clone_new/components/light_decoration_container_component.dart";
import "package:adamulti_mobile_clone_new/constant/constant.dart";
import "package:adamulti_mobile_clone_new/cubit/connect_printer_cubit.dart";
import "package:adamulti_mobile_clone_new/cubit/setting_applikasi_cubit.dart";
import "package:adamulti_mobile_clone_new/locator.dart";
import "package:adamulti_mobile_clone_new/services/secure_storage.dart";
import "package:blue_thermal_printer/blue_thermal_printer.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:google_fonts/google_fonts.dart";
import "package:iconsax/iconsax.dart";
import "package:responsive_sizer/responsive_sizer.dart";

class ConnectPrinterScreen extends StatefulWidget {

  const ConnectPrinterScreen({ super.key });

  @override
  State<ConnectPrinterScreen> createState() => _ConnectPrinterScreenState();
}

class _ConnectPrinterScreenState extends State<ConnectPrinterScreen> {

  final blueThermalPrinter = BlueThermalPrinter.instance;

  @override
  void initState() {
    blueThermalPrinter.isOn.then((isOn) {
      if(isOn!) {
        blueThermalPrinter.isConnected.then((value) {
          if(value == false) {
            locator.get<SecureStorageService>().readSecureData("printer").then((value) {
              if(value != null) {
                final deviceObject = jsonDecode(value);
                final device = BluetoothDevice.fromMap(deviceObject);
                blueThermalPrinter.connect(device);
                locator.get<ConnectPrinterCubit>().updateState(
                  [],
                  device,
                  false
                );
              }
            });
          }
        });
      }
    });
    super.initState();
  }


  @override
  void dispose() {
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
              Padding(
                padding: const EdgeInsets.all(18),
                child: Column(
                  children: [
                    const CustomContainerAppBar(title: "Connect Printer", height: 80),
                    const SizedBox(height: 10,),
                    Expanded(
                      child: Card(
                        surfaceTintColor: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 100.w,
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    width: 0.5,
                                    color: HexColor.fromHex(locator.get<SettingApplikasiCubit>().state.settingData.lightTextColor!)
                                  )
                                ),
                                child: StreamBuilder<int?>(
                                  stream: blueThermalPrinter.onStateChanged(),
                                  builder: (context, snapshot) {
                                    if(snapshot.data == BlueThermalPrinter.STATE_OFF) {
                                      locator.get<ConnectPrinterCubit>().updateState(
                                        [], 
                                        locator.get<ConnectPrinterCubit>().state.selectedDevice, 
                                        false
                                      );
                                    } else {
                                      locator.get<SecureStorageService>().readSecureData("print").then((value) {
                                        if(value != null) {
                                          final deviceObject = jsonDecode(value);
                                          final device = BluetoothDevice.fromMap(deviceObject);
                                          locator.get<ConnectPrinterCubit>().updateState(
                                            [],
                                            device,
                                            false
                                          );
                                        }
                                      });
                                    }
                                    return Row(
                                      children: [
                                        CircleAvatar(
                                          backgroundColor: snapshot.data == BlueThermalPrinter.STATE_OFF ? 
                                          Colors.red : const Color(0xff0a3b8c),
                                          child: const Icon(Iconsax.bluetooth, color: Colors.white,),
                                        ),
                                        const SizedBox(width: 12,),
                                        BlocBuilder<ConnectPrinterCubit, ConnectPrinterState>(
                                          bloc: locator.get<ConnectPrinterCubit>(),
                                          builder: (_, state) {
                                            return Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  snapshot.data == BlueThermalPrinter.STATE_OFF ?
                                                  "Bluetooth Tidak Aktif"
                                                  : "Bluetooth Aktif", style: GoogleFonts.inter(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.black
                                                ),),
                                                const SizedBox(height: 4,),
                                                Text(snapshot.data == BlueThermalPrinter.STATE_OFF ? 
                                                  "Nyalakan Bluetooth Anda." : 
                                                  snapshot.data == BlueThermalPrinter.CONNECTED ? 
                                                  state.selectedDevice.name! :
                                                   "Pilih Device Printer Anda", style: GoogleFonts.inter(
                                                  fontSize: 12,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w400
                                                ),)
                                              ],
                                            );
                                          },
                                        )
                                      ],
                                    );
                                  }
                                ),
                              ),
                              const SizedBox(height: 18,),
                              DynamicSizeButtonComponent(
                                label: "Scan Device", 
                                buttonColor: HexColor.fromHex(locator.get<SettingApplikasiCubit>().state.settingData.secondaryColor!), 
                                onPressed: () {
                                  blueThermalPrinter.isOn.then((isOn) {
                                    if(isOn == true) {
                                      locator.get<ConnectPrinterCubit>().updateState(
                                        locator.get<ConnectPrinterCubit>().state.deviceList, 
                                        locator.get<ConnectPrinterCubit>().state.selectedDevice, 
                                        true
                                      );

                                      blueThermalPrinter.getBondedDevices().then((value) {
                                        locator.get<ConnectPrinterCubit>().updateState(
                                          value, 
                                          locator.get<ConnectPrinterCubit>().state.selectedDevice, 
                                          false
                                        );
                                      }).catchError((e) {
                                        showDynamicSnackBar(
                                          context, 
                                          Iconsax.warning_2, 
                                          "ERROR", 
                                          "Terjadi Kesalahan dengan Bluetooth", 
                                          Colors.red
                                        );
                                      });
                                    } else {
                                      showDynamicSnackBar(
                                        context, 
                                        Iconsax.warning_2, 
                                        "ERROR", 
                                        "Nyalakan Bluetooth Anda Terlebih Dahulu", 
                                        Colors.red
                                      );
                                    }
                                  });
                                  
                                }, 
                                width: 100.w, 
                                height: 50
                              ),
                              const SizedBox(height: 18,),
                              Expanded(
                                child: BlocBuilder<ConnectPrinterCubit, ConnectPrinterState>(
                                  bloc: locator.get<ConnectPrinterCubit>(),
                                  builder: (_, state) {
                                    if(state.isLoading) {
                                      return const Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    } else {
                                      return ListView.separated(
                                        itemBuilder: (context, index) {
                                          return ListTile(
                                            leading: CircleAvatar(
                                              backgroundColor: HexColor.fromHex(locator.get<SettingApplikasiCubit>().state.settingData.infoColor!),
                                              child: Icon(Iconsax.printer, color: HexColor.fromHex(locator.get<SettingApplikasiCubit>().state.settingData.lightTextColor!),),
                                            ),
                                            title: Text(
                                              state.deviceList[index].name!,
                                              style: GoogleFonts.inter(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.black
                                              ),
                                            ),
                                            onTap: () {
                                              blueThermalPrinter.isConnected.then((isConnected) {
                                                if(isConnected! == false) {
                                                  blueThermalPrinter.connect(state.deviceList[index]).then((_) {
                                                    locator.get<ConnectPrinterCubit>().updateState(
                                                      locator.get<ConnectPrinterCubit>().state.deviceList, 
                                                      state.deviceList[index], 
                                                      false
                                                    );

                                                    locator.get<SecureStorageService>().writeSecureData("printer", jsonEncode(state.deviceList[index].toMap()));

                                                    showDynamicSnackBar(context, 
                                                      Iconsax.info_circle, 
                                                      "Koneksi Perangkat Bluetooth", 
                                                      "Berhasil terhubung dengan perangkat ${state.deviceList[index].name}", 
                                                      Colors.blue
                                                    );
                                                  }).catchError((_) {
                                                    showDynamicSnackBar(
                                                      context, 
                                                      Iconsax.warning_2, 
                                                      "ERROR", 
                                                      "Gagal Menghubungkan Printer", 
                                                      Colors.red
                                                    );
                                                  });
                                                } else {
                                                  blueThermalPrinter.disconnect();

                                                  blueThermalPrinter.connect(state.deviceList[index]).then((_) {
                                                    locator.get<ConnectPrinterCubit>().updateState(
                                                      locator.get<ConnectPrinterCubit>().state.deviceList, 
                                                      state.deviceList[index], 
                                                      false
                                                    );

                                                    locator.get<SecureStorageService>().writeSecureData("printer", jsonEncode(state.deviceList[index].toMap()));
                                                    
                                                    showDynamicSnackBar(context, 
                                                      Iconsax.info_circle, 
                                                      "Koneksi Perangkat Bluetooth", 
                                                      "Berhasil terhubung dengan perangkat ${state.deviceList[index].name}", 
                                                      Colors.blue
                                                    );
                                                  }).catchError((_) {
                                                    showDynamicSnackBar(
                                                      context, 
                                                      Iconsax.warning_2, 
                                                      "ERROR", 
                                                      "Gagal Menghubungkan Printer", 
                                                      Colors.red
                                                    );
                                                  });
                                                }
                                              });
                                            },
                                            subtitle: Text(
                                              state.deviceList[index].address!,
                                              style: GoogleFonts.inter(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400,
                                                color: Colors.black
                                              ),
                                            ),
                                            trailing: BlocBuilder<ConnectPrinterCubit, ConnectPrinterState>(
                                              bloc: locator.get<ConnectPrinterCubit>(),
                                              builder: (_, state) {
                                                return SizedBox(
                                                  child: state.deviceList.isNotEmpty && 
                                                  state.deviceList[index] == state.selectedDevice ? 
                                                  const Icon(Iconsax.tick_circle, color: Colors.green,) : null,
                                                );
                                              },
                                            ),
                                          );
                                        }, 
                                        separatorBuilder: (context, index) {
                                          return const Divider();
                                        }, 
                                        itemCount: state.deviceList.length
                                      );
                                    }
                                  },
                                )
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          )
        )
      ),
    );
  }
}