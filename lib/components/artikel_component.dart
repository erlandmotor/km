import "package:adamulti_mobile_clone_new/constant/constant.dart";
import "package:adamulti_mobile_clone_new/model/artikel_data.dart";
import "package:auto_size_text/auto_size_text.dart";
import "package:cached_network_image/cached_network_image.dart";
import "package:flutter/material.dart";
import "package:go_router/go_router.dart";
import "package:google_fonts/google_fonts.dart";
import "package:responsive_sizer/responsive_sizer.dart";

class ArtikelComponent extends StatelessWidget {

  const ArtikelComponent({ super.key, required this.artikelData, required this.surfaceColor });

  final List<ArtikelData> artikelData;
  final Color surfaceColor;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            context.pushNamed("artikel-detail", extra: {
              "artikelId": artikelData[index].id!
            });
          },
          child: Card(
            semanticContainer: true,
            surfaceTintColor: surfaceColor,
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8)
            ),
            child: SizedBox(
              width: 44.w,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 100.w,
                    height: 120,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(8),
                        topRight: Radius.circular(8)
                      ),
                      image: DecorationImage(
                        image: CachedNetworkImageProvider("$baseUrlAuth/files/berita/image/${artikelData[index].coverImage!}"),
                        fit: BoxFit.cover
                      )
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AutoSizeText(
                        artikelData[index].title!, 
                        maxLines: 2,
                        minFontSize: 2,
                        maxFontSize: 12,
                        style: GoogleFonts.openSans(
                          fontSize: 12,
                          fontWeight: FontWeight.w500
                        ),),
                        // BlocBuilder<SettingApplikasiCubit, SettingApplikasiState>(
                        //   bloc: locator.get<SettingApplikasiCubit>(),
                        //   builder: (_, state) {
                        //     return ElevatedButton(
                        //       style: ElevatedButton.styleFrom(
                        //         fixedSize: Size(30.w, 5),
                        //         backgroundColor: HexColor.fromHex(state.settingData.secondaryColor!),
                        //       ),
                        //       onPressed: () {
                        //         context.pushNamed("artikel-detail", extra: {
                        //           "artikelId": artikelData[index].id!
                        //         });
                        //       }, 
                        //       child: AutoSizeText("Selengkapnya", 
                        //       minFontSize: 2,
                        //       maxFontSize: 12,
                        //       maxLines: 1,
                        //       style: GoogleFonts.openSans(
                        //         fontSize: 12,
                        //         fontWeight: FontWeight.w500,
                        //         color: Colors.white
                        //       ),)
                        //     );
                        //   },
                        // )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      }, 
      separatorBuilder: (context, index) {
        return const SizedBox(width: 8,);
      }, 
      itemCount: artikelData.length
    );
  }
}