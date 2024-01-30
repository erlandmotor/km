import "package:adamulti_mobile_clone_new/components/container_gradient_background.dart";
import "package:adamulti_mobile_clone_new/components/custom_container_appbar.dart";
import "package:adamulti_mobile_clone_new/components/dynamic_size_button_component.dart";
import "package:adamulti_mobile_clone_new/components/light_decoration_container_component.dart";
import "package:adamulti_mobile_clone_new/constant/constant.dart";
import "package:adamulti_mobile_clone_new/cubit/setting_applikasi_cubit.dart";
import "package:adamulti_mobile_clone_new/locator.dart";
import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";
import "package:iconsax/iconsax.dart";
import "package:responsive_sizer/responsive_sizer.dart";
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

class ConnectPrinterScreen extends StatefulWidget {

  const ConnectPrinterScreen({ super.key });

  @override
  State<ConnectPrinterScreen> createState() => _ConnectPrinterScreenState();
}

class _ConnectPrinterScreenState extends State<ConnectPrinterScreen> {

  @override
  void initState() {
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
              Column(
                children: [
                  const CustomContainerAppBar(title: "Connect Printer", height: 80),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        surfaceTintColor: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
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
                                child: StreamBuilder<BluetoothAdapterState>(
                                  stream: FlutterBluePlus.adapterState,
                                  builder: (context, snapshot) {
                                    return Column(
                                      children: [
                                        Row(
                                          children: [
                                            CircleAvatar(
                                              backgroundColor: snapshot.data == BluetoothAdapterState.off ? 
                                              HexColor.fromHex(locator.get<SettingApplikasiCubit>().state.settingData.errorColor!) : const Color(0xff0a3b8c),
                                              child: const Icon(Iconsax.bluetooth, color: Colors.white,),
                                            ),
                                            const SizedBox(width: 12,),
                                            Column(
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
                                                Text(snapshot.data == BluetoothAdapterState.off ? 
                                                  "Nyalakan Bluetooth Anda." : 
                                                  snapshot.data == BluetoothAdapterState.unknown ? 
                                                  "Terconnect ke Printer" :
                                                    "Pilih Device Printer Anda", style: GoogleFonts.openSans(
                                                  fontSize: 12,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w400
                                                ),)
                                              ],
                                            )
                                          ],
                                        ),
                                        if(snapshot.data == BluetoothAdapterState.on) DynamicSizeButtonComponent(
                                          label: "Scan Device", 
                                          buttonColor: HexColor.fromHex(locator.get<SettingApplikasiCubit>().state.settingData.secondaryColor!), 
                                          onPressed: () {
                                            
                                          }, 
                                          width: 100.w, 
                                          height: 50
                                        ),
                                      ],
                                    );
                                  },
                                )
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          )
        )
      ),
    );
  }
}