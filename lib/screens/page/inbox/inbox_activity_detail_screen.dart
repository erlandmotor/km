import "package:adamulti_mobile_clone_new/components/dynamic_size_button_outlined_icon_component.dart";
import "package:adamulti_mobile_clone_new/constant/constant.dart";
import "package:adamulti_mobile_clone_new/cubit/setting_applikasi_cubit.dart";
import "package:adamulti_mobile_clone_new/locator.dart";
import "package:adamulti_mobile_clone_new/schema/inbox_schema.dart";
import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:go_router/go_router.dart";
import "package:google_fonts/google_fonts.dart";
import "package:iconsax/iconsax.dart";
import "package:responsive_sizer/responsive_sizer.dart";

class InboxActivityDetailScreen extends StatelessWidget {

  const InboxActivityDetailScreen({ super.key, required this.data });

  final InboxSchema data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor.fromHex(locator.get<SettingApplikasiCubit>().state.settingData.lightColor!),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Iconsax.arrow_circle_left,
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
          "Detail Inbox",
          style: GoogleFonts.openSans(
            fontSize: 16, 
            fontWeight: FontWeight.w600, 
            color: Colors.white
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(data.title, style: GoogleFonts.openSans(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: HexColor.fromHex(locator.get<SettingApplikasiCubit>().state.settingData.textColor!)
              ),),
              const Divider(),
              const SizedBox(height: 18,),
              Container(
                width: 100.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: kKeteranganContainerColor,
                ),
                padding: const EdgeInsets.all(8),
                child: Text(data.content, style: GoogleFonts.robotoMono(
                  fontSize: 12,
                  fontWeight: FontWeight.w500
                ),)
              ),
              const SizedBox(height: 18,),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  DynamicSizeButtonOutlinedIconComponent(
                    label: "Share", 
                    buttonColor: HexColor.fromHex(locator.get<SettingApplikasiCubit>().state.settingData.secondaryColor!), 
                    onPressed: () {}, 
                    width: 30.w, 
                    height: 30, 
                    icon: Iconsax.share5
                  ),
                  const SizedBox(width: 8,),
                  DynamicSizeButtonOutlinedIconComponent(
                    label: "Salin Text", 
                    buttonColor: Colors.black, 
                    onPressed: () {}, 
                    width: 150, 
                    height: 30, 
                    icon: Iconsax.copy5
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}