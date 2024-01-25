import "package:adamulti_mobile_clone_new/constant/constant.dart";
import "package:adamulti_mobile_clone_new/cubit/setting_applikasi_cubit.dart";
import "package:adamulti_mobile_clone_new/locator.dart";
import "package:adamulti_mobile_clone_new/schema/inbox_schema.dart";
import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";
import "package:iconsax/iconsax.dart";
import "package:intl/intl.dart";
import "package:responsive_sizer/responsive_sizer.dart";

class InboxApplikasiItemComponent extends StatelessWidget {

  const InboxApplikasiItemComponent({ super.key,
  required this.data, required this.onTapAction, required this.onDeleteAction });

  final InboxSchema data;
  final Function onTapAction;
  final Function onDeleteAction;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTapAction();
      },
      child: Card(
        color: Colors.white,
        surfaceTintColor: data.status == 0 ? 
        HexColor.fromHex(locator.get<SettingApplikasiCubit>().state.settingData.errorColor!) :
        HexColor.fromHex(locator.get<SettingApplikasiCubit>().state.settingData.successColor!),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18)
          ),
          padding: const EdgeInsets.all(8),
          width: 100.w,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                  color: data.status == 0 ? 
                  HexColor.fromHex(locator.get<SettingApplikasiCubit>().state.settingData.errorColor!).withOpacity(0.2) : 
                  HexColor.fromHex(locator.get<SettingApplikasiCubit>().state.settingData.successColor!).withOpacity(0.2)
                ),
                child: Icon(
                  Iconsax.sms_notification5,
                  color: data.status == 0 ? 
                  HexColor.fromHex(locator.get<SettingApplikasiCubit>().state.settingData.errorColor!) :
                  HexColor.fromHex(locator.get<SettingApplikasiCubit>().state.settingData.successColor!),
                  size: 32,
                ),
              ),
              const SizedBox(width: 12,),
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(data.title, style: GoogleFonts.openSans(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: HexColor.fromHex(locator.get<SettingApplikasiCubit>().state.settingData.textColor!),
                          ),),
                          const SizedBox(height: 2,),
                          Text(data.content, 
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.openSans(
                            color: HexColor.fromHex(locator.get<SettingApplikasiCubit>().state.settingData.textColor!),
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 4,),
                          Text(DateFormat("dd-mm-yyyy hh:mm").format(data.date), 
                            maxLines: 1,
                            style: GoogleFonts.openSans(
                              color: HexColor.fromHex(locator.get<SettingApplikasiCubit>().state.settingData.textColor!),
                              fontWeight: FontWeight.w400,
                              fontSize: 10
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8,),
                    IconButton(
                      onPressed: () {
                        onDeleteAction();
                      }, 
                      icon: const Icon(Icons.delete, color: Colors.black,)
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}