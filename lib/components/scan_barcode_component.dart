import "package:adamulti_mobile_clone_new/components/dynamic_snackbar.dart";
import "package:adamulti_mobile_clone_new/constant/constant.dart";
import "package:adamulti_mobile_clone_new/cubit/setting_applikasi_cubit.dart";
import "package:adamulti_mobile_clone_new/locator.dart";
import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:flutter_barcode_scanner/flutter_barcode_scanner.dart";
import "package:iconsax/iconsax.dart";

class ScanBarcodeComponent extends StatelessWidget {

  const ScanBarcodeComponent({ super.key, required this.onScanResult });

  final Function onScanResult;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        try {
          FlutterBarcodeScanner.scanBarcode("#ff6666", "Cancel", false, ScanMode.DEFAULT).then((scanResult)  {
            onScanResult(scanResult);
          });
        } on PlatformException {
          showDynamicSnackBar(
            context, 
            Iconsax.warning_2, 
            "ERROR", 
            "Gagal Mendapatkan Versi Platform Anda.", 
            HexColor.fromHex(locator.get<SettingApplikasiCubit>().state.settingData.errorColor!)
          );
        }
      },
      child: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          color: Colors.black.withOpacity(0.2)
        ),
        child: const Center(
          child: Icon(Iconsax.scan_barcode, color: Colors.black,),
        ),
      ),
    );
  }
}