import "package:adamulti_mobile_clone_new/constant/constant.dart";
import "package:adamulti_mobile_clone_new/cubit/setting_applikasi_cubit.dart";
import "package:adamulti_mobile_clone_new/locator.dart";
import "package:adamulti_mobile_clone_new/model/notification_paginate_response.dart";
import "package:adamulti_mobile_clone_new/services/notification_service.dart";
import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:go_router/go_router.dart";
import "package:google_fonts/google_fonts.dart";
import "package:flutter_html/flutter_html.dart";
import "package:iconsax/iconsax.dart";
import "package:responsive_sizer/responsive_sizer.dart";

class InboxDetailScreen extends StatelessWidget {

  const InboxDetailScreen({ super.key, required this.notificationId });

  final int notificationId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white),
        ),
      ),
      body: Stack(
        children: [
          Container(
            width: 100.w,
            height: 100.h,
            decoration: BoxDecoration(
              color: HexColor.fromHex(locator.get<SettingApplikasiCubit>().state.settingData.lightColor!),
              image: const DecorationImage(
                image: AssetImage("assets/pattern-samping.png"),
                fit: BoxFit.fill
              )
            ),
          ),
          FutureBuilder<NotificationData>(
            future: locator.get<NotificationService>().findUnique(notificationId),
            builder: (context, snapshot) {
              if(snapshot.connectionState == ConnectionState.done) {
                return Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(snapshot.data!.title!, style: GoogleFonts.openSans(
                          fontSize: 16,
                          fontWeight: FontWeight.w600
                        ),),
                        const Divider(),
                        const SizedBox(height: 18,),
                        Html(
                          data: """
                          ${snapshot.data!.content!}
                          """
                        )
                      ],
                    ),
                  ),
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } 
            },
          ),
        ],
      )
    );
  }
}