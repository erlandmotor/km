import "package:adamulti_mobile_clone_new/constant/constant.dart";
import "package:adamulti_mobile_clone_new/cubit/setting_applikasi_cubit.dart";
import "package:adamulti_mobile_clone_new/locator.dart";
import "package:adamulti_mobile_clone_new/model/artikel_data.dart";
import "package:cached_network_image/cached_network_image.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:google_fonts/google_fonts.dart";
import "package:intl/intl.dart";
import "package:responsive_sizer/responsive_sizer.dart";

class ArtikelItemComponent extends StatelessWidget {

  const ArtikelItemComponent({ super.key,
  required this.data, required this.onTapAction, required this.containerColor });

  final ArtikelData data;
  final Function onTapAction;
  final Color containerColor;

  static final dateFormat = DateFormat("yyyy-MM-dd hh:mm");

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTapAction();
      },
      child: Card(
        color: Colors.white,
        surfaceTintColor: containerColor,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18)
          ),
          width: 100.w,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    BlocBuilder<SettingApplikasiCubit, SettingApplikasiState>(
                      bloc: locator.get<SettingApplikasiCubit>(),
                      builder: (_, state) {
                        return Container(
                          alignment: Alignment.center,
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(18),
                            color: HexColor.fromHex(state.settingData.lightColor!)
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: CachedNetworkImage(
                              imageUrl: "$baseUrlAuth/files/berita/image/${data.coverImage!}",
                              width: 42,
                              height: 42,
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      }
                    ),
                    const SizedBox(width: 12,),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            data.title!,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis, 
                            style: GoogleFonts.openSans(
                            fontSize: 14,
                            fontWeight: FontWeight.w600
                          ),),
                          const SizedBox(height: 4,),
                          Text(dateFormat.format(DateTime.parse(data.createdAt!)), style: GoogleFonts.openSans(
                            fontSize: 12,
                            fontWeight: FontWeight.w400
                          ),)
                        ],
                      ),
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