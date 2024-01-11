import "package:adamulti_mobile_clone_new/components/more_screen_section_component.dart";
import "package:adamulti_mobile_clone_new/components/more_screen_shimmer.dart";
import "package:adamulti_mobile_clone_new/constant/constant.dart";
import "package:adamulti_mobile_clone_new/cubit/setting_applikasi_cubit.dart";
import "package:adamulti_mobile_clone_new/locator.dart";
import "package:adamulti_mobile_clone_new/model/kategori_with_menu_response.dart";
import "package:adamulti_mobile_clone_new/services/backoffice_service.dart";
import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:go_router/go_router.dart";
import "package:google_fonts/google_fonts.dart";
import "package:iconsax/iconsax.dart";

class MoreScreen extends StatelessWidget {

  const MoreScreen({ super.key });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            Iconsax.arrow_left_2,
            color: Colors.white,
            size: 30,
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
          "Semua Menu",
          style: GoogleFonts.inter(
              fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white),
        ),
      ),
      body: FutureBuilder<List<KategoriWithMenuResponse>>(
        future: locator.get<BackOfficeService>().getAllMenuByKategoriExclude(1, 11),
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.done) {
            return ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 18),
              itemBuilder: (context, index) {
                if(snapshot.data![index].menulist!.isEmpty) {
                  return const SizedBox(height: 0,);
                } else {
                  return MoreScreenSectionComponent(sectionData: snapshot.data![index]);
                }
              }, 
              separatorBuilder: (context, index) {
                return const SizedBox(height: 10,);
              }, 
              itemCount: snapshot.data!.length
            );
          } else {
            return ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 18),
              itemBuilder: (context, index) {
                return const MoreScreenShimmer();
              }, 
              separatorBuilder: (context, index) {
                return const SizedBox(height: 10,);
              }, 
              itemCount: 6
            );
          }
        },
      ),
    );
  }
}