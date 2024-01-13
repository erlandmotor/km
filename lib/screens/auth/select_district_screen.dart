import "package:adamulti_mobile_clone_new/constant/constant.dart";
import "package:adamulti_mobile_clone_new/cubit/select_region_cubit.dart";
import "package:adamulti_mobile_clone_new/cubit/setting_applikasi_cubit.dart";
import "package:adamulti_mobile_clone_new/locator.dart";
import "package:adamulti_mobile_clone_new/model/districts_response.dart";
import "package:adamulti_mobile_clone_new/services/region_service.dart";
import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:go_router/go_router.dart";
import "package:google_fonts/google_fonts.dart";
import "package:iconsax/iconsax.dart";

class SelectDistrictScreen extends StatelessWidget {

  const SelectDistrictScreen({ super.key, required this.selectRegionCubit,
  required this.districtController });

  final SelectRegionCubit selectRegionCubit;
  final TextEditingController districtController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor.fromHex(locator.get<SettingApplikasiCubit>().state.settingData.lightColor!),
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            Iconsax.arrow_circle_left,
            color: Colors.white,
            size: 36,
          ),
          onPressed: () {
            context.pop();
          },
        ),
        backgroundColor: HexColor.fromHex(locator.get<SettingApplikasiCubit>().state.settingData.mainColor1!),
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: HexColor.fromHex(locator.get<SettingApplikasiCubit>().state.settingData.mainColor1!),
            systemNavigationBarColor: Colors.white,
            statusBarBrightness: Brightness.dark,
            statusBarIconBrightness: Brightness.light,
            systemNavigationBarIconBrightness: Brightness.light,
            systemNavigationBarDividerColor: Colors.white),
        title: Text(
          "Pilih Kecamatan",
          style: GoogleFonts.openSans(
              fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white),
        ),
      ),
      body: FutureBuilder<DistrictsResponse>(
        future: locator.get<RegionService>().getDistricts(selectRegionCubit.cityId),
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.done) {
            if(snapshot.hasError) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return ListView.separated(
                itemCount: snapshot.data!.data!.total!,
                itemBuilder: (context, index) {
                  return ListTile(
                    onTap: () {
                      districtController.text = snapshot.data!.data!.districts![index].districtName!;

                      selectRegionCubit.updateDistrictState(snapshot.data!.data!.districts![index].districtId!);

                      context.pop();
                    },
                    title: Text(
                      snapshot.data!.data!.districts![index].districtName!,
                      style: GoogleFonts.openSans(
                        fontSize: 16,
                        fontWeight: FontWeight.w500
                      ),
                    ),
                    trailing: const Icon(Iconsax.arrow_right_3, size: 20,),
                  );
                },
                separatorBuilder: (context, index) {
                  return const Divider();
                },
              );
            }
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}